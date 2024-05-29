package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

import util.databaseUtil;

public class boardDAO {

    // 게시글 추가
    public int write(String userId, String boardTitle, String boardContent, String fileName, String fileRealName) {

        String SQL = "INSERT INTO board VALUES (null, ?, ?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            pstmt.setString(2, boardTitle);
            pstmt.setString(3, boardContent);
            pstmt.setString(4, fileName);
            pstmt.setString(5, fileRealName);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); 
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return -1;

    }

    // 게시글 수정
    public int update(int boardId, String userId, String boardTitle, String boardContent, String fileName, String fileRealName) {

        String SQL = "UPDATE board SET boardTitle = ?, boardContent = ?, fileName = ?, fileRealName = ? WHERE userId = ? AND boardId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, boardTitle);
            pstmt.setString(2, boardContent);
            pstmt.setString(3, fileName);
            pstmt.setString(4, fileRealName);
            pstmt.setString(5, userId);
            pstmt.setInt(6, boardId);
            return pstmt.executeUpdate();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;

    }

    // 게시글 삭제
    public int delete(String userId, int boardId) {

        String SQL = "DELETE FROM board WHERE userId = ? AND boardId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            pstmt.setInt(2, boardId);
            return pstmt.executeUpdate(); // 성공적이면 1을 반환
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;

    }

    // 최신 게시글 (메인 페이지)
    public List<boardDTO> getRecentPosts(int numberOfPosts) {

        List<boardDTO> recentPosts = new ArrayList<>();
        String SQL = "SELECT boardId, userId, boardTitle, boardDate FROM board ORDER BY boardDate DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, numberOfPosts);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                boardDTO post = new boardDTO();
                post.setboardId(rs.getInt("boardId"));
                post.setuserId(rs.getString("userId"));
                post.setboardTitle(rs.getString("boardTitle"));
                post.setboardDate(rs.getTimestamp("boardDate"));
                recentPosts.add(post);
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
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return recentPosts;

    }

    // 로그인 사용자 게시글 출력 (마이 페이지)
    public List<boardDTO> myView(String userId) {

        List<boardDTO> boardList = new ArrayList<>();
        String SQL = "SELECT * FROM board WHERE userId = ? ORDER BY boardId DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
        
            while (rs.next()) {
                boardDTO boardDto = new boardDTO();
                boardDto.setboardId(rs.getInt("boardId"));
                boardDto.setuserId(rs.getString("userId"));
                boardDto.setboardTitle(rs.getString("boardTitle"));
                boardDto.setboardContent(rs.getString("boardContent"));
                boardDto.setboardDate(rs.getTimestamp("boardDate"));
                boardList.add(boardDto);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return boardList;

    }

    // 세부 게시글 출력
    public boardDTO detailView(int boardId) {

        String SQL = "SELECT * FROM board WHERE boardId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boardDTO boardDto = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                boardDto = new boardDTO();
                boardDto.setboardId(rs.getInt("boardId"));
                boardDto.setuserId(rs.getString("userId"));
                boardDto.setboardTitle(rs.getString("boardTitle"));
                boardDto.setboardContent(rs.getString("boardContent"));
                boardDto.setfileName(rs.getString("fileName"));
                boardDto.setfileRealName(rs.getString("fileRealName"));
                boardDto.setboardDate(rs.getTimestamp("boardDate"));
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return boardDto;

    }

    // 파일 불러오기
    public boardDTO getFile(int boardId) {

        String SQL = "SELECT * FROM board WHERE boardId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boardDTO boardDto = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                boardDto = new boardDTO();
                boardDto.setboardId(rs.getInt("boardId"));
                boardDto.setuserId(rs.getString("userId"));
                boardDto.setfileName(rs.getString("fileName"));
                boardDto.setfileRealName(rs.getString("fileRealName"));
                boardDto.setboardDate(rs.getTimestamp("boardDate"));
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return boardDto;

    }

    // 게시글 검색
    public List<boardDTO> search(String search) {

        List<boardDTO> searchList = new ArrayList<>();
        String SQL = "SELECT * FROM board WHERE REGEXP_REPLACE(CONCAT(boardTitle, boardContent), '<p>(.*?)</p>', '') LIKE ? ORDER BY boardId DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" +search+ "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                boardDTO boardDto = new boardDTO();
                boardDto.setboardId(rs.getInt("boardId"));
                boardDto.setuserId(rs.getString("userId"));
                boardDto.setboardTitle(rs.getString("boardTitle"));
                boardDto.setboardContent(rs.getString("boardContent"));
                boardDto.setboardDate(rs.getTimestamp("boardDate"));
                searchList.add(boardDto);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return searchList;

    }

    // 검색된 게시글 카운트
    public int count(String search) {

        String SQL = "SELECT COUNT(*) AS Count FROM board WHERE REGEXP_REPLACE(CONCAT(boardTitle, boardContent), '<p>(.*?)</p>', '') LIKE ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" +search+ "%");
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
