<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!--[if lt IE 7]>
<html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>
<html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>
<html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<base href="/">
<title>Flamingo</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link
	href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Raleway:100,300,400'
	rel='stylesheet' type='text/css'>
<style>
	.container {
		margin-top: 40px;
	}
</style>
</head>
<body>
	<!--[if lt IE 7]>
<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade
    your browser</a> to improve your experience.</p>
<![endif]-->

	<div class="container">		
		<div class="col-md-3">
			<form:form method="POST" commandName="fileUploadForm"
				action="upload" enctype="multipart/form-data" role="form">
				<div class="form-group">
					<label for="file">Please select a file to upload :</label> 
					<input id="file" type="file" name="file"/>
					<p class="help-block">${filename }</p>
				</div>
				<button class="btn btn-primary" type="submit">Upload</button>
				
				
			</form:form>
			
			<div class="label label-info">${result }</div>
			
			
		</div>
		

		<div class="col-md-9">
			<div class="jumbotron">
				<ul>
					<c:forEach items="${users}" var="user">
						<li>
							<c:out value="${user.name}"></c:out> - <c:out value="${user.dateOfBirth}"></c:out> 
							-  <c:out value="${user.gender}"></c:out>
						</li>
					</c:forEach>
				</ul>
			</div>
			<c:if test="${oldest!=null }">
				<div>
					Oldest: <span class="label label-info label-lg">${oldest.name }</span>
				</div>
			</c:if>
			<c:if test="${diffAge!=null }">
				<div> Bill is older than Paul by: <span class="label label-info label-lg">${diffAge }</span> days </div>
			</c:if>
		</div>
	</div>

</body>
</html>