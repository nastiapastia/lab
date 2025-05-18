package uaedunung.se.servlets;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import uaedunung.se.config.FreeMarkerConfig;
import uaedunung.se.config.HibernateUtil;
import uaedunung.se.entity.User;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;


@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Configuration config = FreeMarkerConfig.getConfig(getServletContext());
        Template template = config.getTemplate("/forgot_password.ftl");

        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        Map<String, Object> model = new HashMap<>();
        model.put("contextPath", req.getContextPath());
        if (req.getAttribute("error") != null) {
            model.put("error", req.getAttribute("error"));
        }
        if (req.getAttribute("message") != null) {
            model.put("message", req.getAttribute("message"));
        }

        try (Writer out = new OutputStreamWriter(resp.getOutputStream(), StandardCharsets.UTF_8)) {
            template.process(model, out);
        } catch (TemplateException e) {
            throw new ServletException("FreeMarker error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Паролі не співпадають");
            doGet(req, resp);
            return;
        }

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();

            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            User user = query.uniqueResult();

            if (user != null) {
                user.setPassword(newPassword);
                session.merge(user);
                tx.commit();
                req.setAttribute("message", "Пароль успішно змінено");
            } else {
                req.setAttribute("error", "Користувача з такою електронною поштою не знайдено");
            }

            doGet(req, resp);
        }
    }

}
