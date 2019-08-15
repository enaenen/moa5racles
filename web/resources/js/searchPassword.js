function submit() {
    if (!isValid()) {
        return;
    }

    let name = $('#name').val();
    let email = $('#email').val();
    let phone = $('#phone').val();

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajax({
        type: "POST",
        url: "/searchPassword",
        data: {name, email, phone},
        cache: false,
        beforeSend: function (xhr) {
            xhr.setRequestHeader("AJAX", true);
            xhr.setRequestHeader(header, token);
        },
        success(data) {
            if (data == true) {
                $('#content1').hide();
                $('#content2').show();
            } else {
                alert("입력한 정보를 찾을 수 없습니다.");
            }
        }, error() {
            console.log("전송 오류");
        }

    })

    //전송 구현 필요
}

function submitPassword() {
    if(!isPasswordValid()) {
        return;
    }
    if(!isPassword2Valid()) {
        return;
    }

    let password = $('#password').val();
    let password2 = $('#password2').val();

    if(password!=password2) {
        window.alert("비밀번호가 일치하지 않습니다");
        return;
    }

    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajax({
        type: "POST",
        url: "/updatePassword",
        data: {password},
        cache: false,
        beforeSend: function (xhr) {
            xhr.setRequestHeader("AJAX", true);
            xhr.setRequestHeader(header, token);
        },
        success(data) {
            if (data) {
                window.alert("비밀번호가 변경되었습니다");
                window.close();
            } else {
                alert("비밀번호 수정에 실패하였습니다");
            }
        }, error: function (request, status, error) {
            console.log("전송 오류");
        }

    });
}

function isValid() {
    if (!isNameValid()) {
        return false;
    }
    if (!isEmailValid()) {
        return false;
    }
    if (!isPhoneValid()) {
        return false;
    }
    return true;
}

function isNameValid() {
    let name = $('#name').val();
    if (name == null || name == "") {
        $('#name').css("color", "#DD0000");
        $('#name').css("font-size", "11pt");
        $('#name').val("이름을 입력해주세요");
        return false;
    }
    if (name == "이름을 입력해주세요")
        return false;
    return true;
}

function isEmailValid() {
    let email = $('#email').val();
    if (email == null || email == "") {
        $('#email').css("color", "#DD0000");
        $('#email').css("font-size", "11pt");
        $('#email').val("이메일을 입력해주세요");
        return false;
    }
    if (email == "이메일을 입력해주세요")
        return false;
    return true;
}

function isPhoneValid() {
    let phone = $('#phone').val();
    if (phone == null || phone == "") {
        $('#phone').css("color", "#DD0000");
        $('#phone').css("font-size", "11pt");
        $('#phone').val('휴대폰 인증 버튼을 눌러주세요');
        return false;
    }
    if (phone == "휴대폰 인증 버튼을 눌러주세요")
        return false;
    return true;
}

function emptyName() {
    if ($('#name').val() == "이름을 입력해주세요") {
        $('#name').val("");
        $('#name').css("color", "#555555");
        $('#name').css("font-size", "14pt");
    }
}

function emptyEmail() {
    if ($('#email').val() == "이메일을 입력해주세요") {
        $('#email').val("");
        $('#email').css("color", "#555555");
        $('#email').css("font-size", "14pt");
    }
}

function emptyPhone() {
    if ($('#phone').val() == "휴대폰 인증 버튼을 눌러주세요") {
        $('#phone').val("");
        $('#phone').css("color", "#555555");
        $('#phone').css("font-size", "14pt");
    }
}

function isPasswordValid() {
    let password = $('#password').val();
    if(password==null || password.trim()=="") {
        $('#password').css("border", "solid 0.2px red");
        return false;
    }
    return true;
}

function isPassword2Valid() {
    let password2 = $('#password2').val();
    if(password2==null || password2.trim()=="") {
        $('#password2').css("border", "solid 0.2px red");
        return false;
    }
    return true;
}

function emptyPassword() {
    if(!isPasswordValid()) {
        $('#password').css("border", "none");
    }
}

function emptyPassword2() {
    if(!isPassword2Valid()) {
        $('#password2').css("border", "none");
    }
}

function smsCheck(){
    let width = 500;
    let height = 600;
    let popUpUrl = "https://www.accountkit.com/v1.0/basic/dialog/sms_login/?app_id=2291269470991007&redirect=http%3A%2F%2Flocalhost%3A8089%2Fregistration&state=112133&fbAppEventsEnabled=true&debug=true";	//팝업창에 출력될 페이지 URL
    let popUpX = (window.screen.width / 2) - (width / 2);
    let popUpY = (window.screen.height / 2) - (height / 2);
    let popUpOption = "width=" + width + ", height=" + height + ", resizable=no, " +
        "scrollbars=yes, status=no, left=" + popUpX + ",top=" + popUpY + ";";

    window.open(popUpUrl, "", popUpOption);
}