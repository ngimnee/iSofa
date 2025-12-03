<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Đăng nhập - iSofa</title>

<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
:root {
	--primary-color: #f97316;
	--card-bg: rgba(255, 255, 255, 0.9);
}

body {
	background-image: url('${pageContext.request.contextPath}/images/banan1.png');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: 'Inter', sans-serif;
}

.container-overlay {
	background-color: rgba(0, 0, 0, 0.35);
	padding: 2rem;
	border-radius: 1.5rem;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.card {
	background-color: var(--card-bg);
	padding: 2rem 3rem;
	max-width: 420px;
	width: 100%;
	border-radius: 0.75rem;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.card:hover {
	transform: translateY(-3px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
}

.btn-primary {
	background-color: var(--primary-color);
	color: white;
	font-weight: 600;
	padding: 0.6rem 1rem;
	border-radius: 0.5rem;
	width: 100%;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #ea580c;
}

.form-control {
	width: 100%;
	padding: 0.5rem 0.75rem;
	border: 1px solid #d1d5db;
	border-radius: 0.375rem;
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.form-control:focus {
	border-color: var(--primary-color);
	box-shadow: 0 0 0 0.2rem rgba(249, 115, 22, 0.25);
}
</style>
</head>
<body>
	<div class="container-overlay flex flex-col items-center">
		<img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo iSofa" class="h-20 mb-4">
		
		<div class="card shadow-lg">
			<div class="text-center mb-6">
				<h3 class="text-2xl font-bold text-gray-800">Đăng nhập</h3>
				<p class="text-gray-600">Hệ thống nội thất 
					<span class="text-orange-500 font-semibold">iSofa</span>
				</p>
			</div>

			<!-- ✅ Thông báo đăng ký thành công -->
			<% if ("1".equals(request.getParameter("success"))) { %>
				<div class="bg-green-100 border border-green-400 text-green-700 px-4 py-2 mb-4 rounded">
					<i class="fa-solid fa-circle-check mr-2"></i>
					Đăng ký tài khoản thành công! Vui lòng đăng nhập.
				</div>
			<% } %>

			<!-- ⚠️ Thông báo yêu cầu đăng nhập -->
			<% if ("1".equals(request.getParameter("requireLogin"))) { %>
				<div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-2 mb-4 rounded">
					<i class="fa-solid fa-circle-exclamation mr-2"></i>
					Bạn cần đăng nhập để tiếp tục mua hàng.
				</div>
			<% } %>

			<!-- ❌ Thông báo lỗi đăng nhập -->
			<% if (request.getAttribute("errorMessage") != null) { %>
				<div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 mb-4 rounded">
					<i class="fa-solid fa-triangle-exclamation mr-2"></i>
					<%= request.getAttribute("errorMessage") %>
				</div>
			<% } %>

			<form action="${pageContext.request.contextPath}/login-admin" method="post">
				<div class="mb-4">
					<label for="username" class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-user mr-2"></i>Tên đăng nhập
					</label>
					<input type="text" class="form-control" id="username" name="username" required>
				</div>

				<div class="mb-6 relative">
					<label for="password" class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-lock mr-2"></i>Mật khẩu
					</label>
					<input type="password" class="form-control" id="password" name="password" required>
					<button type="button" onclick="togglePassword()" 
						class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-600 hover:text-gray-800">
						<i class="fas fa-eye"></i>
					</button>
				</div>

				<button type="submit" class="btn-primary">Đăng nhập</button>

				<p class="text-center text-sm text-gray-600 mt-4">
					Chưa có tài khoản? 
					<a href="${pageContext.request.contextPath}/dang-ky" 
						class="text-orange-500 font-medium hover:underline">Đăng ký</a>
				</p>
			</form>
		</div>
	</div>

	<script>
	function togglePassword() {
		const passwordField = document.getElementById('password');
		const icon = document.querySelector('.fa-eye, .fa-eye-slash');
		if (passwordField.type === 'password') {
			passwordField.type = 'text';
			icon.classList.replace('fa-eye', 'fa-eye-slash');
		} else {
			passwordField.type = 'password';
			icon.classList.replace('fa-eye-slash', 'fa-eye');
		}
	}
	</script>
</body>
</html>
