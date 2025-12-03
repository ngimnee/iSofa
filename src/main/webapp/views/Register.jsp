<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Đăng Ký</title>

<!-- Tailwind CSS CDN -->
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
	background-image:
		url('${pageContext.request.contextPath}/images/banan1.png');
	background-size: cover; 
	background-position: center; 
	background-repeat: no-repeat; 
	background-attachment: fixed; 
	font-family: 'Inter', sans-serif;
	color: #1f2937;
	margin: 0;
	min-height: 100vh; 
	overflow-y: auto; 
}

.container-overlay {
	position: relative;
	width: 100%;
	min-height: 100vh;
	background-color: rgba(0, 0, 0, 0.3);
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;
	padding: 3rem 1rem;
	overflow-y: auto;
	box-sizing: border-box;
	border-radius: 20px;
	overflow: hidden;
}

.card {
	background-color: var(--card-bg);
	padding: 2rem 3rem;
	max-width: 40rem;
	width: 100%;
	transition: transform 0.2s ease, box-shadow 0.2s ease;
	margin-bottom: 3rem;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}
</style>
</head>

<body>
	<div class="container-overlay">
		<img src="${pageContext.request.contextPath}/images/logo.png"
			alt="Logo iSofa" class="h-20 mb-4">
		<div class="card rounded-lg shadow-lg p-6 max-w-lg mx-auto -mt-20">
			<div class="text-center mb-6">
				<h3 class="text-2xl font-bold text-gray-800">Đăng ký</h3>
				<p class="text-gray-600">
					Hệ thống <span class="text-orange-500 font-semibold">iSofa</span>
				</p>
			</div>

			<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
			<% String successMessage = (String) request.getAttribute("successMessage"); %>
			<% if (errorMessage != null) { %>
			<div
				class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 mb-3 rounded">
				<i class="fa-solid fa-triangle-exclamation mr-2"></i><%= errorMessage %>
			</div>
			<% } %>
			<% if (successMessage != null) { %>
			<div
				class="bg-green-100 border border-green-400 text-green-700 px-4 py-2 mb-3 rounded">
				<i class="fa-solid fa-circle-check mr-2"></i><%= successMessage %>
			</div>
			<% } %>

			<form action="${pageContext.request.contextPath}/dang-ky"
				method="post" onsubmit="return validatePasswords()">
				<!-- Họ tên -->
				<div class="mb-4">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-user mr-2"></i>Họ tên <span class="text-red-500">*</span>
					</label> <input type="text" name="hoTen" required
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
				</div>

				<!-- Số điện thoại -->
				<div class="mb-4">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-phone mr-2"></i>Số điện thoại
					</label> <input type="text" name="sdt"
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
				</div>

				<!-- Tên đăng nhập -->
				<div class="mb-4">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-user-circle mr-2"></i>Tên đăng nhập <span
						class="text-red-500">*</span>
					</label> <input type="text" name="tenDangNhap" required
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
				</div>

				<!-- Mật khẩu -->
				<div class="mb-4 relative">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-lock mr-2"></i>Mật khẩu <span
						class="text-red-500">*</span>
					</label> <input type="password" name="matKhau" id="password" required
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
					<button type="button" onclick="togglePassword('password', this)"
						class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-600 hover:text-gray-800">
						<i class="fas fa-eye"></i>
					</button>
				</div>

				<!-- Xác nhận mật khẩu -->
				<div class="mb-6 relative">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-lock mr-2"></i>Xác nhận mật khẩu <span
						class="text-red-500">*</span>
					</label> <input type="password" id="confirmPassword" required
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
					<button type="button"
						onclick="togglePassword('confirmPassword', this)"
						class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-600 hover:text-gray-800">
						<i class="fas fa-eye"></i>
					</button>
				</div>

				<!-- Email -->
				<div class="mb-4">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-envelope mr-2"></i>Email
					</label> <input type="email" name="email"
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
				</div>

				<!-- Địa chỉ -->
				<div class="mb-4">
					<label class="block text-sm font-medium text-gray-700 mb-1">
						<i class="fas fa-location-dot mr-2"></i>Địa chỉ
					</label> <input type="text" name="diaChi"
						class="form-control w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none">
				</div>

				<!-- Submit -->
				<button type="submit"
					class="w-full py-2 bg-orange-500 hover:bg-orange-600 text-white font-semibold rounded-md transition">
					Đăng ký</button>

				<p class="text-center text-sm text-gray-600 mt-4">
					Đã có tài khoản? <a
						href="${pageContext.request.contextPath}/views/AdminLogin.jsp"
						class="text-orange-500 font-medium hover:underline"> Đăng nhập
					</a>
				</p>
			</form>
		</div>
	</div>

	<script>
	function togglePassword(id, btn) {
		const input = document.getElementById(id);
		const icon = btn.querySelector('i');
		if (input.type === 'password') {
			input.type = 'text';
			icon.classList.replace('fa-eye', 'fa-eye-slash');
		} else {
			input.type = 'password';
			icon.classList.replace('fa-eye-slash', 'fa-eye');
		}
	}

	function validatePasswords() {
		const pw = document.getElementById('password').value;
		const confirm = document.getElementById('confirmPassword').value;
		if (pw !== confirm) {
			alert('Mật khẩu và xác nhận mật khẩu không khớp!');
			return false;
		}
		return true;
	}
	</script>
</body>
</html>
