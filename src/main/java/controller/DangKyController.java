package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;

@WebServlet("/dang-ky")
public class DangKyController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String hoTen = request.getParameter("hoTen");
        String sdt = request.getParameter("sdt");
        String email = request.getParameter("email");
        String diaChi = request.getParameter("diaChi");
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");

        // Kiểm tra dữ liệu nhập
        if (hoTen == null || tenDangNhap == null || matKhau == null ||
            hoTen.isEmpty() || tenDangNhap.isEmpty() || matKhau.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ thông tin bắt buộc!");
            request.getRequestDispatcher("/views/Register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                request.setAttribute("errorMessage", "Không thể kết nối cơ sở dữ liệu!");
                request.getRequestDispatcher("/views/Register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trùng tên đăng nhập hoặc email
            String checkSql = "SELECT * FROM nguoi_dung WHERE tenDangNhap = ? OR email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, tenDangNhap);
                checkStmt.setString(2, email);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("errorMessage", "Tên đăng nhập hoặc email đã tồn tại!");
                    request.getRequestDispatcher("/views/Register.jsp").forward(request, response);
                    return;
                }
            }

            // Thêm người dùng mới
            String insertSql = "INSERT INTO nguoi_dung (hoTen, sdt, email, diaChi, tenDangNhap, matKhau, vaiTro) "
                    + "VALUES (?, ?, ?, ?, ?, ?, 'user')";
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setString(1, hoTen);
                stmt.setString(2, sdt);
                stmt.setString(3, email);
                stmt.setString(4, diaChi);
                stmt.setString(5, tenDangNhap);
                stmt.setString(6, matKhau);

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    // Thành công → chuyển hướng sang trang đăng nhập, có thông báo
                    response.sendRedirect(request.getContextPath() + "/views/AdminLogin.jsp?success=1");
                } else {
                    // Thất bại → quay lại form
                    request.setAttribute("errorMessage", "Đăng ký thất bại, vui lòng thử lại!");
                    request.getRequestDispatcher("/views/Register.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/Register.jsp").forward(request, response);
        }
    }
}
