package cn.jyu.test;

import java.sql.Connection;

import org.junit.Test;

import cn.jyu.dao.StockDao;

public class SqlTest {
	
	@Test
	public void test1(){
		StockDao scon = new StockDao();
		
	}
	@Test
	public void test2(){
		StockDao scon = new StockDao();
		System.out.println(scon.getid());
	}
	
}
