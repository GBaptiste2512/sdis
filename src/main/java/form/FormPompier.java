package form;

import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import model.Caserne;
import model.Grade;
import model.Pompier;
import model.Profession;

public class FormPompier {
    
    private String resultat;
    private Map<String, String> erreurs = new HashMap<String, String>();

    public String getResultat() { return resultat; }
    public void setResultat(String resultat) { this.resultat = resultat; }
    public Map<String, String> getErreurs() { return erreurs; }
    public void setErreurs(Map<String, String> erreurs) { this.erreurs = erreurs; }
    
    private void validationNom( String nom ) throws Exception {
        if ( nom != null && nom.length() < 3 ) {
            throw new Exception( "Le nom d'utilisateur doit contenir au moins 3 caractères." );
        }
    }

    private void setErreur( String champ, String message ) {
        erreurs.put(champ, message );
    }   
    
    private static String getDataForm( HttpServletRequest request, String nomChamp ) {
        String valeur = request.getParameter( nomChamp );
        if ( valeur == null || valeur.trim().length() == 0 ) {
            return null;
        } else {
            return valeur.trim();
        }   
    }
    
    public Pompier ajouterPompier( HttpServletRequest request ) {
        Pompier p = new Pompier();
         
        String nom = getDataForm( request, "nom" );
        String prenom = getDataForm( request, "prenom");
        String dateNaiss = getDataForm( request, "dateNaiss");
        String idCaserne = getDataForm( request, "idCaserne" );
        String idGrade = getDataForm( request, "idGrade" );
        String idProfession = getDataForm( request, "idProfession" );
       
        try {
             validationNom( nom );
        } catch ( Exception e ) {
            setErreur( "nom", e.getMessage() );
        }
        
        p.setNom(nom);
        p.setPrenom(prenom);
        p.setDateNaiss(dateNaiss);

        // On associe la Caserne
        if (idCaserne != null) {
            Caserne c = new Caserne();
            c.setId(Integer.parseInt(idCaserne));
            p.setUneCaserne(c);
        }
        
        // On associe le Grade
        if (idGrade != null) {
            Grade g = new Grade();
            g.setId(Integer.parseInt(idGrade));
            p.setGrade(g);
        }
        
        // On associe la Profession
        if (idProfession != null) {
            Profession pr = new Profession();
            pr.setId(Integer.parseInt(idProfession));
            p.setProfession(pr);
        }

        if ( erreurs.isEmpty() ) {
            resultat = "Succès de l'ajout.";
        } else {
            resultat = "Échec de l'ajout.";
        }
        
        return p ;
    }
}