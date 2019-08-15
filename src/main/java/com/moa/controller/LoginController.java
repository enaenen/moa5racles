package com.moa.controller;

import com.moa.model.service.FindUserInfoService;
import com.moa.model.service.MemberInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";
    @Qualifier("memberService")
    @Autowired
    private MemberInfoService memberInfoService;
    @Autowired
    private FindUserInfoService findUserInfoService;

    @RequestMapping(value="/login")
    public String loginPage(String error, String logout, Model model){
        System.out.println("loginPage()...");
        return "login";
    }

    @RequestMapping(value = "/checkEmail", method = RequestMethod.POST)
    @ResponseBody
    public String checkEmail(@RequestParam(value = "email") String email){
        Map<String, Object> duplicationInfo = new HashMap<>();

        duplicationInfo.put("email", email);

        //이메일 중복이 있는 경우 true 반환
        if (memberInfoService.signUpDuplicationCheck(duplicationInfo))
            return FAIL;
        else
            return SUCCESS;
    }

    @RequestMapping(value = "/checkNick", method = RequestMethod.POST)
    @ResponseBody
    public String checkNick(@RequestParam(value = "nick") String nick) {
        Map<String, Object> duplicationInfo = new HashMap<>();

        duplicationInfo.put("nick", nick);

        //닉네임 중복이 있는 경우 true 반환
        if (memberInfoService.signUpDuplicationCheck(duplicationInfo))
            return FAIL;
        else
            return SUCCESS;
    }
    // 회원가입
    @RequestMapping(value="/registration", method=RequestMethod.GET)
    public String registeration() {
        return "registration";
    }

    @RequestMapping(value="/registration", method=RequestMethod.POST)
    @ResponseBody
    public boolean registerationForm(
            @RequestParam String name,
            @RequestParam String nickname,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String phone,
            @RequestParam String postcode,
            @RequestParam String address,
            @RequestParam String detailAddress,
            @RequestParam String latitude,
            @RequestParam String longitude) {
//        System.out.println(name);
//        System.out.println(nickname);
//        System.out.println(email);
//        System.out.println(password);
//        System.out.println(phone);
//        System.out.println(postcode);
//        System.out.println(address);
//        System.out.println(detailAddress);
//        System.out.println(latitude);
//        System.out.println(longitude);
        return true;
    }

    // 아이디, 비밀번호 찾기
    @RequestMapping(value = "/searchId", method = RequestMethod.GET)
    public String searchId() {
        return "searchId";
    }

    @RequestMapping(value = "/searchId", method = RequestMethod.POST)
    public @ResponseBody String isIdSearched(
            @RequestParam String name,
            @RequestParam String phone) {
        Map<String, Object> findEmailInfo = new HashMap<String, Object>();

        findEmailInfo.put("name", name);
        findEmailInfo.put("phoneNumber", phone);

        return findUserInfoService.findEmail(findEmailInfo);
    }

    @RequestMapping(value = "/searchPassword", method = RequestMethod.GET)
    public String searchPassword() {
        return "searchPassword";
    }

    @RequestMapping(value = "/searchPassword", method = RequestMethod.POST)
    public @ResponseBody
    boolean isPasswordSearched(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String phone) {
        Map<String, Object> findPasswordInfo = new HashMap<String, Object>();

        findPasswordInfo.put("name", name);
        findPasswordInfo.put("phoneNumber", phone);
        findPasswordInfo.put("email", email);

        return findUserInfoService.findPassword(findPasswordInfo);
    }

    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    public @ResponseBody
    boolean updatePassword(
            @RequestParam String email,
            @RequestParam String password) {
        boolean result = true;

        return result;
    }
}
