<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="cutil" uri="tld/Util.tld" %>
<%@ page import="com.moa.model.vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="storeBoardVO" value="${storeBoard.storeBoardVO}"/>
<c:set var="hostReputationVO" value="${storeBoard.hostReputationVO}"/>
<c:set var="thumbNail" value="thumbnail_"/>
<c:set var="pImg" value="${storeBoardVO.attachList[0]}" />
<c:set var="rImg" value="${pImg.uploadPath}/${pImg.uuid}_${pImg.fileName}"/>
<c:set var="realImg" value="/display?fileName=/${cutil:encodeURIComponent(rImg)}"/>

<fmt:formatNumber var="star" value="${hostReputationVO.starPointAvg}" maxFractionDigits="0" />
<% request.setCharacterEncoding("utf-8");%>

<html>
<head>
    <sec:csrfMetaTags/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://fonts.googleapis.com/css?family=Permanent+Marker" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js" ></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f3520184da1c100939d7dde66edf0534&libraries=services"></script>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.9.0/css/all.css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resources/css/more_information.css">
    <link rel="stylesheet"  href="/resources/css/lightslider.css"/>
    <link rel="stylesheet" href="/resources/css/gallery.css">
    <script src="https://use.fontawesome.com/d1341f9b7a.js"></script>
    <script src="/resources/js/more_information.js"></script>
    <script src="/resources/js/lightslider.js"></script>
    <script>
    $(document).ready(function() {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            $('#delete_btn').click(function(){
                var flag=confirm("정말로 삭제하시겠습니까?");
                if(flag){
                    $.ajax({
                        type:'POST',
                        url:'/storeboard/${storeBoardVO.articleNum}/delete',
                        data : '${hostReputationVO.nick}',
                        contentType: 'application/json; charset=utf-8',
                        dataType:'json',
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("AJAX", true);
                            xhr.setRequestHeader(header, token);
                        },
                        success:function (data) {
                            if(data==true) {
                                alert("삭제가 완료되었습니다.");
                                location.href = "/storeboard";
                            }
                            else
                                alert("삭제에 실패하였습니다.");
                        },
                        error:function () {
                            alert('통신에 장애가 생겼습니다, 잠시뒤 시도해주세요.');
                        }
                    });
                }
            });
            $(".img_btn").on("click",function(){
                $(".gallary_div").css('display','block');
                $(".gallary_wrap").css('visibility','visible');
                $(".lslide  img").css('visibility','visible');


            });
            $(".gallary_div").click(function(){
                $(".lslide img").css('visibility','hidden');
                $(".gallary_wrap").css('visibility','hidden');
                $(".gallary_div").css('display','none');
            })

            $('#image-gallery').lightSlider({
                gallery:true,
                item:1,
                thumbItem:5,
                autoWidth:true,
                slideMargin: 0,
                keyPress:true,
                speed:1500,
                pause:3000,
                auto:false,
                loop:true
            });
        });
    </script>
    <title>상세보기</title>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class='gallary_div'></div>
