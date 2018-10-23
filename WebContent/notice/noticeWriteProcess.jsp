<%@page import="com.iu.notice.NoticeDAO"%>
<%@page import="com.iu.notice.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	NoticeDTO noticeDTO = new NoticeDTO();
	noticeDTO.setTitle(request.getParameter("title"));
	noticeDTO.setWriter(request.getParameter("writer"));
	noticeDTO.setContents(request.getParameter("contents"));
	NoticeDAO noticeDAO = new NoticeDAO();
	int result = noticeDAO.insert(noticeDTO);
	String s = "Write Fail";
	if(result>0){
		s = "Write Success";
	}
	
	request.setAttribute("message", s);
	request.setAttribute("path", "./noticeList.jsp?curPage=1");
	
	/* RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
	view.forward(request, response); */
	
	//redirect
	response.sendRedirect("../index.jsp");//이동 해야 할 주소
	
	
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