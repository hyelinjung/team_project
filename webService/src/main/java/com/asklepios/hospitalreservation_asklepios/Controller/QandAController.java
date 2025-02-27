package com.asklepios.hospitalreservation_asklepios.Controller;

import com.asklepios.hospitalreservation_asklepios.Service.IM_QandAService;
import com.asklepios.hospitalreservation_asklepios.VO.QuestionVO;
import com.asklepios.hospitalreservation_asklepios.VO.Question_imgVO;
import com.asklepios.hospitalreservation_asklepios.VO.QuestionlistVO;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import com.asklepios.hospitalreservation_asklepios.Service.IF_UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;




@Controller
public class QandAController {
  @Autowired
  IF_UserService userservice;
  @Autowired
  private IM_QandAService service;


  //html에 hidden으로 추가함-혜린
  @GetMapping("/qanda")
  public String qna(Model model) {
    //model.addAttribute("user",  userservice.findMember());
    //유저id만 필요!
    model.addAttribute("userId",get_userId());
    model.addAttribute("user", userservice.findMember());
    return "qanda/questionForm";
  }




  //질문저장 -> 저장 후 파이썬 api 서버에 요청
  @PostMapping("/qnaSubmit")
  public ResponseEntity<Object> qnaSubmit(@RequestParam(value = "file",required = false) List< MultipartFile > file
          , @ModelAttribute QuestionVO questionVO) {
    int result =0;
    System.out.println("들어온:"+questionVO);
    //질문을 작성한 사용자 확인
    questionVO.setUser_id(get_userId());
    try {
      if (file==null || file.isEmpty()){
        System.out.print("file: 없음 ");
        result =service.save_text(questionVO);
        //return result ?ResponseEntity.ok().body("success"):ResponseEntity.badRequest().body("fail");
      }else {
        result =service.save_text_w_img(file,questionVO);
      }
      System.out.println(result);
      return new ResponseEntity<>(result, HttpStatus.OK);
    }catch (Exception e){
      System.out.println(e.getMessage());
      return new ResponseEntity<>(result,HttpStatus.BAD_REQUEST);
    }


  }


  //답변 저장
  @PostMapping("/answer")
  public String answer_doctor(@ModelAttribute QuestionVO vo){
    boolean result = service.answer(vo,get_userId());
    return "redirect:/home";
  }
  //큐엔에이 리스트 가져오기
  @GetMapping("/qandaList")
  public String qandalist(Model model){
    model.addAttribute("user", userservice.findMember());
    check_unread();
    List<QuestionlistVO> list =service.getList();
    System.out.println(list);
    //tag 분할 -수정 -혜린
    for(QuestionlistVO vo:list){
      if (vo.getTag() != null) {
        String[] temp = vo.getTag().split("\\s*,\\s*");
        System.out.println(Arrays.toString(temp));
        vo.setTagList(temp);
        System.out.println(vo);
      }
    }
    model.addAttribute("list",list);
    return "qanda/questionList";
  }


