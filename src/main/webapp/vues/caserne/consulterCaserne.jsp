<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Caserne"%>
<!DOCTYPE html>
<html>
<head>
    <title>Détail Caserne</title>
    <style>
        .container { width: 50%; margin: 20px auto; font-family: Arial, sans-serif; }
        .card { border: 1px solid #ccc; padding: 20px; border-radius: 8px; box-shadow: 2px 2px 12px #eee; }
        .label { font-weight: bold; color: #555; margin-top: 10px; }
        .value { margin-bottom: 15px; font-size: 1.1em; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Détail de la Caserne</h1>
        <%
            Caserne c = (Caserne)request.getAttribute("pCaserne");
            if (c != null) {
        %>
            <div class="card">
                <div class="label">ID Caserne :</div>
                <div class="value"><%= c.getId() %></div>

                <div class="label">Nom :</div>
                <div class="value"><%= c.getNom() %></div>

                <div class="label">Rue :</div>
                <div class="value"><%= (c.getRue() != null) ? c.getRue() : "Non renseignée" %></div>

                <div class="label">Code Postal :</div>
                <div class="value"><%= (c.getCopos() != null) ? c.getCopos() : "Non renseigné" %></div>

                <div class="label">Ville :</div>
                <div class="value"><%= (c.getVille() != null) ? c.getVille() : "Non renseignée" %></div>
            </div>
        <% } else { %>
            <p style="color:red;">Erreur : Impossible de trouver cette caserne.</p>
        <% } %>
        <br>
        <a href="../ServletCaserne/modifier?idCaserne=<%= c.getId() %>" style="display:inline-block; padding:10px; background-color:#ADD8E6; color:black; text-decoration:none; border-radius:5px;">✏️ Modifier</a>
        <br>
        <a href="../ServletPompier/lister">← Retour à la liste des pompiers</a>
    </div>
</body>
</html>