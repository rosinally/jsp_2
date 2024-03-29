<%@page import="com.iu.notice.NoticeDTO"%>
<%@page import="com.iu.notice.NoticeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NoticeDAO noticeDAO = new NoticeDAO();
	int curPage=1;
	String kind=request.getParameter("kind");
	String search=request.getParameter("search");
	System.out.println("kind:"+kind);
	System.out.println("search:"+search);
	
	if(kind==null){
		kind="Title";
	}
	
	if(search==null){
		search="";
	}
	
	try{
		curPage= Integer.parseInt(request.getParameter("curPage"));
		
	}catch(Exception e){
		
	}
	int perPage=10;
	int startRow=(curPage-1)*perPage+1;
	int lastRow=curPage*perPage;
	List<NoticeDTO> ar = noticeDAO.selectList(startRow, lastRow, kind, search);
			
	
	//페이징 
	//1. 전체 글의 갯수
	int totalCount = noticeDAO.getCount(kind, search);
	//2. 전체 페이지의 갯수
	int totalPage=totalCount/perPage;
	if(totalCount%10 != 0){
		totalPage=totalCount/perPage+1;
	}
	//3. 전체 블럭의 갯수
	int perBlock=5;//블럭당 숫자의 갯수
	int totalBlock = totalPage/perBlock;
	if(totalPage%perBlock !=0){
		//totalBlock = totalPage/perBlock+1;
		totalBlock = totalBlock+1;
	}
	//4. curPage의 번호로 curBlock 구하기
	int curBlock = curPage/perBlock;
	if(curPage%perBlock != 0){
		curBlock = curPage/perBlock+1;
	}
	
	//5. curBlock 번호로 startNum, lastNum 구하기
	int startNum=(curBlock-1)*perBlock+1;
	int lastNum=curBlock*perBlock;
	
	if(curBlock == totalBlock){
		lastNum = totalPage;
	}
	
