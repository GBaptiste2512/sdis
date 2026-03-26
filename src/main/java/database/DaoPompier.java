package database;

import java.sql.*;
import java.util.ArrayList;
import model.Caserne;
import model.CategorieGrade;
import model.Grade;
import model.Pompier;
import model.Profession;

public class DaoPompier {
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Pompier> getLesPompiers(Connection cnx){
        ArrayList<Pompier> lesPompiers = new ArrayList<Pompier>();
        try{
            requeteSql = cnx.prepareStatement("SELECT p.MATRICULE as p_id, p.NOM as p_nom, p.PRENOM as p_prenom, c.ID_CASERNE as c_id, c.NOM as c_nom " +
                                 " FROM POMPIER p LEFT JOIN CASERNE c ON p.ID_CASERNE = c.ID_CASERNE");
            resultatRequete = requeteSql.executeQuery();
            while (resultatRequete.next()){
                Pompier p = new Pompier();
                p.setId(resultatRequete.getInt("p_id"));
                p.setNom(resultatRequete.getString("p_nom"));
                p.setPrenom(resultatRequete.getString("p_prenom"));
                Caserne c = new Caserne();
                c.setId(resultatRequete.getInt("c_id"));
                c.setNom(resultatRequete.getString("c_nom"));
                p.setUneCaserne(c);
                lesPompiers.add(p);
            }
        } catch (SQLException e){ e.printStackTrace(); }
        return lesPompiers;
    }

    public static Pompier getPompierById(Connection cnx, int idPompier){
        Pompier p = null;
        try{
            requeteSql = cnx.prepareStatement(
                "SELECT p.MATRICULE as p_id, p.NOM as p_nom, p.PRENOM as p_prenom, p.DATENAISS as p_datenaiss, " +
                "c.ID_CASERNE as c_id, c.NOM as c_nom, " +
                "g.ID_GRADE as g_id, g.LIBELLE as g_libelle, " +
                "cg.ID_CATEGORIEGRADE as cg_id, cg.LIBELLE as cg_libelle, " + // NOUVEAU
                "pr.ID_PROFESSION as pr_id, pr.LIBELLE as pr_libelle " +
                "FROM POMPIER p " +
                "LEFT JOIN CASERNE c ON p.ID_CASERNE = c.ID_CASERNE " +
                "LEFT JOIN GRADE g ON p.ID_GRADE = g.ID_GRADE " +
                "LEFT JOIN CATEGORIEGRADE cg ON g.ID_CATEGORIEGRADE = cg.ID_CATEGORIEGRADE " + // NOUVEAU
                "LEFT JOIN PROFESSION pr ON p.ID_PROFESSION = pr.ID_PROFESSION " +
                "WHERE p.MATRICULE = ?"
            );
            requeteSql.setInt(1, idPompier);
            resultatRequete = requeteSql.executeQuery();
            
            if (resultatRequete.next()){
                p = new Pompier();
                p.setId(resultatRequete.getInt("p_id"));
                p.setNom(resultatRequete.getString("p_nom"));
                p.setPrenom(resultatRequete.getString("p_prenom"));
                p.setDateNaiss(resultatRequete.getString("p_datenaiss"));
                
                Caserne c = new Caserne();
                c.setId(resultatRequete.getInt("c_id"));
                c.setNom(resultatRequete.getString("c_nom"));
                p.setUneCaserne(c);

                Grade g = new Grade();
                g.setId(resultatRequete.getInt("g_id"));
                g.setLibelle(resultatRequete.getString("g_libelle"));
                
                // NOUVEAU : Mapping de la catégorie
                CategorieGrade cg = new CategorieGrade();
                cg.setId(resultatRequete.getInt("cg_id"));
                cg.setLibelle(resultatRequete.getString("cg_libelle"));
                g.setCategorieGrade(cg);
                
                p.setGrade(g);

                Profession pr = new Profession();
                pr.setId(resultatRequete.getInt("pr_id"));
                pr.setLibelle(resultatRequete.getString("pr_libelle"));
                p.setProfession(pr);
            }
        } catch (SQLException e){ e.printStackTrace(); }
        return p;
    }

    public static Pompier addPompier(Connection connection, Pompier p){      
        try {
            requeteSql = connection.prepareStatement("INSERT INTO POMPIER (NOM, PRENOM, ID_CASERNE) VALUES (?,?,?)", 
                                        Statement.RETURN_GENERATED_KEYS );
            requeteSql.setString(1, p.getNom());
            requeteSql.setString(2, p.getPrenom());
            requeteSql.setInt(3, p.getUneCaserne().getId());
            requeteSql.executeUpdate();
            resultatRequete = requeteSql.getGeneratedKeys();
            if (resultatRequete.next()) {
                p.setId(resultatRequete.getInt(1));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return p;    
    }
}