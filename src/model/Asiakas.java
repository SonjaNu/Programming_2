package model;

public class Asiakas {  //tämän luokan perusteella luodaan asiakas-olioita ohjelmassamme
	
	private String enimi, snimi, puhelin, sposti; //tässä meidän attribuutit, vertaa tietokannan attribuutteihin (samat)
	private int asiakas_id;
	public Asiakas() {   //luodaan konstruktori (source -> Generate constructors from supercalss)
		super();
		
	}
	public Asiakas(String enimi, String snimi, String puhelin, String sposti, int asiakas_id) { //paramterillinen konstruktori (source -> generate constructor using fields) 
		super();
		this.enimi = enimi;
		this.snimi = snimi;
		this.puhelin = puhelin;
		this.sposti = sposti;
		this.asiakas_id = asiakas_id;
	}
	public String getEnimi() {  //luodaan getterit ja setterit (source -> generate getters and setters
		return enimi;
	}
	public void setEnimi(String enimi) {
		this.enimi = enimi;
	}
	public String getSnimi() {
		return snimi;
	}
	public void setSnimi(String snimi) {
		this.snimi = snimi;
	}
	public String getPuhelin() {
		return puhelin;
	}
	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}
	public String getSposti() {
		return sposti;
	}
	public void setSposti(String sposti) {
		this.sposti = sposti;
	}
	public int getAsiakas_id() {
		return asiakas_id;
	}
	public void setAsiakas_id(int asiakas_id) {
		this.asiakas_id = asiakas_id;
	}
	@Override
	public String toString() {  //luodaan toString (source -> toString)
		return "Asiakas [enimi=" + enimi + ", snimi=" + snimi + ", puhelin=" + puhelin + ", sposti=" + sposti
				+ ", asiakas_id=" + asiakas_id + "]";
	}
		
}
