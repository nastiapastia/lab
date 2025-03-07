package uaedunung.se.servlets;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uaedunung.se.config.FreeMarkerConfig;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {
    private Configuration cfg;

    @Override
    public void init() {
        ServletContext context = getServletContext();
        try {
            cfg = FreeMarkerConfig.getConfig(context);
        } catch (IOException e) {
            throw new RuntimeException("Помилка ініціалізації FreeMarker", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> model = new HashMap<>();
        model.put("contextPath", req.getContextPath());

        resp.setContentType("text/html; charset=UTF-8");

        // ✅ Передаємо ServletContext у FreeMarkerConfig
        Configuration cfg = FreeMarkerConfig.getConfig(getServletContext());

        try {
            // Завантажуємо шаблон
            Template template = cfg.getTemplate("hello.ftl");

            // Дані для шаблону
            model.put("message", "Привіт із FreeMarker!");

            // Рендеримо шаблон у відповідь
            try (Writer out = new OutputStreamWriter(resp.getOutputStream(), "UTF-8")) {
                template.process(model, out);
            }

        } catch (TemplateException e) {
            throw new ServletException("Помилка у FreeMarker", e);
        }
    }
}
