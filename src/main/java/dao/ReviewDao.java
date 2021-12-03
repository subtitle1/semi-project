        
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
	    	String sql = "insert into tb_reviews (review_no, member_no, review_content, product_detail_no) "
	    			   + "values (review_no_seq.nextval, ?, ?, ? ) ";
	    	
	    	Connection connection = getConnection();
	    	PreparedStatement pstmt = connection.prepareStatement(sql);
	    	pstmt.setInt(1, review.getMemberNo());
	    	pstmt.setString(2, review.getContent());
	    	pstmt.setInt(3, review.getStockNo());
	    	
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
		 * 회원번호로 지장된 리뷰정보의 갯수를 반환한다.
		 * @return 리뷰 정보 갯수
		 * @throws SQLException
		 */
		public int selectTotalReviewCountByMemberNo(int memberNo) throws SQLException {
			String sql = "select count(*) cnt "
					   + "from tb_reviews "
					   + "where member_no = ? ";
			
			int totalRecords = 0;
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, memberNo);
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
		 * 지정된 범위에 속하는 리뷰 정보를 반환한다.
		 * @param begin 시작 순번번호
		 * @param end 끝 순번번호
		 * @return 게시글 목록
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> getReviewListByMemberNo(int begin, int end, int memberNo) throws SQLException {
			String sql = "SELECT REVIEW_NO, PRODUCT_NO, PRODUCT_DETAIL_NO, PRODUCT_SIZE, PRODUCT_BRAND, "
					   + "MEMBER_NO, MEMBER_ID, MEMBER_NAME, REVIEW_CONTENT, "
					   + "       REVIEW_LIKE_COUNT, REVIEW_DELETED, REVIEW_DATE, PRODUCT_NAME, PRODUCT_IMG "
					   + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY R.REVIEW_NO DESC)RN, "
					   + "				R.REVIEW_NO, R.PRODUCT_DETAIL_NO, R.REVIEW_CONTENT, "
					   + "				R.REVIEW_LIKE_COUNT, R.REVIEW_DATE, R.REVIEW_DELETED, "
					   + "				M.MEMBER_NO, M.MEMBER_ID, M.MEMBER_NAME, "
					   + "				P.PRODUCT_NO, P.PRODUCT_NAME, P.PRODUCT_IMG, P.PRODUCT_BRAND, "
					   + "				S.PRODUCT_SIZE "
					   + "		FROM TB_REVIEWS R, TB_MEMBERS M, TB_PRODUCTS P, TB_PRODUCT_STOCKS S "
					   + "		WHERE R.MEMBER_NO = M.MEMBER_NO "
					   + "		AND R.PRODUCT_DETAIL_NO = S.PRODUCT_DETAIL_NO "
					   + "		AND S.PRODUCT_NO = P.PRODUCT_NO) "
					   + "WHERE RN >= ? AND RN <= ? "
					   + "AND MEMBER_NO = ? "
					   + "ORDER BY REVIEW_NO DESC ";
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, begin);
			pstmt.setInt(2, end);
			pstmt.setInt(3, memberNo);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();

				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				reviewDetailDto.setName(rs.getString("member_name"));
				
				reviewDetailDto.setStockNo(rs.getInt("product_detail_no"));
				reviewDetailDto.setSize(rs.getInt("product_size"));
				
				reviewDetailDto.setProductNo(rs.getInt("product_no"));
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));
				reviewDetailDto.setBrand(rs.getString("product_brand"));
				
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				
				reviewList.add(reviewDetailDto);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}

		/**
		 * 지정된 범위에 속하는 리뷰 정보를 반환한다.
		 * @param begin 시작 순번번호
		 * @param end 끝 순번번호
		 * @return 게시글 목록
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> getReviewList(int begin, int end) throws SQLException {
			String sql = "SELECT REVIEW_NO, PRODUCT_NO, PRODUCT_DETAIL_NO, PRODUCT_SIZE, PRODUCT_BRAND, "
					   + "MEMBER_NO, MEMBER_ID, MEMBER_NAME, REVIEW_CONTENT, "
					   + "       REVIEW_LIKE_COUNT, REVIEW_DELETED, REVIEW_DATE, PRODUCT_NAME, PRODUCT_IMG "
					   + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY R.REVIEW_NO DESC)RN, "
					   + "				R.REVIEW_NO, R.PRODUCT_DETAIL_NO, R.REVIEW_CONTENT, "
					   + "				R.REVIEW_LIKE_COUNT, R.REVIEW_DATE, R.REVIEW_DELETED, "
					   + "				M.MEMBER_NO, M.MEMBER_ID, M.MEMBER_NAME, "
					   + "				P.PRODUCT_NO, P.PRODUCT_NAME, P.PRODUCT_IMG, P.PRODUCT_BRAND, "
					   + "				S.PRODUCT_SIZE "
					   + "		FROM TB_REVIEWS R, TB_MEMBERS M, TB_PRODUCTS P, TB_PRODUCT_STOCKS S "
					   + "		WHERE R.MEMBER_NO = M.MEMBER_NO "
					   + "		AND R.PRODUCT_DETAIL_NO = S.PRODUCT_DETAIL_NO "
					   + "		AND S.PRODUCT_NO = P.PRODUCT_NO) "
					   + "WHERE RN >= ? AND RN <= ? "
					   + "ORDER BY REVIEW_NO DESC ";
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, begin);
			pstmt.setInt(2, end);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();

				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				reviewDetailDto.setName(rs.getString("member_name"));
				
				reviewDetailDto.setStockNo(rs.getInt("product_detail_no"));
				reviewDetailDto.setSize(rs.getInt("product_size"));
				
				reviewDetailDto.setProductNo(rs.getInt("product_no"));
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));
				reviewDetailDto.setBrand(rs.getString("product_brand"));
				
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				
				reviewList.add(reviewDetailDto);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}
		
		/**
		 * 재고(detail_no)번호와 회원번호로 리뷰를 조회한다.
		 * @param stockNo	재고번호
		 * @param memberNo  회원번호
		 * @return
		 * @throws SQLException
		 */
		public ReviewDetailDto selectReviewDetailByProductDetailNoAndMemberNo(int stockNo, int memberNo) throws SQLException {
			String sql = "SELECT R.REVIEW_NO, R.PRODUCT_DETAIL_NO, R.REVIEW_CONTENT, "
					   + "		R.REVIEW_LIKE_COUNT, R.REVIEW_DATE, R.REVIEW_DELETED, "
					   + "		M.MEMBER_NO, M.MEMBER_ID, M.MEMBER_NAME, "
					   + "		P.PRODUCT_NO, P.PRODUCT_NAME, P.PRODUCT_IMG, P.PRODUCT_BRAND, "
					   + "		S.PRODUCT_SIZE "
					   + "		FROM TB_REVIEWS R, TB_MEMBERS M, TB_PRODUCTS P, TB_PRODUCT_STOCKS S "
					   + "		WHERE R.MEMBER_NO = M.MEMBER_NO "
					   + "		AND R.PRODUCT_DETAIL_NO = S.PRODUCT_DETAIL_NO "
					   + "		AND S.PRODUCT_NO = P.PRODUCT_NO "
					   + "		AND S.PRODUCT_DETAIL_NO = ? "
					   + "		AND M.MEMBER_NO = ? ";
					    
			
			ReviewDetailDto reviewDetailDto = null;
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, stockNo);
			pstmt.setInt(2, memberNo);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				reviewDetailDto = new ReviewDetailDto();
				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				reviewDetailDto.setName(rs.getString("member_name"));
				
				reviewDetailDto.setStockNo(rs.getInt("product_detail_no"));
				reviewDetailDto.setSize(rs.getInt("product_size"));
				
				reviewDetailDto.setProductNo(rs.getInt("product_no"));
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));
				reviewDetailDto.setBrand(rs.getString("product_brand"));
				
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewDetailDto;
		}
		
		/**
		 * 상품번호의 리뷰 정보를 반영한다.
		 * @param no 
		 * @return 리뷰 정보
		 * @throws SQLException
		 */
		public List<ReviewDetailDto> selectReviewDetailByProductNo(int no) throws SQLException {
			String sql = "SELECT R.REVIEW_NO, R.PRODUCT_DETAIL_NO, R.REVIEW_CONTENT, "
					   + "		R.REVIEW_LIKE_COUNT, R.REVIEW_DATE, R.REVIEW_DELETED, "
					   + "		M.MEMBER_NO, M.MEMBER_ID, M.MEMBER_NAME, "
					   + "		P.PRODUCT_NO, P.PRODUCT_NAME, P.PRODUCT_IMG, P.PRODUCT_BRAND, "
					   + "		S.PRODUCT_SIZE "
					   + "		FROM TB_REVIEWS R, TB_MEMBERS M, TB_PRODUCTS P, TB_PRODUCT_STOCKS S "
					   + "		WHERE R.MEMBER_NO = M.MEMBER_NO "
					   + "		AND R.PRODUCT_DETAIL_NO = S.PRODUCT_DETAIL_NO "
					   + "		AND S.PRODUCT_NO = P.PRODUCT_NO "
					   + "		AND S.PRODUCT_NO = ? ";
					  
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();

				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				reviewDetailDto.setName(rs.getString("member_name"));
				
				reviewDetailDto.setStockNo(rs.getInt("product_detail_no"));
				reviewDetailDto.setSize(rs.getInt("product_size"));
				
				reviewDetailDto.setProductNo(rs.getInt("product_no"));
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));
				reviewDetailDto.setBrand(rs.getString("product_brand"));
				
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				
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
			String sql = "SELECT R.REVIEW_NO, R.PRODUCT_DETAIL_NO, R.REVIEW_CONTENT, "
					   + "		R.REVIEW_LIKE_COUNT, R.REVIEW_DATE, R.REVIEW_DELETED, "
					   + "		M.MEMBER_NO, M.MEMBER_ID, M.MEMBER_NAME, "
					   + "		P.PRODUCT_NO, P.PRODUCT_NAME, P.PRODUCT_IMG, P.PRODUCT_BRAND, "
					   + "		S.PRODUCT_SIZE "
					   + "		FROM TB_REVIEWS R, TB_MEMBERS M, TB_PRODUCTS P, TB_PRODUCT_STOCKS S "
					   + "		WHERE R.MEMBER_NO = M.MEMBER_NO "
					   + "		AND R.PRODUCT_DETAIL_NO = S.PRODUCT_DETAIL_NO "
					   + "		AND S.PRODUCT_NO = P.PRODUCT_NO "
					   + "		AND M.MEMBER_NO = ? ";
			
			
			List<ReviewDetailDto> reviewList = new ArrayList<>();
			
			Connection connection = getConnection();
			PreparedStatement pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ReviewDetailDto reviewDetailDto = new ReviewDetailDto();

				reviewDetailDto.setReviewNo(rs.getInt("review_no"));
				
				reviewDetailDto.setMemberNo(rs.getInt("member_no"));
				reviewDetailDto.setId(rs.getString("member_id"));
				reviewDetailDto.setName(rs.getString("member_name"));
				
				reviewDetailDto.setStockNo(rs.getInt("product_detail_no"));
				reviewDetailDto.setSize(rs.getInt("product_size"));
				
				reviewDetailDto.setProductNo(rs.getInt("product_no"));
				reviewDetailDto.setProductName(rs.getString("product_name"));
				reviewDetailDto.setPhoto(rs.getString("product_img"));
				reviewDetailDto.setBrand(rs.getString("product_brand"));
				
				reviewDetailDto.setContent(rs.getString("review_content"));
				reviewDetailDto.setLikeCount(rs.getInt("review_like_count"));
				reviewDetailDto.setDeleted(rs.getString("review_deleted"));
				reviewDetailDto.setReviewDate(rs.getDate("review_date"));
				
				reviewList.add(reviewDetailDto);
			}
			rs.close();
			pstmt.close();
			connection.close();
			
			return reviewList;
		}
		



}

    