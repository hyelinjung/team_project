package com.asklepios.hospitalreservation_asklepios.VO;

import lombok.Data;

import java.util.List;

@Data
public class QuestionlistVO {
    private int id;
    private String title;
    private String content;
    private String date;
    private String tag;
    private String sub;
    private String user_name;
    private List<Question_imgVO> imgs;
    private List<QuestionlistVO> answerlist; //큐앤에이 자세히 볼때 답변들을 담는다
    private String[] tagList;  //수정-혜린
    private String[] aiContentSplit; //ai 답변 . 기준으로 띄어쓰기 결과값 담는 변수

}
