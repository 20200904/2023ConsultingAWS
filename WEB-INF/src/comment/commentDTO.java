package comment;

import java.sql.Timestamp;

public class commentDTO {

    private int commentId;
    private String userId;
    private int boardId;
    private String commentContent;
    private Timestamp commentDate;

    // commentId
    public int getcommentId() {
        return commentId;
    }
    public void setcommentId(int commentId) {
        this.commentId = commentId;
    }

    // userId
    public String getuserId() {
        return userId;
    }
    public void setuserId(String userId) {
        this.userId = userId;
    }

    // boardId
    public int getboardId() {
        return boardId;
    }
    public void setboardId(int boardId) {
        this.boardId = boardId;
    }

    // commentContent
    public String getcommentContent() {
        return commentContent;
    }
    public void setcommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    // commentDate
    public Timestamp getcommentDate() {
        return commentDate;
    }
    public void setcommentDate(Timestamp commentDate) {
        this.commentDate = commentDate;
    }

    public commentDTO() {

    }

    public commentDTO(int commentId, String userId, int boardId, String commentContent, Timestamp commentDate) {
        this.commentId = commentId;
        this.userId = userId;
        this.boardId = boardId;
        this.commentContent = commentContent;
        this.commentDate = commentDate;

    }

}
