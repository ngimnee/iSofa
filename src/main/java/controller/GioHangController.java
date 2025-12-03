package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.GioHang;
import model.GioHangItem;

@WebServlet("/giohang")
public class GioHangController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Lấy giỏ hàng từ session
        GioHang gioHang = (GioHang) session.getAttribute("gioHang");
        if (gioHang == null) {
            gioHang = new GioHang(); // Nếu giỏ hàng không tồn tại, tạo mới
            session.setAttribute("gioHang", gioHang);
        }

        // Gửi giỏ hàng lên JSP
        request.setAttribute("gioHang", gioHang);
        request.getRequestDispatcher("views/GioHang.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        GioHang gioHang = (GioHang) session.getAttribute("gioHang");
        if (gioHang == null && action != null) {
            gioHang = new GioHang();
            session.setAttribute("gioHang", gioHang);
        }

        if ("them".equals(action)) {
            int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
            String tenSanPham = request.getParameter("tenSanPham");
            double gia = Double.parseDouble(request.getParameter("gia"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            GioHangItem item = new GioHangItem(maSanPham, tenSanPham, gia, soLuong);
            gioHang.themSanPham(item);

        } else if ("xoa".equals(action)) {
            int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
            gioHang.xoaSanPham(maSanPham);

        } else if ("capNhat".equals(action)) {
            int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
            int soLuongMoi = Integer.parseInt(request.getParameter("soLuongMoi"));
            gioHang.capNhatSoLuong(maSanPham, soLuongMoi);

        } else if ("ThanhToan".equals(action)) {

            // Kiểm tra đăng nhập
            if (session == null || session.getAttribute("user") == null) {
                session = request.getSession(true);
                session.setAttribute("redirectAfterLogin", request.getRequestURL().toString());
                response.sendRedirect(request.getContextPath() + "/views/AdminLogin.jsp?requireLogin=1");
                return;
            }

            // Kiểm tra giỏ hàng
            if (gioHang != null && !gioHang.getDanhSach().isEmpty()) {
                double tongTien = gioHang.getTongTien();
                request.setAttribute("gioHang", gioHang);
                request.setAttribute("tongTien", tongTien);
                request.getRequestDispatcher("views/ThanhToanGioHang.jsp").forward(request, response);
            } else {
                response.sendRedirect("giohang");
            }
            return;
        }

        // Cập nhật giỏ hàng sau thao tác thêm/xóa/sửa
        if (gioHang != null) {
            session.setAttribute("gioHang", gioHang);
        }

        // Quay lại trang giỏ hàng
        response.sendRedirect("giohang");
    }
}
