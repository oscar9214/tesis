<%@page import="picturemaker.logic.Reference"%>
<%@page import="picturemaker.logic.Attribute"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
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
<link href="static/css/dashboard.css" rel="stylesheet">

<link href="static/css/smoothness/jquery-ui-1.10.4.custom.css"
	rel="stylesheet">

<style>
.page-container {
	border: 1px solid #BBFFFF;
	border-radius: 3px;
}

.table-outside {border: 1px solid red}
.table-outside>td,tr {border: 0}

#id-div-entities{
    height: 400px;
    overflow-y: scroll;
}

.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 3px;
	vertical-align: top;
	border-top: 1px solid #ddd;
}

.table>tbody>tr>th, .table>tbody>tr>td{
	background-color: #FFFFFF;
}

.custom-select {
	width: 100%;
	padding: 1px 20px;
}

#id-picture-file{
	font-size: 14px;
	font-family:"Lucida Console", Monaco, monospace;
	background-color: #FFFFFF;
	border: 1px solid rgba(86, 61, 124, .2);
	padding-left:2em;
}

.figure-label{
	position: absolute;
	top: 0;
}

#id-figure{
	border:2px solid #a1a1a1;
	padding:100px 40px; 
	background:#dddddd;
	width:300px;
	border-radius:5px;
	text-align: center;
	position: relative;
}

.active-entity {
	color: #fff;
	background-color: #428bca;
	padding: 10px 15px;
	display: block;
	
}

.entity-elements-container {
	margin-bottom: -7px;
}

.entity-attribute {
	padding: 5px;
}

.entity-reference {
	padding: 5px;
}

.entity {
	background-color: #f5f5f5;	
	border-color: #428bca;
	padding: 10px 15px;
	border-bottom: 1px solid transparent;
}


.active-entity > a {
  color: #fff;
  background-color: #428bca;
  display: block;
}

.entity > a {
  display: block;
}

.panel-group .panel {
	margin-bottom: -7px;
	border-radius: 4px;
    overflow: hidden;
}

.active-figure {
	color: #fff;
	background-color: #428bca;
	padding: 5px;
	display: block;
}

.figure {
	background-color: #f5f5f5;	
	border-color: #428bca;
	padding: 5px;
	border-bottom: 1px solid transparent;
}

.active-figure > a {
  color: #fff;
  background-color: #428bca;
  display: block;
}

.figure > a {
  display: block;
}

.show-grid {
	margin-bottom: 15px
}

.show-grid [class^=col-] {
	padding-top: 10px;
	padding-bottom: 10px;
	border: 1px solid #ddd;
	border: 1px solid rgba(86, 61, 124, .2)
}

.canvas {
	background-color: #FFFFFF;
	border: 1px solid rgba(86, 61, 124, .2);
	padding-left: 30px;
	padding-top: 30px;
	padding-bottom: 30px;
}

.canvas-highlight {
	background-color: #F8FFE5;
	border: 5px solid #ddd;
}

.canvas-hover {
	background-color: #E5F8FF;
	border: 1px solid #ddd;
}

#top-right 
.icon-menu-button {
	-webkit-transition: 0.1s color;
	-moz-transition: 0.1s color;
	-o-transition: 0.1s color;
	transition: 0.1s color;
	cursor: pointer
}

.icon-menu-button:hover {
	color: #ff8989
}
</style>



<style id="holderjs-style" type="text/css"></style>
</head>

