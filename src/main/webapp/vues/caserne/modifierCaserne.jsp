<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Caserne"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier Caserne</title>
    <style>
        .container { width: 50%; margin: 20px auto; font-family: Arial; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; }
        input[type="text"] { width: 100%; padding: 8px; margin-top: 5px; }
        .btn-submit { padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Modifier la Caserne</h1>
        <% Caserne c = (Caserne)request.getAttribute("pCaserne"); %>
        
        <form action="../ServletCaserne/modifier" method="POST">
            <input type="hidden" name="idCaserne" value="<%= c.getId() %>">
            
            <div class="form-group">
                <label>Nom :</label>
                <input type="text" name="nom" value="<%= c.getNom() %>" required>
            </div>
            <div class="form-group">
                <label>Rue :</label>
                <input type="text" name="rue" value="<%= (c.getRue() != null) ? c.getRue() : "" %>">
            </div>
            <div class="form-group">
                <label>Code Postal :</label>
                <input type="text" name="copos" value="<%= (c.getCopos() != null) ? c.getCopos() : "" %>">
            </div>
            <div class="form-group">
                <label>Ville :</label>
                <input type="text" name="ville" value="<%= (c.getVille() != null) ? c.getVille() : "" %>">
            </div>
            
            <button type="submit" class="btn-submit">💾 Enregistrer les modifications</button>
            <a href="../ServletCaserne/consulter?idCaserne=<%= c.getId() %>" style="margin-left: 10px; color: red;">Annuler</a>
        </form>
    </div>
</body>
</html>