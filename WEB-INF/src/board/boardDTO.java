package board;

import java.sql.Timestamp;

public class boardDTO {

    int boardId;
    String userId;
    String boardTitle;
    String boardContent;
    String fileName;
    String fileRealName;
    Timestamp boardDate;

    // boardId
    public int getboardId() {
        return boardId;
    }
    public void setboardId(int boardId) {
        this.boardId = boardId;
    }

    // userId
    public String getuserId() {
        return userId;
    }
    public void setuserId(String userId) {
        this.userId = userId;
    }

    // boardTitle
    public String getboardTitle() {
        return boardTitle;
    }
    public void setboardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    // boardContent
    public String getboardContent() {
        return boardContent;
    }
    public void setboardContent(String boardContent) {
        this.boardContent = boardContent;
    }

    // fileName
    public String getfileName() {
        return fileName;
    }
    public void setfileName(String fileName) {
        this.fileName = fileName;
    }

    // fileRealName
    public String getfileRealName() {
        return fileRealName;
    }
    public void setfileRealName(String fileRealName) {
        this.fileRealName = fileRealName;
    }

    // boardDate
    public Timestamp getboardDate() {
        return boardDate;
    }
    public void setboardDate(Timestamp boardDate) {
        this.boardDate = boardDate;
    }

    public boardDTO() {

    }

    public boardDTO(int boardId, String userId, String boardTitle, String boardContent, String fileName, String fileRealName, Timestamp boardDate) {
        this.boardId = boardId;
        this.userId = userId;
        this.boardTitle = boardTitle;
        this.boardContent = boardContent;
	this.fileName = fileName;
        this.fileRealName = fileRealName;
        this.boardDate = boardDate;
    }

}
