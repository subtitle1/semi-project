package dao;

import static utils.ConnectionUtil.getConnection;

import java.util.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Criteria;
import dto.ProductDetailDto;
import vo.Product;

public class ProductDao {
	
	private static ProductDao self = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return self;
	}

	public int selectTotalProductsCount() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_products";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");

    return totalRecords;
	}
	
	/**
	 * 프로덕트 객체를 db에 입력하는 메소드
	 * @param product
	 * @throws SQLException
	 */
	public void insertProduct(Product product) throws SQLException {
		String sql = "insert into tb_products "
				+ "(product_no, product_category, product_name, "
				+ "product_img, product_brand, product_price, "
				+ "product_disprice, product_gender ) "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?) ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, product.getNo());
		pstmt.setString(2, product.getCategory());
		pstmt.setString(3, product.getName());
		pstmt.setString(4, product.getPhoto());
		pstmt.setString(5, product.getBrand());
		pstmt.setInt(6, product.getPrice());
		pstmt.setInt(7, product.getDisPrice());
		pstmt.setString(8, product.getGender());
	
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public List<ProductDetailDto> selectAllProductDetail(int begin, int end) throws SQLException{
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender, "
				+ "product_detail_no, product_size, product_stock "
				+ "from (select row_number() over (order by p.product_no asc) rn, "
				+" p.product_no, p.product_name, p.product_img, p.product_price, "
						+ "p.product_disprice, p.product_brand, "
						+ "p.product_category, p.product_created_date, p.product_gender, "
						+ "s.product_detail_no, s.product_size, s.product_stock "
				   + "from tb_products p, tb_product_stocks s "
				   + "where p.product_no = s.product_no) "
				   + "where rn >= ? and rn <= ? "
				   + "order by product_no asc ";
		
		List<ProductDetailDto> productDetails = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ProductDetailDto productDetail = new ProductDetailDto();

			productDetail.setProductNo(rs.getInt("product_no"));
			productDetail.setName(rs.getString("product_name"));
			productDetail.setPhoto(rs.getString("product_img"));
			productDetail.setName(rs.getString("product_name"));
			productDetail.setPrice(rs.getInt("product_price"));
			productDetail.setDisPrice(rs.getInt("product_disprice"));
			productDetail.setBrand(rs.getString("product_brand"));
			productDetail.setCategory(rs.getString("product_category"));
			productDetail.setGender(rs.getString("product_gender"));
			productDetail.setCreatedDate(rs.getDate("product_created_date"));
			productDetail.setProductStockNo(rs.getInt("product_detail_no"));
			productDetail.setProductNo(rs.getInt("product_no"));
			productDetail.setSize(rs.getInt("product_size"));
			productDetail.setStock(rs.getInt("product_stock"));
			
			productDetails.add(productDetail);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productDetails;
	}
	
	
	/**
	 * 상품 번호로 상품정보 반환
	 * @param no
	 * @return Product 상품
	 * @throws SQLException
	 */
	public Product selectProductbyNo(int no) throws SQLException{
		Product product = new Product();
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender "
			   + "from tb_products "
			   + "where product_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);	
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPhoto(rs.getString("product_img"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDisPrice(rs.getInt("product_disprice"));
			product.setBrand(rs.getString("product_brand"));
			product.setCategory(rs.getString("product_category"));
			product.setGender(rs.getString("product_gender"));
			product.setCreatedDate(rs.getDate("product_created_date"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return product;
	}
	
	/**
	 * 모든 상품 정보를 반환한다.
	 * @return products 모든상품정보
	 * @throws SQLException
	 */
	public List<Product> selectAllProducts(int begin, int end) throws SQLException{
		List<Product> products = new ArrayList<>();
		
		String sql = "select product_no, product_name, product_img, product_price, "
				 + "product_disprice, product_brand, "
				 + "product_category, product_created_date, product_gender "
		   + "from (select row_number() over (order by product_no desc) rn, "
		   + "             product_no, product_name, product_img, product_price,  "
		   + "             product_disprice, product_brand, "
		   + "			   product_category, product_created_date, product_gender "
		   + "      from tb_products) "
		   + "where rn >= ? and rn <= ? "
		   + "order by product_no desc ";
		
	
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPhoto(rs.getString("product_img"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDisPrice(rs.getInt("product_disprice"));
			product.setBrand(rs.getString("product_brand"));
			product.setCategory(rs.getString("product_category"));
			product.setGender(rs.getString("product_gender"));
			product.setCreatedDate(rs.getDate("product_created_date"));
		
			products.add(product);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	/**
	 * 세일 상품 정보를 반환한다.
	 * @param begin	제품수량
	 * @param end 제품수량
	 * @return products 모든상품정보
	 * @throws SQLException
	 */
	public List<Product> selectProductsOnSale(int begin, int end) throws SQLException{
		List<Product> products = new ArrayList<>();

		String sql = "select product_no, product_name, product_img, product_price, "
				 + "product_disprice, product_brand, "
				 + "product_category, product_created_date, product_gender "
		   + "from (select row_number() over (order by product_created_date desc) rn, "
		   + "             product_no, product_name, product_img, product_price,  "
		   + "             product_disprice, product_brand, "
		   + "			   product_category, product_created_date, product_gender "
		   + "      from tb_products"
		   + "		where  product_disprice is not null) "
		   + "where rn >= ? and rn <= ? "
		   + "order by product_created_date desc ";


		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			Product product = new Product();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPhoto(rs.getString("product_img"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDisPrice(rs.getInt("product_disprice"));
			product.setBrand(rs.getString("product_brand"));
			product.setCategory(rs.getString("product_category"));
			product.setGender(rs.getString("product_gender"));
			product.setCreatedDate(rs.getDate("product_created_date"));

			products.add(product);
		}
		rs.close();
		pstmt.close();
		connection.close();

		return products;
	}

	
	/**
	 * 카테고리별 상품에서 브랜드,성별,정렬 순의 옵션이 반영된 값을 반환한다.
	 * @param c
	 * @return 카테고리별 옵션적용된 상품.
	 * @throws SQLException
	 */
	public List<Product> selectProductsByOption(Criteria c) throws SQLException{
		List<Product> products =  new ArrayList<>();

		String sql = "select * "
				   + "from tb_products "
				   + "where product_category = ? ";
		if (c.getBrand()!= null) {
			  sql += "and product_brand =  '"+ c.getBrand() +"' ";
		}		   
		if (c.getGender()!= null) {
			  sql += "and product_gender =  '"+ c.getGender() +"' ";
		}		   
		if (c.getSort()!= null ) {
			if ("new".equals(c.getSort())) {
				sql += "order by product_no desc ";
			} else if ("low".equals(c.getSort())) {
				sql += "order by product_price asc ";
			} else if ("high".equals(c.getSort())) {
				sql += "order by product_price desc ";				
			}			
		} else {		   
			  sql += "order by product_no desc ";
		}
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, c.getCategory());
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();

			product.setNo(rs.getInt("product_no"));
			product.setPhoto(rs.getString("product_img"));
			product.setBrand(rs.getString("product_brand"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDisPrice(rs.getInt("product_disprice"));
			
			products.add(product);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	/**
	 * 모든 상품 중 옵션별로 분류된 데이터만 반영한다.
	 * @param c
	 * @return 옵션별로 분류된 모든 상품.
	 * @throws SQLException
	 */
	public List<Product> selectProductsBrandAllByOption(Criteria c) throws SQLException{
		List<Product> products =  new ArrayList<>();
		
		String sql = "select * "
				+ "from tb_products ";
		if (c.getBrand()!= null) {
			sql += "where product_brand =  '"+ c.getBrand() +"' ";
		}		   
		if (c.getGender()!= null) {
			sql += "and product_gender =  '"+ c.getGender() +"' ";
		}		   
		if (c.getSort()!= null ) {
			if ("new".equals(c.getSort())) {
				sql += "order by product_no desc ";
			} else if ("low".equals(c.getSort())) {
				sql += "order by product_price asc ";
			} else if ("high".equals(c.getSort())) {
				sql += "order by product_price desc ";				
			}			
		} else {		   
			sql += "order by product_no desc ";
		}
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();
			
			product.setNo(rs.getInt("product_no"));
			product.setPhoto(rs.getString("product_img"));
			product.setBrand(rs.getString("product_brand"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDisPrice(rs.getInt("product_disprice"));
			
			products.add(product);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	/**
	 * 세일상품을 옵션으로 분류한 정보를 반영한다.
	 * @param c
	 * @return 옵션별로 분류된 세일상품.
	 * @throws SQLException
	 */
	public List<Product> selectProductsOnSaleByOption(Criteria c) throws SQLException{
		List<Product> products =  new ArrayList<>();
		
		String sql = "select * "
				   + "from tb_products "
				   + "where product_disPrice is not null ";
		if (c.getBrand()!= null) {
			  sql += "and product_brand =  '"+ c.getBrand() +"' ";
		}		   
		if (c.getGender()!= null) {
			  sql += "and product_gender =  '"+ c.getGender() +"' ";
		}		   
		if (c.getSort()!= null ) {
			if ("new".equals(c.getSort())) {
				sql += "order by product_no desc ";
			} else if ("low".equals(c.getSort())) {
				sql += "order by product_price asc ";
			} else if ("high".equals(c.getSort())) {
				sql += "order by product_price desc ";				
			}			
		} else {		   
			  sql += "order by product_no desc ";
		}
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			Product product = new Product();

			product.setNo(rs.getInt("product_no"));
			product.setPhoto(rs.getString("product_img"));
			product.setBrand(rs.getString("product_brand"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDisPrice(rs.getInt("product_disprice"));
			
			products.add(product);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}

	public int getProductNo() throws SQLException {
		String sql = "select product_no.nextval seq from dual";
		
		int productNo = 0;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		
		productNo = rs.getInt("seq");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productNo;
	}
	
}

