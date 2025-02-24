package com.asklepios.hospitalreservation_asklepios.Service;

import com.asklepios.hospitalreservation_asklepios.VO.QuestionVO;
import com.asklepios.hospitalreservation_asklepios.VO.QuestionlistVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IF_QandAService {
    int save_text_w_img(List<MultipartFile> files, QuestionVO vo);
    int save_text(QuestionVO vo);
    boolean answer(QuestionVO vo,String userId);
    List<QuestionlistVO> getList();
    QuestionlistVO showdetail(int question_id);
    String getSubject(int questionId);
    //ai 답변 가져오기
    List<QuestionlistVO> get_aiAnswer(int questionId);
    //의사 답변 읽음 유무 가져오기
    Character[] getAnswer_unread(String userID);
    //ai 답변 읽음 유무 가져오기
    Character[] getAi_unread(String userID);

    //읽음 표시 변경
    void changeUnreadCountService(int questionId,int beforeRead,int aferRead);

    List<QuestionVO> checkUnReadTime_service(String userId);
}
