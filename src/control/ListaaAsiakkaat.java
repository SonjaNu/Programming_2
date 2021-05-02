package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Asiakas;
import model.dao.Dao;


@WebServlet("/listaaAsiakkaat/*")
public class ListaaAsiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public ListaaAsiakkaat() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doGet()");
	
	String pathInfo = request.getPathInfo();	//haetaan kutsun polkutiedot, esim. /eveliina			
	System.out.println("polku: "+pathInfo);	
	String hakusana = pathInfo.replace("/", "");

	Dao dao = new Dao();
	ArrayList<Asiakas> asiakkaat = dao.listaaKaikki(hakusana);
	System.out.println(asiakkaat);
	
	String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
	response.setContentType("application/json");
	PrintWriter out = response.getWriter();
	out.println(strJSON);		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doPost()");
	
	JSONObject jsonObj = new JsonStrToObj().convert(request); //Muutetaan kutsun mukana tuleva json-string json-objektiksi			
	Asiakas asiakas = new Asiakas();
	asiakas.setAsiakas_id(jsonObj.getInt("Asiakasnumero"));
	asiakas.setEnimi(jsonObj.getString("Etunimi"));
	asiakas.setSnimi(jsonObj.getString("Sukunimi"));
	asiakas.setPuhelin(jsonObj.getString("Puhelinnumero"));
	asiakas.setSposti(jsonObj.getString("Sähköposti"));
	
	response.setContentType("application/json");
	PrintWriter out = response.getWriter();
	Dao dao = new Dao();			
	if(dao.lisaaAsiakas(asiakas)){ //metodi palauttaa true/false
		out.println("{\"response\":1}");  //Auton lisääminen onnistui {"response":1}
	}else{
		out.println("{\"response\":0}");  //Auton lisääminen epäonnistui {"response":0}
	}		

	}

	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doPut()");
	}

	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doDelete()");
	String pathInfo = request.getPathInfo();	//haetaan kutsun polkutiedot, esim. /12345		
	System.out.println("polku: "+pathInfo);	
	
	String poistettava_asiakas_id = pathInfo.replace("/", "");

	Dao dao = new Dao();
	
	response.setContentType("application/json");
	PrintWriter out = response.getWriter();
				
	if(dao.poistaAsiakas(poistettava_asiakas_id)){ //metodi palauttaa true/false
		out.println("{\"response\":1}");  //Asiakkaan poistaminen onnistui {"response":1}
	}else{
		out.println("{\"response\":0}");  //Asiakkaan poistaminen epäonnistui {"response":0}
	}		
	
	
	}

}
