package servlet;

import database.DaoCaserne;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import model.Caserne;

@WebServlet(name = "ServletCaserne", urlPatterns = {"/ServletCaserne/consulter", "/ServletCaserne/lister" ,"/ServletCaserne/modifier"})
public class ServletCaserne extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {     
        ServletContext servletContext = getServletContext();
        cnx = (Connection) servletContext.getAttribute("connection");     
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Servlet ServletCaserne</title></head>");
            out.println("<body><h1>Servlet ServletCaserne at " + request.getContextPath() + "</h1></body></html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String url = request.getRequestURI();
        
        if(url.equals("/sdisweb/ServletCaserne/lister")) {
            ArrayList<Caserne> lesCasernes = DaoCaserne.getLesCasernes(cnx);
            request.setAttribute("pLesCasernes", lesCasernes);
            getServletContext().getRequestDispatcher("/vues/caserne/listerCasernes.jsp").forward(request, response);
        }
        
        if(url.equals("/sdisweb/ServletCaserne/consulter")) {  
            int idCaserne = Integer.parseInt(request.getParameter("idCaserne"));
            Caserne c = DaoCaserne.getCaserneById(cnx, idCaserne);
            request.setAttribute("pCaserne", c);
            getServletContext().getRequestDispatcher("/vues/caserne/consulterCaserne.jsp").forward(request, response);   
        }
        
        if(url.equals("/sdisweb/ServletCaserne/modifier")) {
            int idCaserne = Integer.parseInt(request.getParameter("idCaserne"));
            Caserne c = DaoCaserne.getCaserneById(cnx, idCaserne);
            request.setAttribute("pCaserne", c);
            getServletContext().getRequestDispatcher("/vues/caserne/modifierCaserne.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getRequestURI();
        if(url.equals("/sdisweb/ServletCaserne/modifier")) {
            Caserne c = new Caserne();
            c.setId(Integer.parseInt(request.getParameter("idCaserne")));
            c.setNom(request.getParameter("nom"));
            c.setRue(request.getParameter("rue"));
            c.setCopos(request.getParameter("copos"));
            c.setVille(request.getParameter("ville"));
            
            DaoCaserne.updateCaserne(cnx, c);
            
            // Redirection vers la page de consultation de la caserne modifiée
            response.sendRedirect(request.getContextPath() + "/ServletCaserne/consulter?idCaserne=" + c.getId());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}