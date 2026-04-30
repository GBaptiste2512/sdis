<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Caserne"%>
<%@page import="model.Grade"%>
<%@page import="model.Profession"%>
<%@page import="form.FormPompier"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Ajouter un Pompier</title>
        <style>
            body { font-family: Arial, sans-serif; }
            .form-container { border: 1px solid #ddd; padding: 20px; border-radius: 8px; background-color: #f9f9f9; margin-top: 20px; width: 50%; margin-left: auto; margin-right: auto;}
            .form-group { margin-bottom: 15px; }
            .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
            .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;}
            .btn-submit { background-color: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; font-size: 16px;}
            .btn-submit:hover { background-color: #218838; }
            .btn-retour { display: inline-block; padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 5px; margin-left: 10px; font-weight: bold;}
            .erreur { color: red; font-size: 0.9em; margin-top: 5px; display: block; }
        </style>
    </head>
    <body>
        <div class="container">
            <jsp:include page="/vues/inclusions/header.jsp" />

            <h1 style="text-align: center;">➕ Ajouter un nouveau Pompier</h1>

            <% FormPompier form = (FormPompier)request.getAttribute("form"); %>

            <div class="form-container">
                <form action="../ServletPompier/ajouter" method="POST" onsubmit="return confirm('Confirmez-vous la création de ce nouveau pompier ?');">
                    
                    <div class="form-group">
                        <label for="nom">Nom :</label>
                        <input id="nom" type="text" name="nom" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="prenom">Prénom :</label>
                        <input id="prenom" type="text" name="prenom" required />
                    </div>

                    <div class="form-group">
                        <label for="dateNaiss">Date de Naissance :</label>
                        <input id="dateNaiss" type="date" name="dateNaiss" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="grade">Grade :</label>
                        <select id="grade" name="idGrade" required>
                            <option value="">-- Sélectionnez un grade --</option>
                            <%
                                ArrayList<Grade> lesGrades = (ArrayList<Grade>)request.getAttribute("pLesGrades");
                                if (lesGrades != null) {
                                    for (Grade g : lesGrades) {
                            %>
                                <option value="<%= g.getId() %>"><%= g.getLibelle() %></option>
                            <% } } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="profession">Profession :</label>
                        <select id="profession" name="idProfession" required>
                            <option value="">-- Sélectionnez une profession --</option>
                            <%
                                ArrayList<Profession> lesProfessions = (ArrayList<Profession>)request.getAttribute("pLesProfessions");
                                if (lesProfessions != null) {
                                    for (Profession pr : lesProfessions) {
                            %>
                                <option value="<%= pr.getId() %>"><%= pr.getLibelle() %></option>
                            <% } } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="caserne">Caserne d'affectation :</label>
                        <select id="caserne" name="idCaserne" required>
                            <option value="">-- Sélectionnez une caserne --</option>
                            <%
                                ArrayList<Caserne> lesCasernes = (ArrayList<Caserne>)request.getAttribute("pLesCasernes");
                                if (lesCasernes != null) {
                                    for (Caserne c : lesCasernes) {
                            %>
                                <option value="<%= c.getId() %>"><%= c.getNom() %></option>
                            <% } } %>
                        </select>
                    </div>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <input type="submit" value="Enregistrer le pompier" class="btn-submit">
                        <a href="../ServletPompier/lister" class="btn-retour">Annuler</a>
                    </div>
                </form>
            </div>

            <div style="margin-top: 40px;">
                <jsp:include page="/vues/inclusions/footer.jsp" />
            </div>
        </div>
    </body>
</html>