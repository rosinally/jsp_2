<%@page import="com.iu.member.MemberDAO"%>
<%@page import="com.iu.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDTO memberDTO = new MemberDTO();
	memberDTO.setId(request.getParameter("id"));
	memberDTO.setPw(request.getParameter("pw"));
	memberDTO.setName(request.getParameter("name"));
	memberDTO.setEmail(request.getParameter("email"));
	memberDTO.setKind(request.getParameter("kind"));
	memberDTO.setClassMate(request.getParameter("classMate"));
	MemberDAO memberDAO = new MemberDAO();
	int result = memberDAO.insert(memberDTO);
	String s = "Join  Fail";
	if(result>0){
		s = "Join  Success";
	}
	
	request.setAttribute("message", s);
	request.setAttribute("path", "../index.jsp");
	
	//이동해야 할 페이지의 주소
	RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
	view.forward(request, response);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	
</body>
</html>