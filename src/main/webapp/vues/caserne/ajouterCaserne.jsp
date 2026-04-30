<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Nouvelle Caserne</title>
        <style>
            body { font-family: Arial, sans-serif; }
            .form-container { border: 1px solid #ddd; padding: 20px; border-radius: 8px; background-color: #f9f9f9; margin-top: 20px; width: 50%; margin-left: auto; margin-right: auto;}
            .form-group { margin-bottom: 15px; }
            .form-group label { display: block; font-weight: bold; margin-bottom: 5px; }
            .form-group input { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;}
            .btn-submit { background-color: #28a745; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; font-size: 16px;}
            .btn-submit:hover { background-color: #218838; }
            .btn-retour { display: inline-block; padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 5px; margin-left: 10px; font-weight: bold;}
        </style>
    </head>
    <body>
        <div class="container">
            <%-- Inclusion du Header --%>
            <jsp:include page="/vues/inclusions/header.jsp" />

            <h1 style="text-align: center;">➕ Ajouter une nouvelle Caserne</h1>

            <div class="form-container">
                <form action="../ServletCaserne/ajouter" method="POST" onsubmit="return confirm('Confirmez-vous la création de cette nouvelle caserne ?');">
                    
                    <div class="form-group">
                        <label>Nom de la caserne :</label>
                        <input type="text" name="nom" placeholder="Ex: Caserne de Caen" required />
                    </div>
                    
                    <div class="form-group">
                        <label>Rue :</label>
                        <input type="text" name="rue" placeholder="Ex: 12 rue des pompiers" required />
                    </div>
                    
                    <div class="form-group">
                        <label>Code Postal :</label>
                        <input type="text" name="copos" placeholder="Ex: 14000" maxlength="5" required />
                    </div>
                    
                    <div class="form-group">
                        <label>Ville :</label>
                        <input type="text" name="ville" placeholder="Ex: Caen" required />
                    </div>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <input type="submit" value="Enregistrer la caserne" class="btn-submit">
                        <a href="../ServletCaserne/lister" class="btn-retour">Annuler</a>
                    </div>
                </form>
            </div>

            <%-- Inclusion du Footer --%>
            <div style="margin-top: 40px;">
                <jsp:include page="/vues/inclusions/footer.jsp" />
            </div>
        </div>
    </body>
</html>