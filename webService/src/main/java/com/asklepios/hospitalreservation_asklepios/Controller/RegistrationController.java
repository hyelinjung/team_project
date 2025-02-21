package com.asklepios.hospitalreservation_asklepios.Controller;

import com.asklepios.hospitalreservation_asklepios.Service.IF_RegistrationService;
import com.asklepios.hospitalreservation_asklepios.Service.IF_UserService;
import com.asklepios.hospitalreservation_asklepios.Util.CertificationUtil;
import com.asklepios.hospitalreservation_asklepios.VO.HospitalVO;
import com.asklepios.hospitalreservation_asklepios.VO.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class RegistrationController {
  @Autowired
  IF_UserService userservice;

  @Autowired
  IF_RegistrationService registrationservice;

  @Autowired
  private CertificationUtil certificationutil;

  @GetMapping("/registration")
  public String registration(Model model) {
    model.addAttribute("user",  userservice.findMember());
    return "registration/registrationForm";
  }

  @ResponseBody
  @PostMapping("/duplicateHospital")
  public boolean duplicateHospital(@RequestParam("hospital_address") String hospitalAddress,
                                  @RequestParam("hospital_name") String hospitalName) {
    return registrationservice.duplicateCheck(hospitalAddress, hospitalName);
  }

  @PostMapping("/register")
  public String register(@ModelAttribute HospitalVO hospitalvo, @RequestParam("file") MultipartFile file) {

    try {
      if (file != null && !file.isEmpty()) {
        // PDF 파일 저장 및 저장된 파일명 반환
        String storedFileName = certificationutil.storeFile(file);
        System.out.println(storedFileName);
        hospitalvo.setHospital_certification(storedFileName); // DB에 파일명 저장
      }
      registrationservice.registerHospital(hospitalvo);
    } catch (Exception e) {
      e.printStackTrace();
      throw new RuntimeException("파일 저장 중 오류 발생"+ e.getMessage(), e);
    }

    return "redirect:/home";
  }
}