<body style="font-size: 12px;">

	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid" style="background: #222; padding-top: 8px;">
		<button id="id-button-download"  type="button" class="btn btn-success pull-right" onclick="download_picture_file();" disabled><span class="glyphicon glyphicon-floppy-save"></span>&nbspDownload File</button>		
		<button id="id-button-wizards" type="button" class="btn btn-success pull-right" onclick="show_wizard_tool();" disabled><span class="glyphicon glyphicon glyphicon-wrench"></span>&nbsp Define wizards</button>
		<button type="button" class="btn btn-success pull-right" onclick="show_rules_tool();"><span class="glyphicon glyphicon glyphicon-wrench"></span>&nbsp Define rules</button>
			<div class="navbar-header">			
				<% out.println("<h4 style=\"color: #FFFFFF;\" id=\"id-filename\">" + request.getAttribute("fileName") + "</h4>");%>
			</div>
			<div class="navbar-collapse collapse"></div>
		</div>
	</div>
	
	<div class="panel panel-default">
	  <div class="panel-body">
	  <div class="alert alert-info text-center" style="display: none;"></div>
	    <div class="row show-grid">
		<div class="col-md-2" style="background-color: #f5f5f5;" id="id-div-entities">
		<h2 class="sub-header">Entities</h2>
			<table class="table" style="border-collapse: collapse;">

				<tbody id="id-entities-container">
					<%@ page import="java.util.ArrayList"%>
					<%@ page import="picturemaker.logic.Entity"%>
					<%
						// retrieve your list from the request, with casting 
							ArrayList<Entity> list = new ArrayList<Entity>();
							//storing passed value from jsp
							list = (ArrayList<Entity>)request.getAttribute("entities");
							if (list!=null){
								// print the information about every category of the list
								out.println("<div class=\"panel-group\" id=\"accordion\">");
								for( int i = 0 ; i < list.size(); i++) {
									Entity entity = list.get(i);
									out.println("<div class=\"entity-elements-container panel panel-default\">");
									out.println("<div id=\"id-entity-"+i+"\" class=\""+((i==0)?"active-entity":"entity")+"\">");
									out.println("<a onclick=\"select_entity("+i+")\" data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapse"+i+"\" class=\"\">"+((i==0)?"<span class=\"glyphicon glyphicon-ok\">&nbsp</span>":"")+"<span class=\"entity-name\">"+entity.name+"</span></a>");
									out.println("</div>");
									out.println("<div id=\"collapse"+i+"\" class=\"panel-collapse collapse\" style=\"height: auto;\">");
									out.println("<div class=\"panel-body\">");
									out.println("<p><span class=\"glyphicon glyphicon-th-list\"></span>Attributes</p>");
									out.println("<div class=\"list-group\">");							          
									for (Attribute attribute : entity.getAttributes()){
										out.println("<span class=\"entity-attribute list-group-item list-group-item-info\">"+attribute.name+"</span>");
									}
									out.println("</div>");
									out.println("<p><span class=\"glyphicon glyphicon-resize-small\"></span>References</p>");
									out.println("<div class=\"list-group\">");
									for (Reference reference : entity.getReferences()){
										out.println("<span class=\"entity-reference list-group-item list-group-item-info\">"+reference.name+"</span>");
									}
									out.println("</div>");
									out.println("</div>");
									out.println("</div>");
									out.println("</div>");									
								}
								out.println("</div>");
							}
							
					%>
				</tbody>
			</table>
		</div>
		<div class="col-md-5">
			<h2 class="sub-header">Figure</h2>
			<h3 id="id-selected-name"></h3>
			<div id="id-figure-container" class="canvas">
				<div id="id-figure">
					<div id="id-figure-label" class="figure-label">
						elementName
					</div>
				</div>	
			</div>
		</div>
		<div class="col-md-5" style="background-color: #f5f5f5;">
			<button type="button" class="btn btn-success pull-right" onclick="save_current_entity();">Save</button>
			<h2 class="sub-header">Properties</h2>
			<div class="table-responsive">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Property</th>
							<th>Value</th>
						</tr>
					</thead>
					<tbody id="id-properties-container">
						
					</tbody>
				</table>
			</div>
		</div>
	  </div>
	  <div class="panel-footer">
	  
	  <h2 class="sub-header">Picture File</h2>
	  	<p>
	  	
	  		<div id="id-picture-file">
	  			<div id="id-file-header">
	  				
				</div>
				<div id="id-file-palette">					
					<br><div class="file-section-container"></div>
					<br><span class="file-line">&emsp;&emsp;}</span>
					<br><span class="file-line">&emsp;}</span>
				</div>
				<div id="id-file-style">
					<span class="file-line">&emsp;Style definition {</span>
					<br>&emsp;&nbsp;
					<br><div class="file-section-container"></div>
					<br><span class="file-line">&emsp;} </span>
				</div>
				<div id="id-file-graphical">
					<span class="file-line">&emsp;Graphical definition {</span>
					<br>&emsp;&nbsp;
					<div class="file-section-container"></div>
					<br><span class="file-line">&emsp;}</span>
				</div><div id="id-file-rules">
					<span class="file-line">&emsp;Rules definition {</span>
					<div class="file-section-container"></div>
					<br><span class="file-line">&emsp;}</span>
				</div>
				<div id="id-file-interaction">
					<span class="file-line">&emsp;Interaction definition {</span>
					<div class="file-section-container"></div>
					<br><span class="file-line">&emsp;}</span>
				</div><div id="id-file-footer">
					<span class="file-line">}</span>
				</div>
			</div>
	  	</p>
	  </div>
	</div>
	</div>


