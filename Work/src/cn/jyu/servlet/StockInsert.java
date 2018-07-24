package cn.jyu.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.jyu.dao.StockDao;


public class StockInsert extends HttpServlet{
	
	private StockDao stockDao = new StockDao();

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		String addContext = req.getParameter("addContext");
		String addCode = req.getParameter("addCode");
		
		//String addName = addContext.split(",")[0];
		
		addContext += ","+addCode;
		
		PrintWriter result = resp.getWriter();
		
		int id = stockDao.insert(addCode);
		if(id != 0){
			addContext += ","+id;
			result.print(addContext);
		}else{
		}
	}
	
}
