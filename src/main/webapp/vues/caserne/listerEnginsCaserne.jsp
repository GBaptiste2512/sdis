<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Engin"%>
<%@page import="model.Caserne"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Liste des engins</title>
        <style>
            /* On ne garde que le style spécifique au tableau, le reste est dans le header */
            table { border-collapse: collapse; width: 100%; margin-top: 20px; }
            th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
            th { background-color: #f4f4f4; }
            tr:hover { background-color: #f9f9f9; }
            .info-vide { padding: 20px; background: #fff3cd; color: #856404; border-radius: 5px; }
        </style>
    </head>
    <body>
        <div class="container">
            <%-- Inclusion du Header --%>
            <jsp:include page="/vues/inclusions/header.jsp" />

            <%
    ArrayList<Engin> lesEngins = (ArrayList<Engin>) request.getAttribute("pLesEngins");
    Caserne laCaserne = (Caserne) request.getAttribute("pCaserne");
    %>

<h1>Engins affectés à la caserne : <%= (laCaserne != null) ? laCaserne.getNom() : "Inconnue" %></h1>
            
            <% if(lesEngins != null && !lesEngins.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Libellé</th>
                            <th>Numéro d'ordre</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Engin e : lesEngins) { %>
                            <tr>
                                <td><%= e.getId() %></td>
                                <td><%= e.getLibelle() %></td>
                                <td><%= e.getNumeroOrdre() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p class="info-vide">Aucun engin affecté à cette caserne pour le moment.</p>
            <% } %>

            <p style="margin-top: 20px;">
                <a href="../ServletCaserne/lister" class="btn-menu" style="background-color: #6c757d;"> Retour a la Liste</a>
            </p>

            <%-- Inclusion du Footer --%>
            <jsp:include page="/vues/inclusions/footer.jsp" />
        </div>
    </body>
</html>