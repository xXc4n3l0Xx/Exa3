<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Proyecto</title>
    <style>
        body {
            background-image: url("images/ini.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            overflow: hidden;
        }

        .container {
            background-color: rgba(15, 15, 15, 0.8);
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.6);
            max-width: 700px;
            width: 90%;
            animation: fadeIn 1.2s ease-out;
        }

        h1 {
            font-size: 2.8em;
            margin-bottom: 25px;
            color: #5FFB17;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.8);
        }

        p {
            font-size: 1.3em;
            line-height: 1.6;
            margin-bottom: 35px;
        }

        strong {
            color: #00E0FF;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }

        .button-group a {
            background-color: #00b894;
            color: #ffffff;
            padding: 14px 28px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 1.1em;
            font-weight: bold;
            width: 75%;
            max-width: 280px;
            transition: all 0.3s ease;
        }

        .button-group a:hover {
            background-color: #00a17a;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>EXAMEN III</h1>
    <p>
        <strong>Nombre:</strong> Jose Armando Pichal Pio<br>
        <strong>Nombre:</strong> Jose Canela Beltran<br>
        <strong>Materia:</strong> Paradigmas de Programacion II
    </p>

    <div class="button-group">
        <a href="empleados">Ver Empleados</a>
        <a href="departamentos">Ver Departamentos</a>
    </div>
</div>

</body>
</html>