<!-- main entity modal -->
<div  class="modal fade" id="id-modal-main-entity" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background: #222; color: #FFF;">
        <h3 class="modal-title">Get started</h3>
      </div>
      <div class="modal-body">
        <p>Please select the entity of your metamodel which will be the canvas that will contain all the other entities</p>
        <select class="form-control" id="id-main-entity">
      	<%
			// retrieve your list from the request, with casting 
				list = new ArrayList<Entity>();
				//storing passed value from jsp
				list = (ArrayList<Entity>)request.getAttribute("entities");
				if (list!=null){
					// print the information about every category of the list					
					for( int i = 0 ; i < list.size(); i++) {
						Entity entity = list.get(i);
						out.println("<option data-entity-id=\""+i+"\" value=\""+entity.name+"\">"+entity.name+"</option>");						
					}					
				}				
		%>			
		</select>
		<p>Please type the metamodel package.</p>
		<input class="form-control" type="text" id="id-package-name">
      </div>      
      <div class="modal-footer">
        <button class="btn btn-success" onclick="select_main_entity();">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- rules modal -->
<div  class="modal fade" id="id-modal-rules" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background: #222; color: #FFF;">
        <h3 class="modal-title">Rules Definition</h3>
      </div>
      <div class="modal-body">
      	<button class="btn btn-info btn-xs pull-right" onclick="add_rule_to_html();">+Add Rule</button>      	
        <p>Select a class to define some rules</p>
        <div id="id-rules-class-container">
        	
        </div>			
      </div>      
      <div class="modal-footer">
        <button class="btn btn-success" onclick="add_rules_to_file();">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	


<!-- wizards modal -->
<div  class="modal fade" id="id-modal-wizards" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background: #222; color: #FFF;">
        <h3 class="modal-title">Wizards Definition</h3>
      </div>
      <div class="modal-body">
      	<button class="btn btn-info btn-xs pull-right" onclick="add_wizard_to_html();">+Add Wizard</button>      	
        <div id="id-wizards-container">        	
        </div>			
      </div>      
      <div class="modal-footer">
        <button class="btn btn-success" onclick="add_wizards_to_file();">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="static/js/jquery.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/jquery-ui-1.10.4.custom.js"
		language="javascript" type="text/javascript"></script>
	<script src="static/js/jquery-ui-1.10.4.custom.min.js"
		language="javascript" type="text/javascript"></script>
	<script src="static/js/file-saver/FileSaver.js"
		language="javascript" type="text/javascript"></script>
	<script src="static/js/picture-maker.js"
		language="javascript" type="text/javascript"></script>
	
</body>
</html>