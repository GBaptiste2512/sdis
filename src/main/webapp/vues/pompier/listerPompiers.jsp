<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Pompier"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SDIS 14 - Pompiers</title>
        <style>
            table { border-collapse: collapse; width: 90%; margin: auto; }
            th, td { border: 1px solid black; padding: 10px; text-align: left; }
            th { background-color: #eee; }
        </style>
    </head>
    <body>
        <div class="container"> <div class="header-left">
            <jsp:include page="/vues/inclusions/header.jsp" />
        </div>
        <h1 style="text-align:center;">Liste des pompiers</h1>
        <% ArrayList<Pompier> lesPompiers = (ArrayList<Pompier>)request.getAttribute("pLesPompiers"); %>
        <div style="margin-bottom: 20px;">
        <a href="../ServletPompier/ajouter" style="display:inline-block; padding:10px 15px; background-color:#28a745; color:white; text-decoration:none; border-radius:5px; font-weight: bold;">➕ Ajouter un Pompier</a>
        </div>
        <table>  
            <thead>
                <tr>             
                    <th>Matricule (ID)</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Caserne</th>                
                </tr>
            </thead>
            <tbody>
                <% if(lesPompiers != null) {
                    for (Pompier p : lesPompiers) { %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td>
                            <a href="../ServletPompier/consulter?idPompier=<%= p.getId() %>">
                                <%= p.getNom() %>
                            </a>
                        </td>
                        <td><%= p.getPrenom() %></td>
                        <td>
                        <% if (p.getUneCaserne() != null) { %>
                        <a href="../ServletCaserne/consulter?idCaserne=<%= p.getUneCaserne().getId() %>">
                        <%= p.getUneCaserne().getNom() %>
                        </a>
                        <% } else { %>
                        N/A
                        <% } %>
                        </td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
        <div class="container"> <div class="header-left">
            <jsp:include page="/vues/inclusions/footer.jsp" />
        </div>
    </body>
</html>