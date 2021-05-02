<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> <!-- Lisätään linkit jqueryn kirjastoon ja validate-kirjastoon -->
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css"> <!-- Kytketään kiinni style.css-tiedostoon css-kansiossa WebContentin alla-->

<title>Asiakkaiden lisäys</title>
</head>
<body>

<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Listaus</span></th>
			</tr>		
			<tr>
				<th>Asiakasnumero</th> <!-- Tehdään otsikkosarakkeet -->
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>		
			<th>Sähköposti</th>		
				<th></th> <!-- Tyhjä sarake -->
			</tr>
		</thead>
		<tbody> <!-- tablebody -->
			<tr>
				<td><input type="text" name="Asiakasnumero" id="asiakas_id"></td>
				<td><input type="text" name="Etunimi" id="enimi"></td>
				<td><input type="text" name="Sukunimi" id="snimi"></td>
				<td><input type="text" name="Puhelinnumero" id="puhelin"></td>
				<td><input type="text" name="Sähköposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lisää"></td> <!-- value -> napin päällä lukee Lisää -->
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>

 $(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaAsiakkaat.jsp";
	});
	$("#tiedot").validate({						
		rules: {
			Asiakasnumero:  {
				required: true,
				number: true,
				minlength: 5,	
				maxlength: 5
			},	
			Etunimi:  {
				required: true,
				minlength: 2				
			},
			Sukunimi:  {
				required: true,
				minlength: 1
			},	
			Puhelinnumero:  {
				required: true,
				minlength: 10,
				maxlength: 13
			},	
			
			Sähköposti:  {
				required: true,
				minlength: 6
			}	
		},
		messages: {
			Asiakasnumero: {     
				required: "Puuttuu",
				number: "Ei kelpaa, syötä vain numeroita",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
			},
			
			Etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			Sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			Puhelinnumero: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä"
				
			},
			Sähköposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},
	submitHandler: function(form) {
				lisaaTiedot();
			}
		});
	}); 
	//funktio tietojen lisäämistä varten. Kutsutaan backin POST-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
	//POST /autot/
	function lisaaTiedot() {
		
		var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
		$("#ilmo").html("XXXXXXXXXXXXX");
		$.ajax({
			url : "listaaAsiakkaat",
			data : formJsonStr,
			type : "POST",
			dataType : "json",
			success : function(result) { //result on joko {"response:1"} tai {"response:0"}     , tiedosto on listaaAutot java-tiedosto  
				
				if (result.response == 0) {
					$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
				} else if (result.response == 1) {
					$("#ilmo").html("Asiakkaan lisääminen onnistui.");
					$("#Asiakasnumero", "#Etunimi", "#Sukunimi", "#Puhelinnumero", "#Sähköposti")
							.val("");
				}
			}
		});
	}
</script>


</body>
</html>