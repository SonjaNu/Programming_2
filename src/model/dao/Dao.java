package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Asiakas; //asiakas pitää importata, jotta sitä voi käyttää

//import sql_java_alkeet.Lukija;
//import sql_java_tehtava.AsiakasOhjelmaMyyntisqlite;

public class Dao {  //Dao-luokka, joka on yhteydessä tietokantaan ja siältää metodit, joita tarvitaan tietokannasta hakemiseen ja sinne lisäämiseen
	
	private Connection con=null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep=null; 
	private String sql;
	private String db ="Myynti.sqlite";
	

	private Connection yhdista(){
    	Connection con = null;    	
    	String path = System.getProperty("catalina.base");    	
    	path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/"); //Eclipsessa
    	//path += "/webapps/"; //Tuotannossa. Laita tietokanta webapps-kansioon
    	String url = "jdbc:sqlite:"+path+db;    	
    	try {	       
    		Class.forName("org.sqlite.JDBC");
	        con = DriverManager.getConnection(url);	
	        System.out.println("Yhteys avattu.");
	     }catch (Exception e){	
	    	 System.out.println("Yhteyden avaus epäonnistui.");
	        e.printStackTrace();	         
	     }
	     return con;
	}
	

	
	
//	private Connection yhdista(){		 //tällä metodilla otetaan yhteys tietokantaan
//		Connection con = null;    	
//		String path = System.getProperty("user.dir")+"/";    	
//		String url = "jdbc:sqlite:"+path+db; 
//
//		try {	       
//			Class.forName("org.sqlite.JDBC");
//			con = DriverManager.getConnection(url);	
//			//  System.out.println("Yhteys avattu.");
//		}catch (Exception e){	
//			System.out.println("Yhteyden avaus epäonnistui.");
//			e.printStackTrace();	         
//		}
//		return con;
//	}
	
	public ArrayList<Asiakas> listaaAsiakkaat(){
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat";       //haetaan asiakkaat-taulusta kaikki (*) tiedot, jos haluttaisiin hakea vain tiettyjä tietoja, olisi se kerrottava erikseen
		try {
			con=yhdista();
			if(con!=null){ //jos yhteys onnistui
				stmtPrep = con.prepareStatement(sql);        		
				rs = stmtPrep.executeQuery();   
				if(rs!=null){ //jos kysely onnistui					
				
					while(rs.next()){
						Asiakas asiakas = new Asiakas();
						
						asiakas.setAsiakas_id(rs.getInt(1));
						asiakas.setEnimi(rs.getString(2));
						asiakas.setSnimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));	
						asiakas.setSposti(rs.getString(5));	
						asiakkaat.add(asiakas);

		
					}
					System.out.println();
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return asiakkaat;
	}
	
	
		

}
