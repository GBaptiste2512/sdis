package servlet;

import database.DaoCaserne;
import database.DaoGrade;
import database.DaoPompier;
import database.DaoProfession;
import form.FormPompier;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import model.Pompier;

@WebServlet(name = "ServletPompier", urlPatterns = {"/ServletPompier/consulter", "/ServletPompier/lister", "/ServletPompier/ajouter", "/ServletPompier/modifier", "/ServletPompier/supprimer"})
public class ServletPompier extends HttpServlet {

    Connection cnx ;
            
    @Override
    public void init() {      
        ServletContext servletContext = getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");     
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String url = request.getRequestURI();  
       
        if(url.equals("/sdisweb/ServletPompier/lister")) {              
            ArrayList<Pompier> lesPompiers = DaoPompier.getLesPompiers(cnx);
            request.setAttribute("pLesPompiers", lesPompiers);
            getServletContext().getRequestDispatcher("/vues/pompier/listerPompiers.jsp").forward(request, response);
        }
        
        if(url.equals("/sdisweb/ServletPompier/consulter")) {  
            int idPompier = Integer.parseInt((String)request.getParameter("idPompier"));
            Pompier p = DaoPompier.getPompierById(cnx, idPompier);
            request.setAttribute("pPompier", p);
            getServletContext().getRequestDispatcher("/vues/pompier/consulterPompier.jsp").forward(request, response);        
        }
        
        if(url.equals("/sdisweb/ServletPompier/ajouter")) {                   
            // On envoie les 3 listes pour les menus déroulants
            request.setAttribute("pLesCasernes", DaoCaserne.getLesCasernes(cnx));
            request.setAttribute("pLesGrades", DaoGrade.getLesGrades(cnx));
            request.setAttribute("pLesProfessions", DaoProfession.getLesProfessions(cnx));
            
            this.getServletContext().getRequestDispatcher("/vues/pompier/ajouterPompier.jsp" ).forward( request, response );
        }
        
        if(url.equals("/sdisweb/ServletPompier/modifier")) {
            int idPompier = Integer.parseInt(request.getParameter("idPompier"));
            Pompier p = DaoPompier.getPompierById(cnx, idPompier);
            request.setAttribute("pPompier", p);
            getServletContext().getRequestDispatcher("/vues/pompier/modifierPompier.jsp").forward(request, response);
        }

        if(url.equals("/sdisweb/ServletPompier/supprimer")) {
            int idPompier = Integer.parseInt(request.getParameter("idPompier"));
            DaoPompier.deletePompier(cnx, idPompier);
            response.sendRedirect(request.getContextPath() + "/ServletPompier/lister");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String url = request.getRequestURI();
        
        if(url.equals("/sdisweb/ServletPompier/ajouter")) {                   
            // 1. On utilise le FormPompier pour lire les champs
            FormPompier form = new FormPompier();
            Pompier p = form.ajouterPompier(request);
            
            request.setAttribute( "form", form );
            request.setAttribute( "pPompier", p );
            
            // 2. S'il n'y a pas d'erreur, on sauvegarde en base
            if (form.getErreurs().isEmpty()){
                Pompier pompierInsere = DaoPompier.addPompier(cnx, p);
                if (pompierInsere != null ){
                    // SUCCÈS : On redirige vers la fiche du nouveau pompier
                    response.sendRedirect(request.getContextPath() + "/ServletPompier/consulter?idPompier=" + pompierInsere.getId());
                    return;
                }
            }
            
            // 3. ECHEC : On recharge les listes et on réaffiche le formulaire avec les erreurs
            request.setAttribute("pLesCasernes", DaoCaserne.getLesCasernes(cnx));
            request.setAttribute("pLesGrades", DaoGrade.getLesGrades(cnx));
            request.setAttribute("pLesProfessions", DaoProfession.getLesProfessions(cnx));
            
            this.getServletContext().getRequestDispatcher("/vues/pompier/ajouterPompier.jsp" ).forward( request, response );
        }
        
        else if(url.equals("/sdisweb/ServletPompier/modifier")) {
            Pompier p = new Pompier();
            p.setId(Integer.parseInt(request.getParameter("idPompier")));
            p.setNom(request.getParameter("nom"));
            p.setPrenom(request.getParameter("prenom"));
            p.setDateNaiss(request.getParameter("dateNaiss"));
            
            DaoPompier.updatePompier(cnx, p);
            
            response.sendRedirect(request.getContextPath() + "/ServletPompier/consulter?idPompier=" + p.getId());
        }
    }
}