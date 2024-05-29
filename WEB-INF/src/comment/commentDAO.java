package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.databaseUtil;

public class commentDAO {

    // 댓글 추가
    public int write(int boardId, String userId, String commentContent) {

        String SQL = "INSERT INTO comment VALUES (null, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardId);
            pstmt.setString(2, userId);
     	    pstmt.setString(3, commentContent);
            return pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    // 댓글 삭제
    public int delete(String userId, int commentId) {

        String SQL = "DELETE FROM comment WHERE userId = ? AND commentId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
	    pstmt.setInt(2, commentId);
            return pstmt.executeUpdate();			
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;  //데이터베이스 오류

    }


    // 댓글 불러오기
    public List<commentDTO> commentList(int boardId) {

        List<commentDTO> commentList = new ArrayList<>();
        String SQL = "SELECT * FROM comment WHERE boardId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                commentDTO commentDto = new commentDTO();
                commentDto.setcommentId(rs.getInt("commentId"));
                commentDto.setboardId(rs.getInt("boardId"));
                commentDto.setuserId(rs.getString("userId"));
                commentDto.setcommentContent(rs.getString("commentContent"));
                commentDto.setcommentDate(rs.getTimestamp("commentDate"));
		commentList.add(commentDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return commentList;
    }

    // 댓글 카운트
    public int commentCount(int boardId) {

        String SQL = "SELECT COUNT(*) AS Count FROM comment WHERE boardId = ?;";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("Count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

}
