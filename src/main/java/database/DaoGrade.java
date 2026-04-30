package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Grade;

public class DaoGrade {
    
    public static ArrayList<Grade> getLesGrades(Connection cnx) {
        ArrayList<Grade> lesGrades = new ArrayList<>();
        try {
            PreparedStatement requeteSql = cnx.prepareStatement("SELECT * FROM grade");
            ResultSet resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()) {
                Grade g = new Grade();
                g.setId(resultatRequete.getInt("ID_GRADE"));
                g.setLibelle(resultatRequete.getString("LIBELLE"));
                lesGrades.add(g);
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
            System.out.println("Erreur lors de la récupération des grades");
        }
        return lesGrades;
    }
}