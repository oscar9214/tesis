<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content=".picture files maker">
<meta name="author" content="Oscar Martínez">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">

<title>Picture Maker</title>

<!-- Bootstrap core CSS -->
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Custom styles for this template -->
<link href="static/css/cover.css" rel="stylesheet">

<link href="static/css/smoothness/jquery-ui-1.10.4.custom.css"
	rel="stylesheet">

<style id="holderjs-style" type="text/css"></style>
</head>

<body>
	<div class="site-wrapper">

      <div class="site-wrapper-inner">

        <div class="cover-container">

          <div class="masthead clearfix">
            <div class="inner">
              <h1 class="masthead-brand">Picture file maker</h1>
            </div>
          </div>

          <div class="inner cover">
            <h3 class="cover-heading">Please upload the metamodel to start building your .picture file.</h3>
              <form method="GET" class="text-cener" action="PicServlet" enctype="multipart/form-data"> 
                <input name="file" type="file" value=""/>
                <button type="submit" class="btn btn-success center">Send</button>
			  </form>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>Oscar Martínez</p> 
              <p><a href="http://uniandes.edu.co">Uniandes</a></p>
            </div>
          </div>

        </div>

      </div>

    </div>
	
	
			
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="static/js/jquery.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/jquery-ui-1.10.4.custom.js"
		language="javascript" type="text/javascript"></script>
	<script src="static/js/jquery-ui-1.10.4.custom.min.js"
		language="javascript" type="text/javascript"></script>
	

</body>
</html>