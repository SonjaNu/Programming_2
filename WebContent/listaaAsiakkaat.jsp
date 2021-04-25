<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>  <!-- linkataan kiinni jqueryn kirjastoon -->
<title>Asiakkaiden haku ja listaus</title> <!-- N�kyy nettisivun otsikkona -->

<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>

<!-- table { font-size: 20pt; color: green; background-color: blue; border-width: 5pt; border-color: red; }
th { font-size: 25pt; } -->

 
 <table id="listaus" style="width:100%" 
 
  
 >


	<thead>				
		<tr>
			<th>Asiakasnumero</th> <!-- Tehd��n otsikkosarakkeet -->
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>		
			<th>S�hk�posti</th>						
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>


<script>
$(document).ready(function(){
	$.ajax({url:"listaaAsiakkaat", 
		type:"GET", 
		dataType:"json", 
		success:function(result){ //Funktio palauttaa tiedot resultissa json-objektina GET kutsuu do.get -metodia, tietotyyppi, jota odotetaan takaisin, on json		
		
			$.each(result.asiakkaat, function(i, field){  /* T�m� luuppi k�y l�pi kaikki asiakkaat, jotka l�ytyi asiakkaat-listasta */
        	var htmlStr;
        	htmlStr+="<tr>"; 							/* lis�t��n uusi rivi */
        	htmlStr+="<td>"+field.asiakas_id+"</td>"; /* lis�t��n uusi sarake */
        	htmlStr+="<td>"+field.enimi+"</td>";
        	htmlStr+="<td>"+field.snimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="</tr>"; 							/* laitetaan rivi kiinni */
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
});	

</script>


</body>
</html>