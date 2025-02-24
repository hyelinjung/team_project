package com.asklepios.hospitalreservation_asklepios.VO;

import lombok.Data;

@Data
public class BoardVO {
    private String board_sequence;
    private String board_user_id;
    private String board_category;
    private String board_title;
    private String board_content;
    private String board_binary;
    private Integer board_viewcount;
    private String board_date;
    private Integer board_goodcount;

}
