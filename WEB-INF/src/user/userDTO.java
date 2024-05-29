package user;

public class userDTO {

    String userId;
    String userPassword;
    String userName;
    String userPhone;
    String userEmail;
    int userAge;
    String userAddress;

    // userID
    public String getuserId() {
        return userId;
    }
    public void setuserId(String userId) {
        this.userId = userId;
    }

    // userPassword
    public String getuserPassword() {
        return userPassword;
    }
    public void setuserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    // userName
    public String getuserName() {
        return userName;
    }
    public void setuserName(String userName) {
        this.userName = userName;
    }

    // userPhone
    public String getuserPhone() {
        return userPhone;
    }
    public void setuserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    // userEmail
    public String getuserEmail() {
        return userEmail;
    }
    public void setuserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    // userAge
    public int getuserAge() {
        return userAge;
    }
    public void setuserAge(int userAge) {
        this.userAge = userAge;
    }

    // userAddress
    public String getuserAddress() {
        return userAddress;
    }
    public void setuserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public userDTO() {

    }

    public userDTO(String userId, String userPassword, String userName, String userPhone, String userEmail, int userAge, String userAddress) {
        this.userId = userId;
        this.userPassword = userPassword;
        this.userName = userName;
        this.userPhone = userPhone;
        this.userEmail = userEmail;
        this.userAge = userAge;
        this.userAddress = userAddress;
    }

}
