<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%--
<%
	Map<String, Object> map = (HashMap<String, Object>)request.getAttribute("purchaseMap");
	Search search = (Search)request.getAttribute("purchaseSearch");
	Page resultPage = (Page)request.getAttribute("resultPage");	
	

	List<Purchase> list = null;
	if(map != null){
		list=(Vector<Purchase>)map.get("purchaseList");
	}
	
%>
--%>


<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

function fncGetUserList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
	$("form").attr("method","POST").attr("action","../purchase/listPurchase").submit();
}
$(function(){
	
	
	
	$(".ct_list_pop td:nth-child(1)").on("click",function(){
		
		self.location ="../purchase/getPurchase?tranNo="+$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(1)").index(this)]).val()+"&menu=${menu}";
		
	});
	
	$(".ct_list_pop td:nth-child(9):contains('배송처리')").on("click",function(){
		self.location="../purchase/updateTranCode?tranNo="+$("input[name=tranNo]").val();
		
	});
	
	$(".ct_list_pop td:nth-child(9):contains('구매완료')").on("click",function(){
		
		self.location="../purchase/updateTranCode?tranNo="+$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(9)").index(this)]).val();
		
		//$($("input")[0]).val()도 10037
		//$("input[name=tranNo]").val()로 찍으면 10037 고정
		//$($("input[name=tranNo]")[$(".ct_list_pop td:nth-child(1)").index(this)]).val()는 인식 못함
		// ㄴ 예상에는 this에 문제가 있는듯 함
		
		
	});
	
});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체 ${resultPage.totalCount} 건수, 현재  ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	

	<c:set var = "i" value="0" />
	<c:forEach var = "purchase" items="${purchaseMapList}">
	<c:set var="i" value="${i+1}"> </c:set>
		
		<c:set var="transtatus" value="배송완료"/>
		<c:if test="${purchase.tranCode.trim() == '0' }">
			<c:set var="transtatus" value="배송 준비중"></c:set>
		</c:if>
		<c:if test="${purchase.tranCode.trim() == '1' }">
			<c:set var="transtatus" value="배송 중"></c:set>
		</c:if>
		<c:if test="${purchase.tranCode.trim() == '2' }">
			<c:set var="transtatus" value="구매 완료"></c:set>
		</c:if>
			
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<tr class="ct_list_pop">
		<td align="center">
			<!-- <a href="../purchase/getPurchase?tranNo=${purchase.tranNo}">${i}</a> -->
			${i}
			<input type="hidden" name="tranNo" value="${purchase.tranNo}"/>
		</td>
		<td></td>
		<td align="left">
			${purchase.buyer.userId}
		</td>
		<td></td>
		<td align="left">${purchase.buyer.userName }</td>
		<td></td>
		<td align="left">${purchase.buyer.phone }</td>
		<td></td>
		<td align="left">현재
				
					${transtatus }
				
				 입니다.
				 
				 
				 <c:if test="${!(purchase.buyer.role == 'user')}">
				 	배송처리	
				 </c:if>
				 <c:if test="${purchase.buyer.role == 'user' && purchase.tranCode.trim() == '1' }">
					 구매완료	
				 </c:if>				
			
				 </td>
		<td></td>
		<td align="left">
			
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>

</c:forEach>	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
		<jsp:include page="../common/pageNavigator.jsp"/>
			
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>