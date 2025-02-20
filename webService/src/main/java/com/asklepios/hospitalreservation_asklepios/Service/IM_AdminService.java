package com.asklepios.hospitalreservation_asklepios.Service;

import com.asklepios.hospitalreservation_asklepios.Repository.IF_AdminMapper;
import com.asklepios.hospitalreservation_asklepios.VO.HospitalVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IM_AdminService implements IF_AdminService{

  @Autowired
  IF_AdminMapper adminMapper;

  @Override
  public List<HospitalVO> viewAllHospital() {
      return adminMapper.selectAllHospital();
  }
}
