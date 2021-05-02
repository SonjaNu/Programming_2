<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>  <!-- linkataan kiinni jqueryn kirjastoon -->

<link rel="stylesheet" type="text/css" href="css/style.css"> <!--  linkataan css-tiedosto kylkeen -->

<title>Asiakkaiden haku, listaus, lis�ys ja poisto</title> <!-- N�kyy nettisivun otsikkona -->

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
			<th colspan="6" class="oikealle"><span id="uusiAsiakas">Lis�� uusi asiakas</span></th> <!-- Lis�t��n id uuden asiakkaan lis��miselle, scriptiin laitetaan kutsu -->
		</tr>	
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="4"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>	
		
				
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
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaAsiakas.jsp"; /* M��ritell��n sijainti */
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){		
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteri� painettu, ajetaan haku
			  haeAsiakkaat();
		  }
	});
	$("#hakusana").focus();//vied��n kursori hakusana-kentt��n sivun latauksen yhteydess�
});	

	
function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"DWProjekti_ListausHaku/"+$("#hakusana").val(), 
		type:"GET", 
		dataType:"json", 
		success:function(result){ //Funktio palauttaa tiedot resultissa json-objektina GET kutsuu do.get -metodia, tietotyyppi, jota odotetaan takaisin, on json		
		
			$.each(result.DWProjekti_ListausHaku, function(i, field){  /* T�m� luuppi k�y l�pi kaikki asiakkaat, jotka l�ytyi asiakkaat-listasta */
        	var htmlStr;
        	htmlStr+="<tr>"; 							/* lis�t��n uusi rivi */
        	htmlStr+="<td>"+field.asiakas_id+"</td>"; /* lis�t��n uusi sarake */
        	htmlStr+="<td>"+field.enimi+"</td>";
        	htmlStr+="<td>"+field.snimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+")>Poista</span></td>"; //Tehd��n uusi sarake, johon tulee poista-ruksikohta
        	
        	//Poista-kohdat muutetaan linkeiksi                     <td>Poista</td>
        	//Huom! Poistaminen perustuu aina p��avaimeen (Primary Key), ei saa perustua mihink��n muuhun, t�ss� p��avain on asiakas_id
        	//occlick-komennolla kutsutaan poista-nimist� funktiota ja sille v�litet��n p��avain eli asiakas_id
        	//jos p��avain olisi string (nyt se on int), sen ymp�rill� pit�isi olla hipsut '' eli ('"+field.asiakas_id+"')
        	//Tupsut "" katkaisevat stringin eli
        	//pelkk�� teksti�: "<span class='poista' onclick=poista("
        	//pelkk�� teksti�: ")>Poista</span></td>"
        	htmlStr+="</tr>"; 							/* laitetaan rivi kiinni */
        	$("#listaus tbody").append(htmlStr);
	
	
        });	
    }});
};	

function poista(asiakas_id) {
	
	if(confirm("Poista auto " + asiakas_id +"?")) {
		$.ajax({url:"listaaAsiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto ep�onnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+rekno).css("background-color", "red"); //V�rj�t��n poistetun asiakkaan rivi
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