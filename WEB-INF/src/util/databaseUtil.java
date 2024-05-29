package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class databaseUtil {

    public static Connection getConnection() {
        try {
            String dbURL = "jdbc:mysql://management.cwiwwqenjioi.ap-northeast-2.rds.amazonaws.com:3306/management";
            String dbID = "admin";
            String dbPW = "boardproject";
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(dbURL, dbID, dbPW);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
