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
		   + "from (select row_number() over (order by product_created_date desc) rn, "
		   + "             product_no, product_name, product_img, product_price,  "
		   + "             product_disprice, product_brand, "
		   + "			   product_category, product_created_date, product_gender "
		   + "      from tb_products) "
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
	 * 카테고리별 상품정보를 반환한다.
	 * @param categoryName
	 * @return products 카테고리별 상품정보.
	 * @throws SQLException
	 */
	public List<Product> selectProductsByCategory(String category) throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender "
			   + "from tb_products "
			   + "where product_category = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, category);
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
	 * 브랜드별 상품정보를 반환한다.
	 * @param categoryName
	 * @return products 카테고리별 상품정보.
	 * @throws SQLException
	 */
	public List<Product> selectProductsByBrand(String brand) throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender "
			   + "from tb_products "
			   + "where product_brand = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, brand);
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
	 * 높은가격순 상품정보를 반환한다.
	 * @return products 세일상품정보.
	 * @throws SQLException
	 */
	public List<Product> selectProductsByPriceDesc() throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender "
			   + "from tb_products "
			   + "order by product_price desc ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
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
	 * 낮은가격순 상품정보를 반환한다.
	 * @return products 세일상품정보.
	 * @throws SQLException
	 */
	public List<Product> selectProductsByPriceAsc() throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender "
			   + "from tb_products "
			   + "order by product_price asc ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
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
	 * 성별 상품정보를 반환한다.
	 * @return products 
	 * @throws SQLException
	 */
	public List<Product> selectProductsByGender(String gender) throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "select product_no, product_name, product_img, product_price, "
				+ "product_disprice, product_brand, "
				+ "product_category, product_created_date, product_gender "
			   + "from tb_products "
			   + "where product_gender = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, gender);
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
		
		System.out.println(sql);
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

}

