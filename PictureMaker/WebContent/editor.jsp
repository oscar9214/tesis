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
		<div class="container-fluid" style="background: #222">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle button"
					data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Project name</a>

			</div>
			<div class="navbar-collapse collapse"></div>
		</div>
	</div>
	
	<div class="panel panel-default">
	  <div class="panel-body">
	  <div class="alert alert-info"></div>
	    <div class="row show-grid">
		<div class="col-md-2" style="background-color: #f5f5f5;">
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
				<table class="table">
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
	  <div class="panel-footer"><h2 class="sub-header">Picture File</h2>
	  	<p>
	  	
	  		<div id="id-picture-file">
	  			<div id="id-file-header">
	  				<br>import "/model/bpmn2.ecore"
	  				<br>as MM
	  				<br>Graphical representation BPMN {
	  				<br>&emsp;reference package bpmn
	  				<br>&emsp;root MacroProcess
				</div>
				<div id="id-file-palette">
					&emsp;Palette for MacroProcess{
					<br>&emsp;&nbsp;
					<br><div class="file-section-container"></div>
					<br>&emsp;}
				</div>
				<div id="id-file-style">
					&emsp;Style definition {
					<br>&emsp;&nbsp;
					<br>&emsp;} 
				</div>
				<div id="id-file-graphical">
					&emsp;Graphical definition {
					<br>&emsp;&nbsp;
					<div class="file-section-container"></div>
					<br>&emsp;}
				</div><div id="id-file-rules">
					&emsp;Rules definition {
					<br>&emsp;&nbsp;
					<br>&emsp;}
				</div>
				<div id="id-file-interaction">
					&emsp;Interaction definition {
					<br>&emsp;&nbsp;
					<br>&emsp;}
				</div><div id="id-file-footer">
					}
				</div>
			</div>
	  	</p>
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
	<script language="javascript" type="text/javascript">
								   
			var entities = [];
			var style_definition = [];
			var selected_entity = null;
			var selected_figure = null;
			var figure_constants = {
					'rounded': 0,
					'polygon': 1,
					'ellipse': 2,
					'custom': 3,
					'image': 4,
					'complex': 5
			};
			
			function setup_fake_entities () {
				for (var i = 0; i < 5; i++){
					var icon_properties = {
							path: '',
							size: ['',''],
							position: [15,15]
					};
					
					var rounded = {
							id: 0,
							radios: ['',''],
							background_color: '#dddddd',
							border: 'solid',
							icon: icon_properties
					};
					
					var graphical_properties_rounded = {
							label_icon: 'false',
							label_placement: 'internal',
							size: ['',''],
							figure: rounded,
							phantom: 'false'
					};
					
					var entityObject = {
							name: 'Name'+i, 
							attributes: ['att'+i+".1", 'att'+i+".2"],
							references: ['ref'+i+".1", 'ref'+i+".2"],
							graphical_properties: graphical_properties_rounded
							};
					entities.push(entityObject);
				}
				select_entity(0);
			};
			
			function create_entity(name, attributes, references){
				var icon_properties = {
						path: '',
						size: ['',''],
						position: [15,15]
				};
				
				var rounded = {
						id: 0,
						radios: ['',''],
						background_color: '#dddddd',
						border: 'solid',
						icon: icon_properties
				};
				
				var graphical_properties_rounded = {
						label_icon: 'false',
						label_placement: 'internal',
						size: ['',''],
						figure: rounded,
						phantom: 'false'
				};
								
				var entityObject = {
						name: name, 
						attributes: attributes,
						references: references,
						graphical_properties: graphical_properties_rounded
						};
				entities.push(entityObject);
				add_to_file(entityObject);
			};
			
			function setup_entities () {
				$('.entity-elements-container').each(function(i, object)
				{
					var name = $(this).find('.entity-name').html();
					var attributes = [];
					var references = [];
					$(this).find('.entity-attribute').each(function(i, object){
						attributes.push($(this).html());
					});
					$(this).find('.entity-reference').each(function(i, object){
						references.push($(this).html());
					});
					create_entity(name, attributes, references);							    
				});
					
				select_entity(0);
			};
					
			
			
			function setup_html_entities (){
				var html_for_entities = '<div class="panel-group" id="accordion">';
				for (var i = 0; i < entities.length; i++){
					var attributes = entities[i]['attributes'];
					var references = entities[i]['references'];
					html_for_entities += '<div class="panel panel-default entity-elements-container">';
					html_for_entities += '<div id="id-entity-'+i+'" class="'+((i==0)?'active-entity':'entity')+'">';
					html_for_entities += '<a onclick="select_entity('+i+')" data-toggle="collapse" data-parent="#accordion" href="#collapse'+i+'" class="">'+((i==0)?'<span class="glyphicon glyphicon-ok">&nbsp</span>':'')+entities[i]['name']+'</a>';
					html_for_entities += ('</div>');
					html_for_entities += '<div id="collapse'+i+'" class="panel-collapse collapse" style="height: auto;">';
					html_for_entities += '<div class="panel-body">';
					html_for_entities += ('<p>Attributes--------</p>');
					for (var j = 0; j < attributes.length; j++){
						html_for_entities += ('<p>'+attributes[j]+'</p>');
					}
					html_for_entities += ('<p>References--------</p>');
					for (var j = 0; j < references.length; j++){
						html_for_entities += ('<p>'+references[j]+'</p>');
					}
					html_for_entities += ('</div>');
					html_for_entities += ('</div>');
					html_for_entities += ('</div>');
					add_to_file(entities[i]);
				}
				html_for_entities += ('</div>');
				$('#id-entities-container').html(html_for_entities);				
			};
			
			function add_to_palette(entity){
				var indent = '<br>&emsp;&emsp;';
				var container = $('#id-file-palette').find('.file-section-container');
				var html = '';
				html += indent + 'Creation button for class '+entity['name']+' {';
				html += indent + 'name "'+entity['name']+'"';
				html += indent + 'description "Description of '+entity['name']+'"';
				html += indent + 'icon "/imagenes/NodeIcon.gif"';
				html += indent + '}';
				container.append(html);			
			};
			
			function add_to_graphical_definition(entity){
				var indent = '<br>&emsp;&emsp;';
				var container = $('#id-file-graphical').find('.file-section-container');
				var html = '';
				html += indent + 'Node_element '+entity['name']+'Definition';
				html += indent + 'for class '+entity['name']+' {';
				html += indent + 'label elementName"';
				html += indent + 'label icon '+entity['graphical_properties']['label_icon']+'';
				html += indent + 'label placement '+entity['graphical_properties']['label_placement']+'';
				html += indent + 'size ( '+entity['graphical_properties']['size'][0]+' ,  '+entity['graphical_properties']['size'][1]+' )';
				
				var figure_id = entity['graphical_properties']['figure']['id'];
				
				html += indent + 'size ( '+entity['graphical_properties']['size'][0]+' ,  '+entity['graphical_properties']['size'][1]+' )';
								
				if(figure_id == figure_constants['image']){
					html += indent + 'Image figure{';
					html += indent + 'image path "figure_path.svg"';
					html += indent + '}';
					//$('#').val();
					//figure_properties['image_path'] = '';
				}
				else if(figure_id == figure_constants['complex']){
					html += indent + 'Complex figure{';
					html += indent + '---';
					html += indent + '}';
				}
				else{
					html += indent + 'Regular figure extends rounded{';
					html += indent + 'backgroud color '+entity['graphical_properties']['figure']['background_color']+'';
					html += indent + 'border '+entity['graphical_properties']['figure']['border']+'';
					if (entity['graphical_properties']['figure']['icon']!=null){
						html += indent + 'icon path '+entity['graphical_properties']['figure']['icon']['path']+'';
						html += indent + 'icon path '+entity['graphical_properties']['figure']['icon']['size']+'';
						html += indent + 'icon path '+entity['graphical_properties']['figure']['icon']['position']+'';
					}
					if(figure_id == figure_constants['rounded']){
						//PALETTE 					
					}
					else if(figure_id == figure_constants['polygon']){
						//PALETTE 
					}
					else if(figure_id == figure_constants['ellipse']){
						//PALETTE 
					}
					else if(figure_id == figure_constants['custom']){
						//PALETTE 
					}
				}				
				html += indent + 'phantom '+entity['graphical_properties']['phantom']+'';
				html += indent + '}';
				container.append(html);			
			};
			
			function add_to_file(entity){
				add_to_palette(entity);
				add_to_graphical_definition(entity);
			};
			
			
			
			var line_type_constants = {
					'dash': 0,
					'dot': 1,
					'dashdot': 2,
					'dashdotdot': 3,
					'solid': 4
			};
			
			function get_regular_figure_properties(type){
				var response = '';
				response += '<tr>';
				response += '<td>Background color</td>';
				response += '<td><input type="color" name="" id="id-figure-color"></td>';
				response += '</tr>';
				response += '<tr>';
				response += '<td>Border</td>';
				response += '<td>';
				response += '<select class="custom-select" id="id-figure-border">';
				response += '<option value="solid">Solid</option>';
				response += '<option value="dash">Dash</option>';
				response += '<option value="dot">Dot</option>';
				response += '<option value="dashdot">Dash dot</option>';
				response += '<option value="dashdotdot">Dash dot dot</option>';
				response += '</select></td>';
				response += '</td>';
				response += '</tr>';
				response += '<tr>';
				response += '<td>Icon</td>';
				response += '<td>';
				response += '<div class="checkbox">';
				response += '<label>';
				response += '<input id="id-icon-checkbox" type="checkbox" checked> <span id="id-icon-checkbox-label">Selected';
				response += '</label>';
				response += '</div>';
			    response += '<table class="table" id="id-icon-table-properties">';
				response += '<thead><tr><th>Property</th><th>Value</th></tr></thead>';
				response += '<tbody id="id-properties-container-icon-'+type+'">';
				response += '<tr><td>Path</td><td><input type="file" name=""></td></tr>';
				response += '<tr><td>Size</td><td><input id="id-figure-icon-size-w" type="number" min="1" max="1000000" class="" placeholder="Width">';
				response += '<input id="id-figure-icon-size-h" type="number" min="1" max="1000000" class="" placeholder="Height"></td></tr>';
				response += '<tr><td>Position</td><td><input id="id-figure-icon-pos-x" type="number" min="1" max="1000000" class="" placeholder="X">';
				response += '<input id="id-figure-icon-pos-y" type="number" min="1" max="1000000" class="" placeholder="Y"></td></tr>';
				response += '</tbody>';
				response += '</table>';
				response += '</td>';
				response += '</tr>';
				
				return response;
			}
			
			function setup_style_definition(){
				
				var html_for_entities = '<tr>';
				html_for_entities += '<td>Label</td>';
				html_for_entities += '<td>elementName</td>';
				html_for_entities += '</tr>';
				
				html_for_entities += '<tr>';
				html_for_entities += '<td>Label icon</td>';
				html_for_entities += '<td><select class="custom-select" id="id-label-icon-select">';
				html_for_entities += '<option value="false">False</option>';
				html_for_entities += '<option value="true">True</option>';
				html_for_entities += '</select></td>';
				html_for_entities += '</tr>';
				
				html_for_entities += '<tr>';
				html_for_entities += '<td>Label placement</td>';
				html_for_entities += '<td><select class="custom-select" id="id-label-icon-plac-select">';
				html_for_entities += '<option value="internal">Internal</option>';
				html_for_entities += '<option value="external">External</option>';
				html_for_entities += '</select></td>';
				html_for_entities += '</tr>';
				
				html_for_entities += '<tr>';
				html_for_entities += '<td>Size</td>';
				html_for_entities += '<td><input id="id-figure-size-width" type="number" min="1" max="1000000" class="" placeholder="Width">';
				html_for_entities += '<input id="id-figure-size-height" type="number" min="1" max="1000000" class="" placeholder="Height"></td>';
				html_for_entities += '</tr>';
				
				html_for_entities += '<tr>';
				html_for_entities += '<td>Figure</td>';
				html_for_entities += '<td>';
				html_for_entities += '<div class="panel-group" id="id-figure-type">';
				//Rounded
				html_for_entities += '<div class="panel panel-default figure-elements.container" id="id-figure-type-container-0">';
				html_for_entities += '<div id="id-figure-type-0" class="active-figure">';
				html_for_entities += '<a onclick="select_figure(0)" data-toggle="collapse" data-parent="#id-figure-type" href="#collapse-rounded"><span class="glyphicon glyphicon-ok">&nbsp</span>Rounded</a>';
				html_for_entities += '</div>';
				html_for_entities += '<div id="collapse-rounded" class="panel-collapse collapse" style="height: auto;">';
				html_for_entities += '<div class="panel-body">';
				html_for_entities += '<table class="table">';
				html_for_entities += '<thead><tr><th>Property</th><th>Value</th></tr></thead>';
				html_for_entities += '<tbody id="id-properties-container-rounded">';
				html_for_entities += '<tr><td>Size</td><td><input id="id-rounded-xradio" type="number" min="1" max="1000000" class="" placeholder="X Radio">';
				html_for_entities += '<input id="id-rounded-yradio" type="number" min="1" max="1000000" class="" placeholder="Y Radio"></td></tr>';
				html_for_entities += get_regular_figure_properties('rounded');
				html_for_entities += '</tbody>';
				html_for_entities += '</table>';
				html_for_entities += '</div></div></div>';
				//Regular polygon
				html_for_entities += '<div class="panel panel-default figure-elements.container" id="id-figure-type-container-1">';
				html_for_entities += '<div id="id-figure-type-1" class="figure">';
				html_for_entities += '<a onclick="select_figure(1)" data-toggle="collapse" data-parent="#id-figure-type" href="#collapse-polygon">Regular polygon</a>';
				html_for_entities += '</div>';
				html_for_entities += '<div id="collapse-polygon" class="panel-collapse collapse" style="height: auto;">';
				html_for_entities += '<div class="panel-body">';
				html_for_entities += '<table class="table">';
				html_for_entities += '<thead><tr><th>Property</th><th>Value</th></tr></thead>';
				html_for_entities += '<tbody id="id-properties-container-polygon">';
				html_for_entities += '<tr><td>Vertex quantity</td><td><input id="id-polygon-vertex-qty" type="number" min="1" max="1000000" class="" placeholder="#"></td></tr>';
				html_for_entities += '<tr><td>Start angle</td><td><input id="id-polygon-start-angle" type="number" min="1" max="1000000" class="" placeholder="°"></td></tr>';
				html_for_entities += get_regular_figure_properties('polygon');
				html_for_entities += '</tbody>';
				html_for_entities += '</table>';
				html_for_entities += '</div></div></div>';
				//Ellipse
				html_for_entities += '<div class="panel panel-default figure-elements.container" id="id-figure-type-container-2">';
				html_for_entities += '<div id="id-figure-type-2" class="figure">';
				html_for_entities += '<a onclick="select_figure(2)" data-toggle="collapse" data-parent="#id-figure-type" href="#collapse-ellipse">Ellipse</a>';
				html_for_entities += '</div>';
				html_for_entities += '<div id="collapse-ellipse" class="panel-collapse collapse" style="height: auto;">';
				html_for_entities += '<div class="panel-body">';
				html_for_entities += '<table class="table">';
				html_for_entities += '<thead><tr><th>Property</th><th>Value</th></tr></thead>';
				html_for_entities += '<tbody id="id-properties-container-ellipse">';
				html_for_entities += '<tr><td>Size</td><td><input id="id-ellipse-xradio" type="number" min="1" max="1000000" class="" placeholder="X Radio">';
				html_for_entities += '<input id="id-ellipse-yradio" type="number" min="1" max="1000000" class="" placeholder="Y Radio"></td></tr>';
				html_for_entities += get_regular_figure_properties('ellipse');
				html_for_entities += '</tbody>';
				html_for_entities += '</table>';
				html_for_entities += '</div></div></div>';
				//Custom Figure
				html_for_entities += '<div class="panel panel-default figure-elements.container" id="id-figure-type-container-3">';
				html_for_entities += '<div id="id-figure-type-3" class="figure">';
				html_for_entities += '<a onclick="select_figure(3)" data-toggle="collapse" data-parent="#id-figure-type" href="#collapse-custom">Custom</a>';
				html_for_entities += '</div>';
				html_for_entities += '<div id="collapse-custom" class="panel-collapse collapse" style="height: auto;">';
				html_for_entities += '<div class="panel-body">';
				html_for_entities += '<table class="table">';
				html_for_entities += '<thead><tr><th>Property</th><th>Value</th></tr></thead>';
				html_for_entities += '<tbody id="id-properties-container-custom">';
				html_for_entities += '<tr><td>Points <button class="btn btn-info btn-xs">+</button></td><td><div id="id-points-container"><input type="number" min="1" max="1000000" class="pointx" placeholder="X">';
				html_for_entities += '<input type="number" min="1" max="1000000" class="pointy" placeholder="Y"></div></td></tr>';
				html_for_entities += get_regular_figure_properties('custom');
				html_for_entities += '</tbody>';
				html_for_entities += '</table>';
				html_for_entities += '</div></div></div>';
				//Image
				html_for_entities += '<div class="panel panel-default figure-elements.container" id="id-figure-type-container-4">';
				html_for_entities += '<div id="id-figure-type-4" class="figure">';
				html_for_entities += '<a onclick="select_figure(4)" data-toggle="collapse" data-parent="#id-figure-type" href="#collapse-image">Image</a>';
				html_for_entities += '</div>';
				html_for_entities += '<div id="collapse-image" class="panel-collapse collapse" style="height: auto;">';
				html_for_entities += '<div class="panel-body">';
				html_for_entities += '<table class="table">';
				html_for_entities += '<thead><tr><th>Property</th><th>Value</th></tr></thead>';
				html_for_entities += '<tbody id="id-properties-container-image">';
				html_for_entities += '<tr><td>File</td><td><input type="file"></td></tr>';
				html_for_entities += '</tbody>';
				html_for_entities += '</table>';
				html_for_entities += '</div></div></div>';
				//Complex
				html_for_entities += '<div class="panel panel-default figure-elements-container" id="id-figure-type-container-5">';
				html_for_entities += '<div id="id-figure-type-5" class="figure">';
				html_for_entities += '<a onclick="select_figure(5)" data-toggle="collapse" data-parent="#id-figure-type" href="#collapse-complex">Complex</a>';
				html_for_entities += '</div>';
				html_for_entities += '<div id="collapse-complex" class="panel-collapse collapse" style="height: auto;">';
				html_for_entities += '<div class="panel-body">';
				html_for_entities += '---';
				html_for_entities += '</div></div></div>';
				html_for_entities += '</div>';
				html_for_entities += '</td>';
				html_for_entities += '</tr>';
				
				html_for_entities += '<tr>';
				html_for_entities += '<td>Phantom</td>';
				html_for_entities += '<td><select class="custom-select" id="id-figure-phantom">';
				html_for_entities += '<option value="false">False</option>';
				html_for_entities += '<option value="true">True</option>';
				html_for_entities += '</select></td>';
				html_for_entities += '</tr>';
					
				$('#id-properties-container').html(html_for_entities);
				
			};
			
			function select_entity(position){
				setup_style_definition();
				$('.active-entity').find('a').find('.glyphicon').remove();
				$('.active-entity').addClass('entity').removeClass('active-entity');
				$('#id-entity-'+position).removeClass('entity').addClass('active-entity');
				$('.active-entity').find('a').prepend('<span class="glyphicon glyphicon-ok">&nbsp</span>');
				selected_entity = entities[position];
				$('#id-selected-name').text(selected_entity['name']);
				load_entity_properties();
			};
			
			function load_entity_properties(){
				var graphical_properties = selected_entity['graphical_properties'];
				$('#id-label-icon-select').val(graphical_properties['label_icon']);
				$('#id-label-icon-plac-select').val(graphical_properties['label_placement']);
				$('#id-figure-size-width').val(graphical_properties['size'][0]);
				$('#id-figure-size-height').val(graphical_properties['size'][1]);
				var figure_id = graphical_properties['figure']['id'];
				select_figure(figure_id);
				var panel_container = $('#id-figure-type-container-'+figure_id);
				if(figure_id == figure_constants['rounded']){
					panel_container.find('#id-rounded-xradio').val(graphical_properties['figure']['radios'][0]);
					panel_container.find('#id-rounded-yradio').val(graphical_properties['figure']['radios'][1]);
				}
				else if(figure_id == figure_constants['polygon']){
					panel_container.find('#id-polygon-vertex-qty').val(graphical_properties['figure']['vertex_qty']);
					panel_container.find('#id-polygon-start-angle').val(graphical_properties['figure']['start_angle']);
				}
				else if(figure_id == figure_constants['ellipse']){
					panel_container.find('#id-ellipse-xradio').val(graphical_properties['figure']['radios'][0]);
					panel_container.find('#id-ellipse-yradio').val(graphical_properties['figure']['radios'][1]);
				}
				else if(figure_id == figure_constants['custom']){
					var points = graphical_properties['figure']['points'];
					var html_points = '';
					for (var i = 0; i < points.length; i++){
						 html_points += '<br><input type="number" min="1" max="1000000" class="pointx" placeholder="X" value="'+points[i][0]+'">';
						 html_points += '<input type="number" min="1" max="1000000" class="pointy" placeholder="Y" value="'+points[i][1]+'">';
					}
					panel_container.find('#id-points-container').html(html_points);
				}
				else if(figure_id == figure_constants['image']){
					//$('#').val();
				}
				else if(figure_id == figure_constants['complex']){
					
				}
				$('#id-figure-color').val(graphical_properties['figure']['background_color']);
				$('#id-figure-border').val(graphical_properties['figure']['border']);
				if (graphical_properties['figure']['icon'] != null){
					$('#id-icon-checkbox').prop('checked', true);
					unbind_icon_checkbox(true);
					//$('#id-figure-icon-path').val();
					$('#id-figure-icon-size-w').val(graphical_properties['figure']['icon']['size'][0]);
					$('#id-figure-icon-size-h').val(graphical_properties['figure']['icon']['size'][1]);
					$('#id-figure-icon-pos-x').val(graphical_properties['figure']['icon']['position'][0]);
					$('#id-figure-icon-pos-y').val(graphical_properties['figure']['icon']['position'][1]);
				}
				else{
					$('#id-icon-checkbox').prop('checked',false);
					unbind_icon_checkbox(false);
				}
				$('#id-figure-phantom').val(graphical_properties['phantom']);
			};
			
			function save_current_entity(){
				$('.alert').val('Saving...').fadeIn('slow');
				var icon_properties = null;
				
				if ($('#id-icon-checkbox').prop('checked')){
					icon_properties = {
							path: '',
							size: [$('#id-figure-icon-size-w').val(),$('#id-figure-icon-size-h').val()],
							position: [$('#id-figure-icon-pos-x').val(),$('#id-figure-icon-pos-y').val()]
					};
					$('#id-icon-checkbox').prop('checked');
					unbind_icon_checkbox(true);
					//$('#id-figure-icon-path').val();					
				}
				else{
					$('#id-icon-checkbox').prop('checked',false);
					unbind_icon_checkbox(false);
				}
				var figure_id = selected_figure;
				
				var panel_container = $('#id-figure-type-container-'+figure_id);
				
				var figure_properties = {
						id: figure_id,
						background_color: panel_container.find('#id-figure-color').val(),
						border: panel_container.find('#id-figure-border').val(),
						icon: icon_properties
				};
				
				if(figure_id == figure_constants['rounded']){
					figure_properties['radios'] = [panel_container.find('#id-rounded-xradio').val(),panel_container.find('#id-rounded-yradio').val()];
				}
				else if(figure_id == figure_constants['polygon']){
					figure_properties['vertex_qty'] = panel_container.find('#id-polygon-vertex-qty').val();
					figure_properties['start_angle'] = panel_container.find('#id-polygon-start-angle').val();
				}
				else if(figure_id == figure_constants['ellipse']){
					figure_properties['radios'] = [panel_container.find('#id-ellipse-xradio').val(),panel_container.find('#id-ellipse-yradio').val()];
				}
				else if(figure_id == figure_constants['custom']){
					var xpoints = $(".pointx");
					var ypoints = $(".pointy");
					var points_array = [];
					xpoints.each(function(i, object)
					{
						points_array.push([$(this).val(),'']);					    
					});
					ypoints.each(function(i, object)
					{
						points_array[i][1] = $(this).val();					    
					});
					figure_properties['points'] = points_array;
				}
				else if(figure_id == figure_constants['image']){
					//$('#').val();
					figure_properties['image_path'] = '';
				}
				else if(figure_id == figure_constants['complex']){
					
				}			
				
				var graphical_properties_temp = {
						label_icon: $('#id-label-icon-select').val(),
						label_placement: $('#id-label-icon-plac-select').val(),
						size: [$('#id-figure-size-width').val(),$('#id-figure-size-height').val()],
						figure: figure_properties,
						phantom: $('#id-figure-phantom').val()
				};
				
				selected_entity['graphical_properties'] = graphical_properties_temp;
				
				$('.alert').fadeOut('slow');
			};
			
			function select_figure(position){
				$('.active-figure').find('a').find('span').remove();
				$('.active-figure').addClass('figure').removeClass('active-figure');
				$('#id-figure-type-'+position).removeClass('figure').addClass('active-figure');
				$('.active-figure').find('a').prepend('<span class="glyphicon glyphicon-ok">&nbsp</span>');
				selected_figure = position;
				$('#id-selected-name').text(selected_entity['name']);
			};
			
			function setup_picture_file_content(){
				var break_line = '\n';
				var content = 'import "/model/bpmn2.ecore"';
				content += break_line + 'as MM';
				content += break_line + 'Graphical representation BPMN {';
				
				$('#id-picture-file').val(content);
			};
		
		$(document).ready(function (){
			setup_project();
			$('#id-icon-checkbox').click(function() {
			    var $this = $(this);
			    if ($this.is(':checked')) {
			    	unbind_icon_checkbox(true);
			    } else {
			    	unbind_icon_checkbox(false);
			    }
			});
		}
		);
		
		function setup_project(){
			setup_entities();
			//setup_html_entities();
			setup_style_definition();
			setup_picture_file_content();
		};
		
		function unbind_icon_checkbox(state) {
			if (state){
				$('#id-icon-checkbox-label').html('Selected');
		    	$('#id-icon-table-properties').fadeIn('slow');
			}
			else{
				$('#id-icon-checkbox-label').html('Unselected');
		    	$('#id-icon-table-properties').fadeOut('slow');
			}
		};
				
		
		
	</script>

</body>
</html>