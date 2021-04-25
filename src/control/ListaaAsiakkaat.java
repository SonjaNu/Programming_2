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


@WebServlet("/listaaAsiakkaat")
public class ListaaAsiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public ListaaAsiakkaat() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doGet()");
	Dao dao = new Dao();
	ArrayList<Asiakas> asiakkaat = dao.listaaAsiakkaat();
	System.out.println(asiakkaat);
	
	String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
	response.setContentType("application/json");
	PrintWriter out = response.getWriter();
	out.println(strJSON);		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doPost()");
	}

	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doPut()");
	}

	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("ListaaAsiakkaat.doDelete()");
	}

}
