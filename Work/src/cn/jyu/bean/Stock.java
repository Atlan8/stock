package cn.jyu.bean;

public class Stock {
	private Integer id;
	private String stCode;
	private String name;
	private String f1;
	private String f2;
	private String f3;
	private String i1;
	public String getF1() {
		return f1;
	}
	public void setF1(String f1) {
		this.f1 = f1;
	}
	public String getF2() {
		return f2;
	}
	public void setF2(String f2) {
		this.f2 = f2;
	}
	public String getF3() {
		return f3;
	}
	public void setF3(String f3) {
		this.f3 = f3;
	}
	public String getI1() {
		return i1;
	}
	public void setI1(String i1) {
		this.i1 = i1;
	}
	public String getI2() {
		return i2;
	}
	public void setI2(String i2) {
		this.i2 = i2;
	}
	private String i2;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStCode() {
		return stCode;
	}
	public void setStCode(String stCode) {
		this.stCode = stCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "Stock [id=" + id + ", stCode=" + stCode + ", name=" + name
				+ ", f1=" + f1 + ", f2=" + f2 + ", f3=" + f3 + ", i1=" + i1
				+ ", i2=" + i2 + "]";
	}
	
	
}
