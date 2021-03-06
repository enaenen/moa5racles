function showImage(fileCallPath) {
    $(".bigPictureWrapper").css("display", "flex").show();
    $(".bigPicture").html("<img src ='/display?fileName=/" + encodeURI(fileCallPath) + "'" +
        "onerror="+'"'+"this.src='" +
        "/resources/image/loading.gif" +
        "'"+'"' +
        ">")
        .animate({width: '100%', height: '100%'}, 1000);
}

$(document).ready(function () {

    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; // 5MB
    var cloneObj = $(".uploadDiv").clone(); // input type = file 은 readonly라서 div를 clone
    var uploadResult = $(".uploadResult ul");
    var attachImg = 'resources/image/cookie.png';
    var thumbnail = 'thumbnail_';

    $(".bigPictureWrapper").on("click", function (e) {
        $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
        setTimeout(function () {
            $(".bigPictureWrapper").hide();
        }, 1000);
    });

    $("#load").hide();

    function clickList(tr) {
        alert(tr);
    }

    $('.productInfo').click(function () {
        var tr = $(this).closest('tr');
        var id = tr.attr('id');

        $.ajax({
            type: "GET",
            url: "/mypage/requestlist/info/" + id,
            dataType: "JSON",
            success: function (data) {
                console.log(data);
                var str = '';
                str += '<div class="popup">';
                str += '<div class="rs_background"></div>'
                str += '<div class="rs_container">'
                str += '<div class="rs_wrapper">'
                str += '<div class="rs_header">'
                str += '<h1>요청 상세정보</h1>'
                str += '</div>'
                str += '<div class="rs_body">'
                str += '<div class="rs_context">'
                str += '<div class="rs_context_title">'
                str += '<h2>전달 내용</h2>'
                str += '</div>'
                str += '<div class="rs_context_contents">'
                str += '<h4>' + data.content + '</h4>'
                str += '</div>'
                str += '</div>'
                str += '<div class="rs_storage_products">'
                str += '<div class="rs_storage_products_title">'
                str += '<h2>보관 물품</h2>'
                str += '</div>'
                str += '<div class="rs_storage_products_contents">'
                str += '<table>'
                str += '<tr>'
                str += '<th>NO.</td>'
                str += '<th>카테고리</td>'
                str += '<th>물건명</td>'
                str += '<th>물건개수</td>'
                str += '</tr>'

                for (var i = 0; i < data.productName.length; i++) {
                    str += '<tr>'
                    str += '<td>' + (i + 1) + '</td>'
                    str += '<td>' + data.productCategory[i] + '</td>'
                    str += '<td>' + data.productName[i] + '</td>'
                    str += '<td>' + data.productCnt[i] + '</td>'
                    str += '</tr>'
                }

                str += '</table>'
                str += '</div>'
                str += '</div>'
                str += '<div class="rs_other">'
                str += '<div class="rs_other_title">'
                str += '<h2>기타 정보</h2>'
                str += '</div>'
                str += '<div class="rs_other_content">'
                str += '<div class="rs_price">'
                str += '<div class="rs_price_title">'
                str += '<h4>가격</h4>'
                str += '</div>'
                str += '<div class="rs_price_contents">'
                str += '<h4 class="rs_measured">측정가격 : ' + data.measuredPrice + '원</h4>'
                str += '<h4 class="rs_bargain">흥정가격 : ' + data.bargainPrice + '원</h4>'
                str += '</div>'
                str += '</div>'
                str += '<div class="rs_storage_date">'
                str += '<div class="rs_storage_date_title">'
                str += '<h4>보관기간</h4>'
                str += '</div>'
                str += '<div class="rs_storage_date_contents">'
                str += '<h4 class="rs_start_date">' + data.startDate + '</h4>'
                str += '<h4 class="rs_end_date">' + data.endDate + '</h4>'
                str += '</div>'
                str += '</div>'
                str += '<div class="rs_transaction_type">'
                str += '<div class="rs_transaction_type_title">'
                str += '<h4>거래방식</h4>'
                str += '</div>'
                str += '<div class="rs_transaction_type_contents">'
                str += '<h4>' + data.transactionType + '</h4>'
                str += '</div>'
                str += '</div>'
                str += '<div class="rs_application_date">'
                str += '<div class="rs_application_date_title">'
                str += '<h4>요청일자</h4>'
                str += '</div>'
                str += '<div class="rs_application_date_contents">'
                str += '<h4>' + data.applicationDate + '</h4>'
                str += '</div>'
                str += '</div>'
                str += '</div>'


                str += '<div class="uploadResult">';
                $(data.attachFileList).each(function (i, obj) {
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + thumbnail
                        + obj.uuid + "_" + obj.fileName);

                    str += "<li data-path='" + obj.uploadPath + "'";
                    str += "data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'";
                    str += "><div>";
                    if (obj.fileType) {
                        //GET 방식 첨부파일 이름 사용시 공백, 한글이름이 문제 되므로 encodeURIComponent() 이용
                        var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + thumbnail
                            + obj.uuid + "_" + obj.fileName);

                        //이미지 파일 원본 보여주기
                        var originPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
                        originPath = originPath.replace(new RegExp(/\\/g), "/");

                        str += "<li><a href=\"javascript:showImage('" + originPath + "');\">" +
                            "<img src='/display?fileName=/" + fileCallPath +"'" +
                            "onerror="+'"'+"this.src='" +
                            "/resources/image/loading.gif" +
                            "'"+'"'+"></a>" +
                            "</li>";
                    } else {
                        var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                        str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>"
                            + "<img src='/" + attachImg + "'>" + obj.fileName + "</a>" +
                            "</div></li>";
                    }
                });
                str += '</div>';
                str += '<div class="bigPictureWrapper">'
                    + '<div class="bigPicture">'
                    + '</div>'
                    + '</div>';


                str += '</div>'
//				str +='<div class="rs_button">'
//				str +=  '<div class="rs_confirm_button">'
//				str +=    '<button type="button" name="confirm_btn" id="confirm_btn">승인</button>'
//				str +=  '</div>'
//				str +=  '<div class="rs_refuse_button">'
//				str +=    '<button type="button" name="refuse_btn" id="refuse_btn">거절</button>'
//				str +=  '</div>'
//				str +='</div>'
                str += '</div>'
                str += '</div>'
                str += '<div class="rs_exit_btn">'
                str += '<i class="fas fa-times fos exit_btn"></i>'
                str += '</div>';
                str += '</div>';
                str += '</div>';


                $('.popup_wrapper').append(str);
                console.log('ok');
                $('.fas').click(function () {
                    $('.popup').remove();
                });

            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                alert("승인이 실패하였습니다.");
            }
        });
    });

})


var moveToInfo = function () {
//	location.href = ""
    alert("일시적으로 서비스가 중단되었습니다.");
}
var moveToMessage = function () {
//	location.href = ""
    alert("일시적으로 서비스가 중단되었습니다.");
}
var moveToTransaction = function () {
//	location.href = ""
    alert("일시적으로 서비스가 중단되었습니다.");
}
var moveToRequest = function () {
    location.href = "/mypage/requestlist/1";

}
var moveToLatest = function () {
//	location.href = ""
    alert("일시적으로 서비스가 중단되었습니다.");
}
var moveToFavorite = function () {
//	location.href = ""
    alert("일시적으로 서비스가 중단되었습니다.");
}

function getContextPath() {
    var hostIndex = location.href.indexOf(location.host) + location.host.length;
    var contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
    return contextPath;
}
