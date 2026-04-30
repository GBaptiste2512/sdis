package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Profession;

public class DaoProfession {
    public static ArrayList<Profession> getLesProfessions(Connection cnx) {
        ArrayList<Profession> lesProfessions = new ArrayList<>();
        try {
            PreparedStatement requeteSql = cnx.prepareStatement("SELECT * FROM profession");
            ResultSet resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()) {
                Profession pr = new Profession();
                pr.setId(resultatRequete.getInt("ID_PROFESSION")); // Adapte si ta colonne s'appelle autrement
                pr.setLibelle(resultatRequete.getString("LIBELLE"));
                lesProfessions.add(pr);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return lesProfessions;
    }
}