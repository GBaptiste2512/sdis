package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Engin;

public class DaoEngin {
    
    public static ArrayList<Engin> getLesEnginsByCaserne(Connection cnx, int idCaserne) {
        ArrayList<Engin> lesEngins = new ArrayList<>();
        try {
            PreparedStatement requeteSql = cnx.prepareStatement("SELECT * FROM engin WHERE ID_CASERNE = ?");
            requeteSql.setInt(1, idCaserne);
            ResultSet resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()) {
                Engin e = new Engin();
                e.setId(resultatRequete.getInt("ID_ENGIN")); 
                e.setLibelle(resultatRequete.getString("LIBELLE"));
                e.setNumeroOrdre(resultatRequete.getInt("NUMEROORDRE"));
                lesEngins.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lesEngins;
    }
}