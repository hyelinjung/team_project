package com.asklepios.hospitalreservation_asklepios.Service;

import com.asklepios.hospitalreservation_asklepios.VO.HospitalVO;

import java.util.List;

public interface IF_AdminService {
  public List<HospitalVO> viewAllHospital();
  public void approveHospital(String hospital_name);
  public void disapproveHospital(String hospital_name);
}
