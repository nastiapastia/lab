<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Скидання пароля | FruitShop</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="${contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${contextPath}/assets/css/style.css" rel="stylesheet">

    <script src="${contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<#include "navbar.ftl">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title text-center mb-4">Скидання пароля</h3>


                    <form method="post" action="${contextPath}/forgot-password">
                        <div class="mb-3">
                            <label for="email" class="form-label">Електронна пошта</label>
                            <input type="email" name="email" id="email" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Новий пароль</label>
                            <input type="password" name="newPassword" id="newPassword" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Повторіть пароль</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Скинути пароль</button>
                        </div>

                        <#if error??>
                            <div class="alert alert-danger mt-3">${error}</div>
                        </#if>

                        <#if message??>
                            <div class="alert alert-success mt-3">${message}</div>
                        </#if>

                        <div class="mt-3 text-center">
                            <a href="${contextPath}/home">Повернутись до входу</a>
                        </div>
                    </form>


                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
