/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Caserne;

/**
 *
 * @author zakina
 */
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
}