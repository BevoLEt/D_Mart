<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartProc</title>
</head>
<body>
<% 
	String memberId = (String)session.getAttribute("memberId");
	String iname = request.getParameter("product_no");
	String inum = request.getParameter("product_num");

	//System.out.println(iname);
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;

	String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";
	String DB_URL="jdbc:mysql://127.0.0.1:3306/mysql?&userSSL=false";
	String USER_NAME="min";
	String PASSWORD="seok";
	
	conn=DriverManager.getConnection(DB_URL,USER_NAME,PASSWORD);
	
	String query = "select CartID,CustomerIDe from CART ,CUSTOMER where CustomerIDe=CustomerID and CID_String='" + memberId + "';";
	
	int cartID = 0, CustomerID = 0;
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	
	while(rs.next())
	{
		cartID = rs.getInt(1);
		CustomerID = rs.getInt(2);
	}
	
	query = "INSERT INTO CART_PRODUCT_LIST VALUES('" + iname + "', " + cartID + ", " + CustomerID + ", " + inum + ");"; //
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	pstmt.executeUpdate();
	
	//System.out.println(memberId);
	
	
%>

	<script type="text/javascript">
		alert("장바구니에 담겼습니다!");
		location.href="productlist.jsp"; 
	</script>
</body>
</html>