%>    
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Theme Made By www.w3schools.com - No Copyright -->
  <title>Bootstrap Theme Company Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  body {
      font: 400 15px Lato, sans-serif;
      line-height: 1.8;
      color: #818181;
  }
  h2 {
      font-size: 24px;
      text-transform: uppercase;
      color: #303030;
      font-weight: 600;
      margin-bottom: 30px;
  }
  h4 {
      font-size: 19px;
      line-height: 1.375em;
      color: #303030;
      font-weight: 400;
      margin-bottom: 30px;
  }  
  .jumbotron {
      background-color: #f4511e;
      color: #fff;
      padding: 100px 25px;
      font-family: Montserrat, sans-serif;
  }
  .container-fluid {
      padding: 60px 50px;
  }
  .bg-grey {
      background-color: #f6f6f6;
  }
  .logo-small {
      color: #f4511e;
      font-size: 50px;
  }
  .logo {
      color: #f4511e;
      font-size: 200px;
  }
  .thumbnail {
      padding: 0 0 15px 0;
      border: none;
      border-radius: 0;
  }
  .thumbnail img {
      width: 100%;
      height: 100%;
      margin-bottom: 10px;
  }
  .carousel-control.right, .carousel-control.left {
      background-image: none;
      color: #f4511e;
  }
  .carousel-indicators li {
      border-color: #f4511e;
  }
  .carousel-indicators li.active {
      background-color: #f4511e;
  }
  .item h4 {
      font-size: 19px;
      line-height: 1.375em;
      font-weight: 400;
      font-style: italic;
      margin: 70px 0;
  }
  .item span {
      font-style: normal;
  }
  .panel {
      border: 1px solid #f4511e; 
      border-radius:0 !important;
      transition: box-shadow 0.5s;
  }
  .panel:hover {
      box-shadow: 5px 0px 40px rgba(0,0,0, .2);
  }
  .panel-footer .btn:hover {
      border: 1px solid #f4511e;
      background-color: #fff !important;
      color: #f4511e;
  }
  .panel-heading {
      color: #fff !important;
      background-color: #f4511e !important;
      padding: 25px;
      border-bottom: 1px solid transparent;
      border-top-left-radius: 0px;
      border-top-right-radius: 0px;
      border-bottom-left-radius: 0px;
      border-bottom-right-radius: 0px;
  }
  .panel-footer {
      background-color: white !important;
  }
  .panel-footer h3 {
      font-size: 32px;
  }
  .panel-footer h4 {
      color: #aaa;
      font-size: 14px;
  }
  .panel-footer .btn {
      margin: 15px 0;
      background-color: #f4511e;
      color: #fff;
  }
  .navbar {
      margin-bottom: 0;
      background-color: #f4511e;
      z-index: 9999;
      border: 0;
      font-size: 12px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 4px;
      border-radius: 0;
      font-family: Montserrat, sans-serif;
  }
  .navbar li a, .navbar .navbar-brand {
      color: #fff !important;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
      color: #f4511e !important;
      background-color: #fff !important;
  }
  .navbar-default .navbar-toggle {
      border-color: transparent;
      color: #fff !important;
  }
  footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #f4511e;
  }
  .slideanim {visibility:hidden;}
  .slide {
      animation-name: slide;
      -webkit-animation-name: slide;
      animation-duration: 1s;
      -webkit-animation-duration: 1s;
      visibility: visible;
  }
  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
  }
  @media screen and (max-width: 768px) {
    .col-sm-4 {
      text-align: center;
      margin: 25px 0;
    }
    .btn-lg {
        width: 100%;
        margin-bottom: 35px;
    }
  }
  @media screen and (max-width: 480px) {
    .logo {
        font-size: 150px;
    }
  }
  </style>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#myPage">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="./notice/noticeList.jsp">NOTICE</a></li>
        <li><a href="#services">SERVICES</a></li>
        <li><a href="#portfolio">PORTFOLIO</a></li>
        <li><a href="#pricing">PRICING</a></li>
        <li><a href="#contact">CONTACT</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container-fluid">
	<div class="row">
		<div>
			<form class="form-inline" action="./noticeList.jsp">
			    <div class="form-group">
			    	<select class="form-control" id="sel1" name="kind">
				        <option>Title</option>
				        <option>Contents</option>
				        <option>Writer</option>
			     	</select>	
						    
			      <input type="text" class="form-control" id="search" placeholder="Enter search" name="search">
			    </div>
			    
			    <button type="submit" class="btn btn-default">Submit</button>
			  </form>
			
		</div>
	
	
		<table class="table table-hover">
			<tr>
				<td>NUM</td>
				<td>TITLE</td>
				<td>WRITER</td>
				<td>DATE</td>
				<td>HIT</td>
			</tr>
			<% for(NoticeDTO noticeDTO : ar){ %>
			<tr>
				<td><%=noticeDTO.getNum() %></td>
				<td><%=noticeDTO.getTitle()%> </td>
				<td><%=noticeDTO.getWriter() %> </td>
				<td><%=noticeDTO.getReg_date() %> </td>
				<td><%=noticeDTO.getHit() %> </td>	
			</tr>
			<%} %>
		</table>
		
	</div>
</div>

<div class="container-fluid">
	<div class="row">
		    
	  <ul class="pagination">
	  	<li><a href="./noticeList.jsp?curPage=<%= 1%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-backward"></span></a></li>
	  	
	  	<%if (curBlock>1){ %>
	  	<li><a href="./noticeList.jsp?curPage=<%= startNum-1%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
	  	<%} %>
	   	<% for(int i=startNum;i<=lastNum;i++){ %>
	   		<li><a href="./noticeList.jsp?curPage=<%=i%>&kind=<%=kind%>&search=<%=search%>"><%=i%></a></li>
	   	<%} %>
	   	
	   	<% if(curBlock < totalBlock){ %>
	   	<li><a href="./noticeList.jsp?curPage=<%=lastNum+1%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
	   	<%} %>	
	   	<li><a href="./noticeList.jsp?curPage=<%=totalPage%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-forward"></span></a></li>
	  </ul>
	  
  	</div>
</div>

<div class="container-fluid">
	<div class="row">
		<div class="col-md-1">
			<a href="./noticeWriteForm.jsp" class="btn btn-primary">Write</a>
		</div>
	
	</div>
</div>
	


<script>
$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})
</script>


</body>
</html>
