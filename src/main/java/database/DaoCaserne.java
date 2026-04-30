package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.Caserne;

public class DaoCaserne {
    
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Caserne> getLesCasernes(Connection cnx){
        ArrayList<Caserne> lesCasernes= new ArrayList<Caserne>();
        try{
            requeteSql = cnx.prepareStatement("select * from caserne");
            resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()){
                Caserne c = new Caserne();
                c.setId(resultatRequete.getInt("id_caserne"));
                c.setNom(resultatRequete.getString("nom"));
                c.setVille(resultatRequete.getString("ville"));
                lesCasernes.add(c);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return lesCasernes;
    }
    
    public static Caserne getCaserneById(Connection cnx, int idCaserne){
        Caserne c = null;
        try{
            requeteSql = cnx.prepareStatement("select * from caserne where id_caserne = ?");
            requeteSql.setInt(1, idCaserne);
            resultatRequete = requeteSql.executeQuery();
            
            if (resultatRequete.next()){
                c = new Caserne();
                c.setId(resultatRequete.getInt("id_caserne"));
                c.setNom(resultatRequete.getString("nom"));
                c.setRue(resultatRequete.getString("rue"));
                c.setCopos(resultatRequete.getString("copos"));
                c.setVille(resultatRequete.getString("ville"));
            }
        } catch (SQLException e){ e.printStackTrace(); }
        return c;
    }
    
    public static Caserne updateCaserne(Connection cnx, Caserne c){
        try{
            requeteSql = cnx.prepareStatement("update caserne set nom = ?, rue = ?, copos = ?, ville = ? where id_caserne = ?");
            requeteSql.setString(1, c.getNom());
            requeteSql.setString(2, c.getRue());
            requeteSql.setString(3, c.getCopos());
            requeteSql.setString(4, c.getVille());
            requeteSql.setInt(5, c.getId());
            requeteSql.executeUpdate();
        } catch (SQLException e){ e.printStackTrace(); }
        return c;
    }

    // NOUVEAUTÉ : La méthode pour supprimer une caserne
    public static void deleteCaserne(Connection cnx, int idCaserne) {
        try {
            
            PreparedStatement requeteEngins = cnx.prepareStatement("DELETE FROM engin WHERE id_caserne = ?");
            requeteEngins.setInt(1, idCaserne);
            requeteEngins.executeUpdate();

            
            PreparedStatement requetePompiers = cnx.prepareStatement("DELETE FROM pompier WHERE id_caserne = ?");
            requetePompiers.setInt(1, idCaserne);
            requetePompiers.executeUpdate();

            
            PreparedStatement requeteCaserne = cnx.prepareStatement("DELETE FROM caserne WHERE id_caserne = ?");
            requeteCaserne.setInt(1, idCaserne);
            requeteCaserne.executeUpdate();

            System.out.println("Caserne et toutes ses dépendances supprimées avec succès !");

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Erreur lors de la suppression en cascade de la caserne.");
        }
    }
    // NOUVEAUTÉ : La méthode pour AJOUTER une caserne
    public static Caserne addCaserne(Connection cnx, Caserne c) {
        try {
            // Le Statement.RETURN_GENERATED_KEYS permet de récupérer l'ID généré automatiquement par MariaDB
            requeteSql = cnx.prepareStatement("INSERT INTO caserne (nom, rue, copos, ville) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            requeteSql.setString(1, c.getNom());
            requeteSql.setString(2, c.getRue());
            requeteSql.setString(3, c.getCopos());
            requeteSql.setString(4, c.getVille());
            requeteSql.executeUpdate();
            
            // On récupère l'ID tout neuf et on le met dans notre objet Caserne
            resultatRequete = requeteSql.getGeneratedKeys();
            if (resultatRequete.next()) {
                c.setId(resultatRequete.getInt(1));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
            System.out.println("Erreur lors de l'ajout de la caserne.");
        }
        return c;
    }
}