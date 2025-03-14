package com.asklepios.hospitalreservation_asklepios.Controller;

import com.asklepios.hospitalreservation_asklepios.Service.IF_UserService;
import com.asklepios.hospitalreservation_asklepios.Util.Profile_ImageUtil;
import com.asklepios.hospitalreservation_asklepios.VO.DoctorVO;
import com.asklepios.hospitalreservation_asklepios.VO.MemberVO;
import com.asklepios.hospitalreservation_asklepios.VO.UserVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.UUID;


@Controller
public class JoinController {

    @Autowired
    IF_UserService userService;

    @Autowired
    Profile_ImageUtil profileImageUtil;
    public UserVO rollback_vo;

    @GetMapping("/agreement")
    public String agreement(Model model) throws Exception {
//        for(int i = 0; i < userService.getUserIDAndRegisterNumber().size(); i++){
//            System.out.println(userService.getUserIDAndRegisterNumber().get(i).toString());
//        };
//        model.addAttribute("userInfo", userService.getUserIDAndRegisterNumber());
        return "userJoin/insertCommonInfo";
    }

    @ResponseBody
    @PostMapping("/insertedID")
    public Integer insertedID(@RequestParam String user_id) throws Exception {
        return userService.duplicateID(user_id);
    }

    @ResponseBody
    @PostMapping("/insertedRegisterNumber")
    public Integer insertedRegisterNumber(@RequestParam String user_register_number) throws Exception {
        return userService.duplicateRegisterNumber(user_register_number);
    }

    @PostMapping(value="/commoninfo")
    public String commoninfo(@ModelAttribute UserVO userVO, @RequestParam(value = "file", required = false) MultipartFile file, Model model) throws Exception {
        System.out.println("일반 가입");
        String newFileName = profileImageUtil.storeFile(file);
        System.out.println(newFileName);
        userVO.setUser_image(newFileName);
        String doctor_id = userVO.getUser_id();
        model.addAttribute("user_id", doctor_id);
//        System.out.println(userVO.getUser_authority());
//        System.out.println(userVO.toString());
        if(userVO.getUser_authority().equals("doctor")) {
            System.out.println("의사");
            rollback_vo = userVO;
            return "userJoin/insertDoctorUserInfo";
        } else {
            System.out.println("일반");
            userService.addUserCommonInfo(userVO);
            return "userJoin/successJoin";
        }

    }

    //뒤로가기인지 파악해서 처리 - 기존 코드를 재사용하여 불필요한 코드 생성 안함
    @PostMapping("/doctorinfo")
    public String doctorinfo(@ModelAttribute DoctorVO doctorVO,@RequestParam(required = false) String rollback) throws Exception {
        System.out.println("의사가입");
        try {
            String flag; //롤백확인
            DoctorVO vo = new DoctorVO(); //공통 저장 객체
            if (rollback != null) {
                flag = rollback;
            }else{
                flag =" normal";
                vo = doctorVO;
            }
            vo.setUser_doctor_code(UUID.randomUUID().toString());
            userService.addUserDoctorInfo(vo,rollback_vo,flag);
        }catch (RuntimeException e){
            System.out.println("오류발생:"+e.getMessage());
        }
        return "userJoin/successJoin";
    }

    @GetMapping("/socialInfo")
    public String socialInfo(Model model, HttpServletResponse response, HttpServletRequest request) throws IOException {
        model.addAttribute("user", userService.findMember());
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.getWriter().println("<script> alert('추가 정보 작성을 위해 해당 페이지로 이동합니다.');</script>");
//        response.getWriter().close();
        return "userJoin/insertSocialCommonInfo";
    }
    @PostMapping("/saveSocialInfo")
    public String saveSocialInfo(@ModelAttribute("user") UserVO user
            ,@RequestParam(value = "file", required = false) MultipartFile file ) throws Exception {
        String newFileName = profileImageUtil.storeFile(file);
        MemberVO member = userService.findMember();
        user.setUser_authority("ROLE_scClient");
        user.setUser_id(member.getUser_id());
        user.setUser_password("Oauth2");
        user.setUser_image(newFileName);
        System.out.println(user.toString());
        userService.modifySocialUserCommonInfo(user);
        return "redirect:/home";
    }
    @GetMapping("/showAgreement")
    public String showAgreement(){
        return "userJoin/socialAgreement";
    }
}
