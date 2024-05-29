package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.databaseUtil;

public class userDAO {

    // 로그인
    public int login(String userId, String userPassword) {

        String SQL = "SELECT userPassword FROM user WHERE userId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1; // 로그인 성공
                }
                else {
                    return 0; // 비밀번호가 틀림
                }
            }
            return -1; // 아이디가 존재하지 않음
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
        return -2; // 데이터베이스 오류

    }

    // 회원가입
    public int join(userDTO user) {

        String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.userId);
            pstmt.setString(2, user.userPassword);
            pstmt.setString(3, user.userName);
            pstmt.setString(4, user.userPhone);
            pstmt.setString(5, user.userEmail);
            pstmt.setInt(6, user.userAge);
            pstmt.setString(7, user.userAddress);
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
        return -1; // 회원가입 실패

    }

    // 아이디 중복 확인
    public int checkId(String userId) {

        String SQL = "SELECT COUNT(*) AS Count FROM user WHERE userId = ?;";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("Count");  // 아이디 존재
            } else {
                return 0;  // 아이디 존재하지 않음
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

    // 회원정보 수정
    public int update(userDTO user) {

        String SQL = "UPDATE user SET userPassword = ?, userName = ?, userPhone = ?, userEmail =?, userAge = ?, userAddress = ? WHERE userId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.userPassword);
            pstmt.setString(2, user.userName);
            pstmt.setString(3, user.userPhone);
            pstmt.setString(4, user.userEmail);
            pstmt.setInt(5, user.userAge);
            pstmt.setString(6, user.userAddress);
            pstmt.setString(7, user.userId);
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

    // 회원탈퇴
    public int delete(String userId) {

        String SQL = "DELETE FROM user WHERE userId= ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            int result = pstmt.executeUpdate();

            if (result == 1) {
                return 1; // 회원탈퇴 성공
            } else {
                return -1; // 회원탈퇴 실패
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
        return -2;

    }

    // 비밀번호 확인
    public boolean checkPassword(String userId, String userPassword) {

        String SQL = "SELECT userPassword FROM user WHERE userId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getString("userPassword").equals(userPassword);
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
        return false;
    
    }

    // 회원정보 가져오기
    public userDTO userInfo(String userId) {

        String SQL = "SELECT * FROM user WHERE userId = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        userDTO userDto = null;

        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                userDto = new userDTO();
                userDto.setuserId(rs.getString("userId"));
                userDto.setuserPassword(rs.getString("userPassword"));
                userDto.setuserName(rs.getString("userName"));
                userDto.setuserPhone(rs.getString("userPhone"));
                userDto.setuserEmail(rs.getString("userEmail"));
                userDto.setuserAge(rs.getInt("userAge"));
                userDto.setuserAddress(rs.getString("userAddress"));
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
        return userDto;
    }

}
