package com.asklepios.hospitalreservation_asklepios.Controller;

import com.asklepios.hospitalreservation_asklepios.Service.IF_AdminService;
import com.asklepios.hospitalreservation_asklepios.Service.IF_UserService;
import com.asklepios.hospitalreservation_asklepios.VO.HospitalVO;
import com.asklepios.hospitalreservation_asklepios.VO.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
public class AdminController {

  @Autowired
  private IF_UserService userService;

  @Autowired
  private IF_AdminService adminService;

  @Value("${upload.file.path2}")  // 파일 저장 경로
  private String filePath;

  // 병원 관리 페이지
  @GetMapping("/hospitalManagement")
  public String HospitalManage(Model model) {
    MemberVO user = userService.findMember();
    model.addAttribute("user", user);
    return "admin/hospitalManagement";
  }

  // 병원 리스트 조회 API
  @ResponseBody
  @GetMapping("/viewHospitalList")
  public List<HospitalVO> viewHospital() {
    return adminService.viewAllHospital();
  }

  // 병원 승인 API
  @ResponseBody
  @GetMapping("/approval")
  public void approveHospital(@RequestParam("hospital_name")String hospital_name) {
    System.out.println(hospital_name);
    adminService.approveHospital(hospital_name);
  }

  // 병원 거절 API
  @ResponseBody
  @GetMapping("/disapproval")
  public void disapproveHospital(@RequestParam("hospital_name")String hospital_name) {
    System.out.println(hospital_name);
    adminService.disapproveHospital(hospital_name);
  }

  // PDF 파일 다운로드 API
  @GetMapping("/downloadCertification")
  @ResponseBody
  public ResponseEntity<Resource> downloadFile(@RequestParam("filename") String filename) {
    try {
      // 파일 경로 설정
      Path path = Paths.get(filePath, filename);
      Resource resource = new FileSystemResource(path);

      // 파일이 존재하지 않으면 404 반환
      if (!resource.exists()) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
      }

      // 파일 이름 UTF-8 인코딩 (한글 깨짐 방지)
      String encodedFilename = URLEncoder.encode(filename, "UTF-8").replace("+", "%20");

      // Content-Disposition 설정 (모든 브라우저 호환)
      String contentDisposition = "attachment; filename=\"" + filename + "\"; filename*=UTF-8''" + encodedFilename;

      // Content-Disposition 설정 방식 수정
      HttpHeaders headers = new HttpHeaders();
      headers.add(HttpHeaders.CONTENT_DISPOSITION, contentDisposition);
      headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
      headers.setContentType(MediaType.parseMediaType("application/pdf"));
      headers.setContentLength(resource.contentLength());

      return ResponseEntity.ok()
              .headers(headers)
              .body(resource);

    } catch (UnsupportedEncodingException e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    } catch (Exception e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
  }
}
