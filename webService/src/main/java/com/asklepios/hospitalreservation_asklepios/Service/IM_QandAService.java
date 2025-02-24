package com.asklepios.hospitalreservation_asklepios.Service;

import com.asklepios.hospitalreservation_asklepios.Repository.IF_QandAMapper;
import com.asklepios.hospitalreservation_asklepios.VO.QuestionVO;
import com.asklepios.hospitalreservation_asklepios.VO.Question_imgVO;
import com.asklepios.hospitalreservation_asklepios.VO.QuestionlistVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@Service
public class IM_QandAService implements IF_QandAService{

    @Value("${filePath}")
    private String path;
    @Autowired
    private IF_QandAMapper qandAMapper;

    //이미지 로컬에 저장 후에 디비 저장
    public int save_local_img(List<MultipartFile> files,int id){
        try {
            String uploadpath = new File(path).getAbsolutePath();//절대경로로 변환
            File f = new File(uploadpath);//file객체 생성
            if (!f.exists())f.mkdir();
            if (!files.isEmpty()) {
                for (MultipartFile file : files) {
                    String originalFilename = file.getOriginalFilename();
                    System.out.println(originalFilename);
                    String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
                    String local_upload = UUID.randomUUID().toString() + extension;
                    Path p = Paths.get(uploadpath + "/"+local_upload);
                    Files.write(p, file.getBytes()); //로컬에 저장
                    qandAMapper.save_qanda_img(new Question_imgVO(local_upload, id, originalFilename));
                }
            }
            return id;
        }catch (Exception e){
            System.out.println(e.getMessage()+"파일 등록 실패");
            return 0;
        }
    }


    @Override
    public int save_text_w_img(List<MultipartFile> files, QuestionVO vo) {
        System.out.println("질문 텍스트 저장");
        vo.setUser_id("lin99");
        qandAMapper.save_qanda_text(vo);
        System.out.println(vo.getId());
        return save_local_img(files,vo.getId());
    }

    @Override
    public int save_text(QuestionVO vo) {
        System.out.println("질문 텍스트 저장 사진 없이");
        try {
            return qandAMapper.save_qanda_text(vo);
        }catch (Exception e){
            System.out.println("오류:"+e.getMessage());
            return 0;
        }
    }

    @Override
    public boolean answer(QuestionVO vo, String userId) {
        try{
            QuestionVO answervo =qandAMapper.pre_getDoctorInfo(userId);
            System.out.println("answervo"+answervo);
            answervo.setId(vo.getId());
            answervo.setContent(vo.getContent());
            System.out.println("answervo"+answervo);
            //저장할 dto생성
            qandAMapper.save_answer(answervo);
        }catch (Exception e){
            System.out.println(e.getMessage());
            return false;
        }
        return true;
    }

    @Override
    public List<QuestionlistVO> getList() {
        return qandAMapper.list();
    }
    //큐앤에이 화면 자세히보기 - 질문자와 답변자 함께 가져옴
    //answer 테이블에 대부분의 정보가 들어있어서 닥터 이름만 join해서 가져오면됨
    @Override
    public QuestionlistVO showdetail(int question_id) {
        QuestionlistVO vo =qandAMapper.detailQandA(question_id);
        vo.setAnswerlist(qandAMapper.show_detail_getDoctorInfo(question_id));
        return vo;
    }
    //해당 질문 제목 가져오기
    @Override
    public String getSubject(int questionId) {
        return qandAMapper.getSubjuct(questionId);
    }

    //ai 답변 가져오기
    @Override
    public List<QuestionlistVO> get_aiAnswer(int questionId) {
        return qandAMapper.getAIAnswer(questionId);
    }

    @Override
    public Character[] getAnswer_unread(String userID) {
        return qandAMapper.get_doctor_UnReadCount(userID);
    }

    @Override
    public Character[] getAi_unread(String userID) {
        return qandAMapper.get_ai_UnReadCount(userID);
    }

    @Override
    public void changeUnreadCountService(int questionId,int beforeRead,int aferRead) {
        qandAMapper.change_unreadCount_mapper(questionId,beforeRead,aferRead);
    }

    @Override
    public List<QuestionVO> checkUnReadTime_service(String userId) {
        return qandAMapper.checkUnReadTime(userId);
    }
}
