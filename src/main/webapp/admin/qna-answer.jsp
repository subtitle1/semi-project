<%@page import="service.QnAService"%>
<%@page import="dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">

<%
String content = request.getParameter("content");
int qnANo = Integer.parseInt(request.getParameter("qnANo"));

QnAService qnAService = new QnAService();
qnAService.answerQuestion(qnANo, content);



//전체 글목록을 제공하는 list.jsp를 재요청하게 하는 응답을 보낸다.
response.sendRedirect("qna-list.jsp");

%>