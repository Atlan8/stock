package cn.jyu.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class StockDao extends BaseDao{
	
	public StockDao(){
		getConnection();
	}

	public int insert(String stCode){
		Connection connection = getConnection();
		String sql = "insert into s_code(st_code) values(?)";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, stCode);
			ps.executeUpdate();
			return getid();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally{
			closeConnection(connection);
		}
	}
	
	public int getid(){
		Connection connection = getConnection();
		String sql = "select max(id) as id from s_code";
		try {
			Statement s = connection.createStatement();
			ResultSet result = s.executeQuery(sql);
			result.next();
			int id = result.getInt(1);
			return id;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally{
			closeConnection(connection);
		}
	}
	
	public void delete(Integer id){
		Connection connection = getConnection();
		String sql = "delete from s_code where id = ?";
		try {
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeConnection(connection);
		}
	}
	
}