  //현재 사용자 구하기
  public String get_userId(){
    String result="";
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
      result = ((UserDetails) authentication.getPrincipal()).getUsername();
      System.out.println(result);
      //lin99
      return result;
    }
    return result;
  }

  //질문 자세히 보기
  @GetMapping("/show")
  public String show(int id,Model model){
    model.addAttribute("user", userservice.findMember());
    int count =0; //의사 답변 수
    int written_user =0;
    QuestionlistVO vo = service.showdetail(id);
    //읽은 질문글이 내가 작성한 질문글인지 확인하는 부분
    String u = get_userId();
    System.out.println("유저확인:"+u);
    if (u.equals(vo.getSub())){
      written_user =1;
    }
    /*written_user= (u.equals(vo.getSub()))? 1 :0 ; //작성자가 본인 글을 봤을 경우 1*/
    //tag 처리
    if (vo.getTag() !=null){
      String[] temp = vo.getTag().split("\\s*,\\s*");
      vo.setTagList(temp);
    }
    vo.setId(id);
    System.out.println("시간확인"+vo.getDate());
    String date = vo.getDate(); //질문글 날짜
    String result = getWrittenTime(date);
    System.out.print("전처리 시간"+result);
    vo.setDate(result);
    //이미지 전처리
    for(Question_imgVO q :vo.getImgs()){
      System.out.println("이미지 전처리");
      String img_url = "/getImg/"+q.getFileName();
      q.setFileName(img_url);
    }
    //회원 이름 전처리
    String[]name = vo.getUser_name().split("");
    String first = name[0]+"**";
    System.out.println(first);
    vo.setUser_name(first);

    //하루 동안 답변이 달렸는지 확인 - 질문글을 기준으로 첫 답변이 한시간 이상 차이나는 경우
    if (vo.getAnswerlist().isEmpty()||check_answer_time(vo.getAnswerlist(),date)){
      //ai 답변 가져오기
      if (service.get_aiAnswer(id).isEmpty()){
        System.out.println("해당 ai 데이터 없음");
      }else {
        System.out.println("ai 답변 진행중");
        List<QuestionlistVO> ai = service.get_aiAnswer(id);
        String[] str = ai.get(0).getContent().split("\\.");
        System.out.println(str.length);
        ai.get(0).setAiContentSplit(str);
        System.out.println("ai확인"+ai.get(0));
        //vo.getAnswerlist().add(ai.get(0));
        //ai 답변은 의사 답변이 하나도 없는 경우 1시간 이후에 보여줘야한다.
        if (check_answer_time(ai,date)){
          vo.getAnswerlist().add(ai.get(0));
        }

      }
    }

    //의사답변 시간 전처리
    for(QuestionlistVO answer :vo.getAnswerlist()){
      if (answer.getTitle() !=null){ //의사 이미지 전처리
        answer.setTitle("/profile_image/"+answer.getTitle());
        String[] doctorAnswer = answer.getContent().split("\\.");
        System.out.println("1");
        System.out.println(Arrays.toString(doctorAnswer));
        answer.setContentSplit(doctorAnswer);
      }else{
        answer.setTitle("/Img/defaultDoctor.png");
        String[] doctorAnswer = answer.getContent().split("\\.");
        System.out.println("1");
        System.out.println(Arrays.toString(doctorAnswer));
        answer.setContentSplit(doctorAnswer);
      }
      String answer_date =answer.getDate();
      answer.setDate(getWrittenTime(answer_date));
      count++;
      System.out.println("사용자"+written_user);
      System.out.println("오류잡"+vo);
      if (written_user==1){
        if (answer.getAiContentSplit() != null){
          System.out.println("ai!!");
          service.changeUnreadCountService(id,0,1);
        }else {
          System.out.println("일반!!");
          service.changeUnreadCountService(id,1,1);
        }
      }

    }

    System.out.println("확인!!");
    int unread = check_unread();
    System.out.println("unread"+unread);
    System.out.println(vo);
    model.addAttribute("unReadCount",unread);
    model.addAttribute("list",vo);
    model.addAttribute("count",count);
    return "qanda/questionDetail";
  }

  //의사 답변 화면 - 질문 제목이 필요한 경우
  @GetMapping("/answerPage")
  public String answerPage(int questionId,Model model){
    String subject = service.getSubject(questionId);
    model.addAttribute("user", userservice.findMember());
    model.addAttribute("id",questionId);
    model.addAttribute("qna_title",subject);
    return "qanda/questionAnswerForm";
  }

  //게시글 작성 시간과 현재 시간을 계산함
  String getWrittenTime(String db_date){
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    LocalDateTime formatted_date = LocalDateTime.parse(db_date,formatter);
    LocalDateTime current_time =LocalDateTime.now();
    Duration get_between_date = Duration.between(formatted_date,current_time);
    long day = get_between_date.toDays();
    long hour =get_between_date.toHours();
    long minutes =get_between_date.toMinutes();
    System.out.printf("day:hour:minutes %d:%d:%d",day,hour,minutes);
        /*현재 시간을 기준으로 1시간 이하 차이 -> 몇 분전 으로 표시
        초 차이 -> 방금 전으로 표시
        * 1시간 차이 -> 몇 시간 전으로 표시
        * 하루 차이 -> 몇 일전으로 표시*/
    if (day>6){
      System.out.print("7일 넘게 차이남");
      System.out.print("시간"+db_date);
      String a =formatted_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
      String[] arr = Arrays.copyOfRange(a.split(""), 0, 11);
      return String.join("",arr);

    }else if(day>0){
      System.out.print("day를 기준으로 차이남");
      return day+"일 전";
    }else if (hour>0){
      System.out.print("hour를 기준으로 차이남");
      return hour+"시간 전";
    }else if (minutes>0){
      System.out.print("minutes를 기준으로 차이남");
      return minutes+"분 전";
    }else {
      return "방금 전";
    }

  }

  //ai 답변 성립하는지 조건 확인
  boolean check_answer_time(List<QuestionlistVO> list,String question_date){
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    Duration d;
    if (list.isEmpty()){
      return false;
    }
    if (list.get(0).getAiContentSplit() !=null){ //ai답변인경우 현재시간과 질문글 작성시간 비교
      LocalDateTime question_date_format = LocalDateTime.parse(question_date,formatter);
      LocalDateTime now = LocalDateTime.now();
      d =Duration.between(question_date_format,now);
    }else{//일반 답변인 경우 질문글과 답변글 작성시간 비교
      String date = list.get(0).getDate();
      LocalDateTime localDateTime = LocalDateTime.parse(date,formatter);
      LocalDateTime question_date_format = LocalDateTime.parse(question_date,formatter);
      d =Duration.between(question_date_format,localDateTime);
    }
    if (d.toMinutes()>60){
      return true; //ai 답변 필요
    }else {
      return false;
    }
  }

  /*질문글 읽음 확인 체크 함수*/
  //ai는 질문과 동시에 저장되므로 시간 확인해야함
  public int check_unread() {
    int count =0;
    String user = get_userId();
    if (!user.isEmpty()) {
      if (userservice.getAuthority(user)) { //일반 회원일 경우만
        System.out.println(Arrays.toString(service.getAnswer_unread(user)));
        for (char a : service.getAnswer_unread(user)) {
          if (a == '0') {
            count++;
          }
        }

        for (char b : service.getAi_unread(user)) {
          if (b == '0') {
            count++;
          }
        }
      }
    }
    return count;
  }

}
