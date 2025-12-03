package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;
import model.NguoiDung;

@WebServlet("/login-admin")
public class AdminLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM nguoi_dung WHERE tenDangNhap = ? AND matKhau = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Đăng nhập thành công
                    NguoiDung nguoiDung = new NguoiDung();
                    nguoiDung.setMaNguoiDung(rs.getInt("maNguoiDung"));
                    nguoiDung.setHoTen(rs.getString("hoTen"));
                    nguoiDung.setTenDangNhap(rs.getString("tenDangNhap"));
                    nguoiDung.setVaiTro(rs.getString("vaiTro"));

                    // Lưu vào session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", nguoiDung);

                    // Nếu trước đó bị chuyển hướng vì chưa login, quay lại trang đặt hàng
                    String redirectURL = (String) session.getAttribute("redirectAfterLogin");
                    if (redirectURL != null) {
                        session.removeAttribute("redirectAfterLogin");
                        response.sendRedirect(redirectURL);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                    }
                } else {
                    // Sai tài khoản hoặc mật khẩu
                    request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
                    request.getRequestDispatcher("/views/AdminLogin.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/AdminLogin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/AdminLogin.jsp");
    }
}