<input type="hidden" id="baseAddress" value="${storeBoardVO.baseAddress}" />
<div class="gallary_wrap">

    <div class="demo">
        <div class="item">
            <div class="clearfix">
                <ul id="image-gallery" class="gallery list-unstyled">
                    <c:forEach items="${storeBoardVO.attachList}" var="attach">
                        <c:set var="thumb" value="${attach.uploadPath}/${thumbNail}${attach.uuid}_${attach.fileName}"/>
                        <c:set var="img" value="${attach.uploadPath}/${attach.uuid}_${attach.fileName}"/>
                        <li data-thumb="/display?fileName=/${cutil:encodeURIComponent(thumb)}"  onerror="this.src='/resources/image/loading.gif'" style="width: 474px; height: 400px;">
                            <img src="/display?fileName=/${cutil:encodeURIComponent(img)}" onerror="this.src='/resources/image/loading.gif'"/>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="wrap" id="wrap">
    <div class="wrap_header">
        <div class="title" id="title"><c:out value="${storeBoardVO.title}"></c:out></div>
        <sec:authentication property="principal" var="customVO" />
        <sec:authorize access="isAuthenticated()" >
            <c:if test="${customVO.loginVO.nick eq hostReputationVO.nick}">
                <button class="delete_btn moabtn" id="delete_btn">삭제</button>
            </c:if>
        </sec:authorize>
    </div>
    <div class="wrap_content">
        <div class="host_info" id='host_info'>
            <div class="id_info info_item" id='id_info'><i class="fas fa-user"></i><div class="info_item_text">${hostReputationVO.nick}</div></div>
            <div class='like_info info_item' id='like_info'><i class="far fa-thumbs-up"></i><div class="info_item_text">${hostReputationVO.favoriteCnt}</div></div>
            <div class = 'star_info info_item' id='star_info'><i class="far fa-star"></i>
                <div class="info_item_text">
                    <c:choose>
                        <c:when test="${star < 1}">
                            <c:out value="0"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${hostReputationVO.starPointAvg}" pattern=".0"/>
                        </c:otherwise>
                    </c:choose>
                    (${hostReputationVO.totalReviewCnt})
                </div>
            </div>
            <div class="summary_info" id='summary_info'>
                <table class="summary_info_tb" style="width:150px;">

                    <tr>
                        <th>보관지 형태</th>
                        <td>${storeBoardVO.storageType}</td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td>${storeBoardVO.detailPrice["1달"]}원/5호박스 (1달)</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td >${fn:substring(storeBoardVO.baseAddress,0,20)}  </td>
                    </tr>
                    <tr>
                        <th>배송</th>
                        <td>${storeBoardVO.transactionType}</td>
                    </tr>
                    <tr>
                        <th>반려동물</th>
                        <td>
                            <c:choose>
                                <c:when test="${storeBoardVO.pet != '없음' }">있음</c:when>
                                <c:otherwise> 없음</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>보안시설</th>
                        <td>
                            ${storeBoardVO.securityFacility}
                        </td>
                    </tr>
                    <tr>
                        <th>보관 금지 물품</th>
                        <td>
                            <c:choose>
                                <c:when test="${storeBoardVO.forbiddenProduct != null }">
                                    ${fn:substring(storeBoardVO.forbiddenProduct,0,15)}
                                </c:when>
                                <c:otherwise> 없음</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <button class='entrust_btn moabtn' id='entrust_btn' onclick="location.href='/entrust/${storeBoardVO.articleNum}'">보관해주세요</button>
            </div>
        </div>

        <div class="image_info" id='image_info'>
            <div class="prev_img" id='prev_img'><img class='prev_image' id='prev_image' src="${realImg}" onerror="setDefault(this)"/></div>
            <div class="img_btn" id='img_btn'><img class ='img_icon'src="${realImg}" onerror="this.src='/resources/image/loading.gif'"/></div>
            <div class="like_btn" id="like_btn"><i class="far fa-heart"></i></div>
        </div>
    </div>
    <div class='desc_info'>상세 정보</div>
    <div class="wrap_content_footer">
        <div class="more_info" id='more_info'>
            <c:choose>
                <c:when test="${storeBoardVO.storageType == '집'}">
                    <div class="more_info_icon"><i class="fas fa-home"></i>  </div>
                </c:when>
                <c:when test="${storeBoardVO.storageType == '회사'}">
                    <div class="more_info_icon"><i class="fas fa-city"></i>  </div>
                </c:when>
                <c:when test="${storeBoardVO.storageType == '상가'}">
                    <div class="more_info_icon"><i class="fas fa-store"></i>  </div>
                </c:when>
                <c:when test="${storeBoardVO.storageType == '기타'}">
                    <div class="more_info_icon"><i class="fas fa-warehouse"></i>  </div>
                </c:when>
            </c:choose>
            <div class="more_info_desc">${storeBoardVO.storageType}</div>
            <span >보관지 형태<div class='more_info_item'><div style="font-size: 15px">${storeBoardVO.storageType}</div></div></span>
        </div>
        <div class="more_info" id='more_info'>
            <div class="more_info_icon"><i class="fas fa-money-bill"></i>  </div>
            <div class="more_info_desc">${storeBoardVO.detailPrice["1달"]}원</div>
            <span>금액<div class='more_info_item'>
                <div style="font-size: 11px">5호박스 기준으로 측정한 가격입니다.</div>
          <table class='item_price_tb' >
            <tr>
              <th>1일</th>
              <td>${storeBoardVO.detailPrice["1일"]}원</td>
            </tr>
            <tr>
              <th>1주</th>
              <td>${storeBoardVO.detailPrice["1주일"]}원</td>
            </tr>
            <tr>
              <th>1개월</th>
              <td>${storeBoardVO.detailPrice["1달"]}원</td>
            </tr>
            <tr>
              <th>6개월</th>
              <td>${storeBoardVO.detailPrice["6개월"]}원</td>
            </tr>
            <tr>
              <th>1년</th>
              <td>${storeBoardVO.detailPrice["1년"]}원</td>
            </tr>
          </table>
          </div></span>
        </div>
        <c:if test="${storeBoardVO.pet != '없음' }">
            <div class="more_info" id='more_info'>
                <div class="more_info_icon"><i class="fas fa-dog"></i>  </div>
                <div class="more_info_desc">있음</div>
                <span>반려동물<div class='more_info_item'>${storeBoardVO.pet}</div></span>
            </div>
        </c:if>
        <div class="more_info" id='more_info'>
            <div class="more_info_icon"><i class="fas fa-map-marker-alt"></i>  </div>
            <c:if test="${distance eq null}">
                <div class="more_info_desc">주소</div>
            </c:if>
            <div class="more_info_desc">${distance}</div>
            <span>주소<div class='more_info_item' style="font-size: 15px">${storeBoardVO.baseAddress} ${storeBoardVO.detailAddress}</div></span>
        </div>
        <div class="more_info" id='more_info'>
            <c:choose>
                <c:when test="${storeBoardVO.transactionType == '택배'}">
                    <div class="more_info_icon"><i class="fas fa-truck"></i>  </div>
                </c:when>
                <c:when test="${storeBoardVO.transactionType == '직거래'}">
                    <div class="more_info_icon"><i class="fas fa-people-carry"></i>  </div>
                </c:when>
                <c:when test="${storeBoardVO.transactionType == '무관'}">
                    <div class="more_info_icon"><i class="fas fa-shipping-fast"></i>  </div>
                </c:when>
            </c:choose>
            <div class="more_info_desc">${storeBoardVO.transactionType}</div>
            <span>배송 여부<div class='more_info_item'>${storeBoardVO.transactionType}</div></span>
        </div>
        <c:if test="${storeBoardVO.securityFacility eq '있음'}">
            <div class="more_info" id='more_info'>
                <div class="more_info_icon"><i class="fas fa-shield-alt"></i>  </div>
                <div class="more_info_desc">보안시설</div>
                <span >보안시설<div class='more_info_item'>${storeBoardVO.securityFacility}</div></span>
            </div>
        </c:if>
        <c:if test="${storeBoardVO.forbiddenProduct != null}">
            <div class="more_info" id='more_info'>
                <div class="more_info_icon"><i class="fas fa-ban"></i>  </div>
                <div class="more_info_desc">금지 물품</div>
                <span>
                    <div>금지 물품 </div>
                    <div class='more_info_item'>${storeBoardVO.forbiddenProduct}</div>
                </span>
            </div>
        </c:if>
    </div>

    <div class="detail_description" id='detail_description'>
        ${storeBoardVO.content}
    </div>
    <div class='location_map'>
        <div class="location_map_title">위치 정보</div>
        <div class="location_map_content" id="map"></div>
    </div>
    <div class="review_class">
        <div class="review_host_title">리뷰</div>
        <div class="review_header">
            <div class="review_host">
                <c:choose>
                    <c:when test="${hostReputationVO.totalReviewCnt eq 0}">
                        <div class="no_review">등록된 리뷰가 없습니다.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="review_host_point">
                            <c:choose>
                                <c:when test="${star < 1}">
                                    0
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${hostReputationVO.starPointAvg}" pattern=".0"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="star_icon">
                            <c:forEach begin="1" end="${star}" step="1">
                                <i class="fas fa-star"></i>
                            </c:forEach>
                            <c:forEach begin="1" end="${5 - star}" step="1">
                                <i class="far fa-star"></i>
                            </c:forEach>
                        </div>
                        <div class="review_host_cnt">(${hostReputationVO.totalReviewCnt}명이 리뷰함)</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="review_list">

            </div>
        </div>
        <div class="review_footer">
            <div class="review_paging">
            </div>
            <sec:authorize access="isAuthenticated()" >
                <a class="review_btn moabtn btn btn-success btn-green"  style="padding: 5px 10px;" href="#reviews-anchor" id="open-review-box">리뷰 쓰기</a>
            </sec:authorize>
        </div>
    </div>

    <div class="row" id="post-review-box" style="display:none;">
        <div class="col-md-12">
            <form name="reviewForm" accept-charset="UTF-8" onsubmit="return false;" method="post">
                <input id="ratings-hidden" name="rating" type="hidden">
                <textarea class="form-control animated" cols="50" id="new-review" name="comment" placeholder="리뷰를 작성해주세요." rows="5" maxlength="1000"></textarea>
                <div class="text-right">
                    <div class="stars starrr" data-rating="0"></div>
                    <a class=" cancle-btn" href="" id="close-review-box" style="display:none; margin-right: 10px;">
                        <span class="glyphicon glyphicon-remove" id="cancle_btn"></span>&nbsp;취소&nbsp;</a>
                    <button class="moabtn btn-success "onclick="$.replyReview();return false;">답글달기</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
<script>magnify("prev_image", 3);</script>
</body>
</html>