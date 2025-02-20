package com.asklepios.hospitalreservation_asklepios.Repository;

import com.asklepios.hospitalreservation_asklepios.VO.HospitalVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IF_AdminMapper {
  public List<HospitalVO> selectAllHospital();
  public void approveHospital(String hospital_name);
  public void disapproveHospital(String hospital_name);
}
