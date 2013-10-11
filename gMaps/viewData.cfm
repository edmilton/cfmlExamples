<cfprocessingdirective pageEncoding="utf-8"/>

<!--- 
	 Developed by Edmilton @ed_neves / edmilton dot neves at gmail dot com 
	 (inspired by Paulo Evaristo)
	 11 Oct 2013	 
--->

<!--- Put your google key --->
<cfset gKey = 'YOUR_GOOGLE_KEY'>

<!doctype html>
<html lang="en">
<head>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <meta http-equiv=expires content="Mon, 06 Jan 1990 00:00:01 GMT">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">		

	<title>Example CFML and Google Maps</title>

	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=<cfoutput>#gKey#</cfoutput>&sensor=false"></script>	
	<script type="text/javascript" src="./js/markerclusterer.js"></script>
	<script type="text/javascript" src="./js/jquery-1.9.1.min.js"></script>

	<cfif isDefined("form.processar")>
	    <script type="text/javascript">
				    	 
			var map;
			var markers = [];
			var markersUO =[];
			var markerCluster;
			var infoWindow = new google.maps.InfoWindow;
			
			var rows = new Array(
										<!--- loop over a query here --->
										new Array("-23.6066586","-46.72745499999996","./img/pin_location_green.png", "Teste 1", "Doe", "Ok", "RUA CLEMENTINE BRENNE", "507", "PARAISOPOLIS", "05659000"),
										new Array("-23.5956954","-46.73007799999999","./img/pin_location_green.png", "Teste 2", "Doe", "Ok", "RUA DIAS VIEIRA", "100", "JARDIM MONTE KEMEL", "05632090"),
										new Array("-23.595345","-46.73154640000001","./img/pin_location_green.png", "Teste 3", "Doe", "Ok", "RUA JOAQUIM GALVÃO", "350", "VILA SONIA", "05627010")
										);
			
			function initialize() {
				var group;
				<cfif isDefined("form.group")>
					group = true;
				<cfelse>
					group = false;
				</cfif>

				var center = new google.maps.LatLng(-23.5505233, -46.63429819999999);
				var mapOptions = {
				  zoom: 11,
				  center: center,
				  mapTypeId: google.maps.MapTypeId.ROADMAP
				};
				map = new google.maps.Map(document.getElementById('map_canvas'),mapOptions);
				
				showData(group);
			}
			
			function showData(isClusterizado){			
				var imagem            = "";
			
				for( i = 0; i < rows.length; i++ ){
					var point = new google.maps.LatLng(rows[i][0], rows[i][1]);	
							
				  	imagem = rows[i][2];			
					marker = new google.maps.Marker({ position: point,
													  icon: imagem,
													  zIndex: i,
													  map: map
												    });
					google.maps.event.addListener(marker, 'click', showDetails);
					markers.push(marker);	
					   
				}
			
				if(isClusterizado){
				  var markerCluster = new MarkerClusterer(map, markers);
				}else{
				  var markerCluster = new MarkerClusterer(map, null);
				}
			}	
			
			function showDetails() {
				var marker = this;
				var latLng = marker.getPosition();	
				var index  = marker.getZIndex();	  
				infoWindow.setContent("<table width='350px' border='0' cellspacing='1' cellpadding='1'>" 
										+"          <tr>"
										+"            <td colspan=2><b>Details:</b>&nbsp;" + rows[marker.zIndex][3] + "</td>"
										+"          </tr>"		
										+"          <tr>"
										+"            <td colspan=2><b>Name:</b>&nbsp;" + rows[marker.zIndex][4] +"</td>"            
										+"          </tr>"	
										+"          <tr>"
										+"            <td colspan=2><b>Status:</b>&nbsp;" + rows[marker.zIndex][5] + "</td>"            
										+"          </tr>"																		
										+"          <tr>"
										+"            <td colspan=2><b>Location:</b>&nbsp;" + rows[marker.zIndex][6] + ", " + rows[marker.zIndex][7] + " - " + rows[marker.zIndex][8] + " - " + rows[marker.zIndex][9] + "</td>"
										+"          </tr>"																			
										+"          <tr>"
										+"            <td width='151px'><img src='http://maps.googleapis.com/maps/api/streetview?size=150x100&location=" + rows[marker.zIndex][0]  +  ",%20" + rows[marker.zIndex][1]  +  "&heading=284&sensor=false' ></td>"
										+"          </tr>"									
										+"</table>");
				infoWindow.open(map, marker);
			}; 
			
			$(document).ready(function(){
				<cfif isDefined("form.group")>
					document.getElementById("group").checked = true;  
				</cfif>				
			});


		</script>
	</cfif>

    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>

</head>
<body <cfif isDefined("form.processar")>onload="initialize()" </cfif>>
	<form method="post">
		<p>This is a simple example using CFML and Google Maps (v3) to show data.</p>
		<input type="hidden" name="processar">
		<input name="group" id="group" type="checkbox">Group
		<input type="submit" value="Show Map">
	</form>
	<div id="map_canvas"></div>
</body>
</html>