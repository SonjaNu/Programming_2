<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>  <!-- linkataan kiinni jqueryn kirjastoon -->

<link rel="stylesheet" type="text/css" href="css/style.css"> <!--  linkataan css-tiedosto kylkeen -->

<title>Asiakkaiden haku, listaus, lisäys ja poisto</title> <!-- Näkyy nettisivun otsikkona -->

<style>
.oikealle{
	text-align: right;
}
</style>

</head>
<body>

<!-- table { font-size: 20pt; color: green; background-color: blue; border-width: 5pt; border-color: red; }
th { font-size: 25pt; } -->

 
 <table id="listaus" >


	<thead>		
	
	<tr>
			<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th> <!-- Lisätään id uuden asiakkaan lisäämiselle, scriptiin laitetaan kutsu -->
		</tr>	
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="4"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>	
		
				
		<tr>
			<th>Asiakasnumero</th> <!-- Tehdään otsikkosarakkeet -->
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>		
			<th>Sähköposti</th>						
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>


<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaAsiakas.jsp"; /* Määritellään sijainti */
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){		
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeAsiakkaat();
		  }
	});
	$("#hakusana").focus();//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
});	

	
function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"DWProjekti_ListausHaku/"+$("#hakusana").val(), 
		type:"GET", 
		dataType:"json", 
		success:function(result){ //Funktio palauttaa tiedot resultissa json-objektina GET kutsuu do.get -metodia, tietotyyppi, jota odotetaan takaisin, on json		
		
			$.each(result.DWProjekti_ListausHaku, function(i, field){  /* Tämä luuppi käy läpi kaikki asiakkaat, jotka löytyi asiakkaat-listasta */
        	var htmlStr;
        	htmlStr+="<tr>"; 							/* lisätään uusi rivi */
        	htmlStr+="<td>"+field.asiakas_id+"</td>"; /* lisätään uusi sarake */
        	htmlStr+="<td>"+field.enimi+"</td>";
        	htmlStr+="<td>"+field.snimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+")>Poista</span></td>"; //Tehdään uusi sarake, johon tulee poista-ruksikohta
        	
        	//Poista-kohdat muutetaan linkeiksi                     <td>Poista</td>
        	//Huom! Poistaminen perustuu aina pääavaimeen (Primary Key), ei saa perustua mihinkään muuhun, tässä pääavain on asiakas_id
        	//occlick-komennolla kutsutaan poista-nimistä funktiota ja sille välitetään pääavain eli asiakas_id
        	//jos pääavain olisi string (nyt se on int), sen ympärillä pitäisi olla hipsut '' eli ('"+field.asiakas_id+"')
        	//Tupsut "" katkaisevat stringin eli
        	//pelkkää tekstiä: "<span class='poista' onclick=poista("
        	//pelkkää tekstiä: ")>Poista</span></td>"
        	htmlStr+="</tr>"; 							/* laitetaan rivi kiinni */
        	$("#listaus tbody").append(htmlStr);
	
	
        });	
    }});
};	

function poista(asiakas_id) {
	
	if(confirm("Poista auto " + asiakas_id +"?")) {
		$.ajax({url:"listaaAsiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+rekno).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
				haeAsiakkaat();        
	        }
		}
		}
	}
	}

	


	
</script>


</body>
</html>