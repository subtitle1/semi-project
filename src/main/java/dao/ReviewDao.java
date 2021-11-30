package dao;

import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import dto.ReviewDetailDto;
import vo.Product;
import vo.Review;
import vo.Member;

/**
 * 리뷰등록, 리뷰 목록조회, 리뷰 수정, 리뷰 삭제, 추천 추가 기능을 제공하는 클래스다.
 * @author i
 *
 */
public class ReviewDao {

	private static ReviewDao self = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return self;
	}

		/**
		 * 지정된 리뷰 정보를 테이블에 저장한다.
		 * @param review 리뷰 정보
		 * @throws SQLException
		 */
		public void insertReview(Review review) throws SQLException {
	    	String sql = "insert into tb_reviews (review_no, member_no, review_content, product_no) "
	    			   + "values (review_no_seq.nextval, ?, ?) ";
	    	
	    	Connection connection = getConnection();
	    	PreparedStatement pstmt = connection.prepareStatement(sql);
	    	pstmt.setInt(1, review.getMemberNo());
	    	pstmt.setString(2, review.getContent());
	    	
	    	pstmt.executeUpdate();
	    	
	    	pstmt.close();
	    	connection.close();
		}
		
		/**
		 * 수정된 정보가 포함된 리뷰 정보를 테이블에 반영한다.
		 * @param review
		 * @throws SQLException
		 */
		public void updateReview(Review review) throws SQLException {
			String sql = "update tb_reviews "
					   + "set "
					   + "	review_content = ?, "
					   + "	review_like_count = ? "
					   + "where review_no= ? ";
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			
			pstmt.setString(1, review.getContent());
			pstmt.setInt(2, review.getLikeCount());
			pstmt.setInt(3, review.getNo());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			connection.close();
		}
		
		/**
		 * 지정된 번호의 리뷰를 삭제한다.
		 * @param no 글번호
		 * @throws SQLException
		 */
		public void deleteReview(int no) throws SQLException {
			String sql = "update tb_reviews "
					   + "set "
					   + "	review_deleted = 'Y' "
					   + "where review_no = ? ";
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			connection.close();
		}
		
		/**
		 * 테이블에 저장된 리뷰정보의 갯수를 반환한다.
		 * @return 리뷰 정보 갯수
		 * @throws SQLException
		 */
		public int selectTotalReviewCount() throws SQLException {
			String sql = "select count(*) cnt "
					   + "from tb_reviews";
			
			int totalRecords = 0;
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			totalRecords = rs.getInt("cnt");
			rs.close();
			pstmt.close();
			connection.close();
			
			return totalRecords;
		}

		/**
		 * 테이블에 저장된 리뷰정보의 갯수를 반환한다.
		 * @return 리뷰 정보 갯수
		 * @throws SQLException
		 */
		public int selectTotalReviewCountByProductNo(int no) throws SQLException {
			String sql = "select count(*) cnt "
					+ "from tb_reviews "
					+ "where product_no = ? ";
			
			int totalRecords = 0;
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			totalRecords = rs.getInt("cnt");
			rs.close();
			pstmt.close();
			connection.close();
			
			return totalRecords;
		}
		
		/**
		 * 지정된 범위에 속하는 리뷰 정보를 반환한다.
		 * @param begin 시작 순번번호
		 * @param end 끝 순번번호
		 * @return 게시글 목록
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> getReviewList(int begin, int end) throws SQLException {
			String sql = "select review_no, product_no, member_no, member_id, member_name, review_content, "
					   + "       review_like_count, review_deleted, review_date, product_name, product_img "
					   + "from (select row_number() over (order by R.review_no desc)rn, "
					   + "				R.review_no, R.product_no, R.review_content, R.review_like_count, R.review_date, "
					   + "				R.review_delete, M.member_no, M.member_id, M.member_name, P.product_name, P.product_img "
					   + "		from tb_reviews R, tb_Members M, tb_products P "
					   + "		where R.member_no = M.member_no "
					   + "		and R.product_no = P.product_no) "
					   + "where rn >= ? and rn <= ? "
					   + "order by review_no desc ";
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, begin);
			pstmt.setInt(2, end);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDetailDto review = new ReviewDetailDto();

				review.setReviewNo(rs.getInt("review_no"));
				review.setProductNo(rs.getInt("product_no"));
				review.setMemberNo(rs.getInt("member_no"));
				review.setId(rs.getString("member_id"));
				review.setName(rs.getString("member_name"));
				review.setContent(rs.getString("review_content"));
				review.setLikeCount(rs.getInt("review_like_count"));
				review.setDeleted(rs.getString("review_deleted"));
				review.setReviewDate(rs.getDate("review_date"));
				review.setProductName(rs.getString("product_name"));
				review.setPhoto(rs.getString("product_img"));
				
				reviewList.add(review);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}
		
		/**
		 * 리뷰번호의 리뷰 정보를 반영한다.
		 * @param no 
		 * @return 리뷰 정보
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> selectReviewDetailByReviewNo(int no) throws SQLException {
			String sql = "select R.review_no, R.review_content, M.member_no, M.Member_id,  "
					   + "       R.review_like_count, R.review_deleted, P.product_no, "
					   + "		 R.review_date, P.product_name, P.product_img "
					   + "from tb_reviews R, tb_Members M, tb_products P "
					   + "where R.member_no = M.member_no "
					   + "		and R.product_no = P.product_no "
					   + "		and R.review_no = ? ";
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();
				
				
				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				reviewDetailDto.setProductNo(rs.getInt("product_no"));				
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				
				reviewList.add(reviewDetailDto);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}
		
		/**
		 * 상품번호의 리뷰 정보를 반영한다.
		 * @param no 
		 * @return 리뷰 정보
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> selectReviewDetailByProductNo(int no) throws SQLException {
			String sql = "select R.review_no, R.review_content, M.member_no, M.Member_id,  "
					+ "          R.review_like_count, R.review_deleted, P.product_no, "
					+ "		     R.review_date, P.product_name, P.product_img "
					+ "	  from tb_reviews R, tb_Members M, tb_products P "
					+ "	  where R.member_no = M.member_no "
					+ "		    and R.product_no = P.product_no "
					+ "         and R.product_no = ? ";
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				
				
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();
				
				
				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				reviewDetailDto.setProductNo(rs.getInt("product_no"));				
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				
				reviewList.add(reviewDetailDto);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}
		/**
		 * 회원번호의 리뷰 정보를 반영한다.
		 * @param no 
		 * @return 리뷰 정보
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> selectReviewDetailByMemberNo(int no) throws SQLException {
			String sql = "select R.review_no, R.review_content, M.member_no, M.Member_id, "
		               + "R.review_like_count, R.review_deleted, P.product_no, "
		               + "R.review_date, P.product_name, P.product_img "
		               + "from tb_reviews R, tb_Members M, tb_products P "
		               + "where R.member_no = M.member_no "
		               + "and R.product_no = P.product_no "
		               + "and R.member_no = ? ";
			
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				
				
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();
				
				
				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				reviewDetailDto.setProductNo(rs.getInt("product_no"));				
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				
				reviewList.add(reviewDetailDto);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}
		





}