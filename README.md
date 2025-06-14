# Conexión a MySQL desde Node.js

## Objetivo: 
Establecer una conexión exitosa a una base de datos MySQL (en nuestro caso será la
base de datos de Hotel) desde un programa Node.js y realizar una consulta simple para
verificar la conexión.

## Requisitos:
1. MySQL instalado y configurado: Debe tener MySQL instalado y corriendo en su
máquina.
2. Node.js instalado: Debe tener Node.js instalado y configurado en su máquina.
3. Paquete mysql o mysql2: Instale uno de estos paquetes usando npm (por
ejemplo, npm install mysql o npm install mysql2).
4. Base de datos existente: Necesitará una base de datos MySQL ya creada y con una
tabla de ejemplo.
5. Credenciales de acceso: Debe tener las credenciales de usuario y contraseña para
acceder a la base de datos.
6. Código Node.js: Escriba un programa Node.js que:
 - Importe el módulo mysql o mysql2.
 - Establezca la conexión a la base de datos utilizando las credenciales correctas.
 - Verifique si la conexión se realizó correctamente.
 - Ejecute una consulta SELECT simple en una tabla de la base de datos (por
   ejemplo, SELECT * FROM usuarios).
 - Imprima los resultados de la consulta en la consola.
 - Cierre la conexión después de la consulta.

## Consideraciones adicionales:
 - Manejo de errores:
   Incluya un manejo de errores adecuado para la conexión y las consultas.
 - Asincronía:
   Recuerde que las operaciones con la base de datos son asincrónicas. Utilice async/await o
   promesas para manejar el flujo de control.
-  Configuración:
   Considere crear un archivo de configuración (por ejemplo, config.js) para almacenar las 
   credenciales de la base de datos de forma segura.
-  Puntos de prueba:
   Defina puntos de prueba para verificar que la conexión y las consultas se realizan
   correctamente.
