package com.asklepios.hospitalreservation_asklepios.SecurityConfig;

import com.asklepios.hospitalreservation_asklepios.Service.IF_UserService;
import com.asklepios.hospitalreservation_asklepios.VO.MemberVO;
import com.asklepios.hospitalreservation_asklepios.VO.UserVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
@RequiredArgsConstructor
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {
    private final IF_UserService userService;
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        System.out.println("getclientRegistraion: "+userRequest.getClientRegistration().getRegistrationId());
        System.out.println("getAccessToken: "+userRequest.getAccessToken());
        System.out.println("getAttributes:"+super.loadUser(userRequest).getAttributes());

        OAuth2User oAuth2User = super.loadUser(userRequest);

        String provider=userRequest.getClientRegistration().getRegistrationId();
        String provideId=oAuth2User.getAttribute("sub");
        String email=oAuth2User.getAttribute("email");
        String username=oAuth2User.getAttribute("name");
        String userId=provider.charAt(0)+"_"+email.split("@")[0];
        String password="Oauth2";
        String role="scClient";

        Optional<UserVO>user= Optional.ofNullable(userService.printOneInfo(userId));
        //DB에 저장여부 확인
        if(user.isEmpty()){
            UserVO newUser=UserVO.builder()
                    .user_id(userId)
                    .user_email(email)
                    .user_name(username)
                    .user_password(password)
                    .user_authority(role)
                    .build();
           userService.addUserCommonInfo(newUser);
           return new PrincipalDetails(newUser,oAuth2User.getAttributes());
        }
        return super.loadUser(userRequest);
    }
}
