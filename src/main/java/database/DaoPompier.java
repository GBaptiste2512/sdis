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
            requeteSql = cnx.prepareStatement("select p.matricule as p_id, p.nom as p_nom, p.prenom as p_prenom, c.id_caserne as c_id, c.nom as c_nom " +
                                 " from pompier p left join caserne c on p.id_caserne = c.id_caserne");
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
                "select p.matricule as p_id, p.nom as p_nom, p.prenom as p_prenom, p.datenaiss as p_datenaiss, " +
                "c.id_caserne as c_id, c.nom as c_nom, " +
                "g.id_grade as g_id, g.libelle as g_libelle, " +
                "cg.id_categoriegrade as cg_id, cg.libelle as cg_libelle, " + // NOUVEAU
                "pr.id_profession as pr_id, pr.libelle as pr_libelle " +
                "from pompier p " +
                "left join caserne c on p.id_caserne = c.id_caserne " +
                "left join grade g on p.id_grade = g.id_grade " +
                "left join categoriegrade cg on g.id_categoriegrade = cg.id_categoriegrade " + // NOUVEAU
                "left join profession pr on p.id_profession = pr.id_profession " +
                "where p.matricule = ?"
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
            requeteSql = connection.prepareStatement("insert into pompier (nom, prenom, id_caserne) values (?,?,?)", 
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
    
    public static Pompier updatePompier(Connection cnx, Pompier p){
        try{
            // On met à jour les champs 
            requeteSql = cnx.prepareStatement("update pompier set nom = ?, prenom = ?, datenaiss = ? where matricule = ?");
            requeteSql.setString(1, p.getNom());
            requeteSql.setString(2, p.getPrenom());
            requeteSql.setString(3, p.getDateNaiss());
            requeteSql.setInt(4, p.getId());
            requeteSql.executeUpdate();
        } catch (SQLException e){ e.printStackTrace(); }
        return p;
    }
}