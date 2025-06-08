import readLine from "readline";
import mysql from "mysql2";

const rl = readLine.createInterface({
  input: process.stdin,
  output: process.stdout,
});

let conexion;

let host;
let usuario;
let contrasena;

async function generarConexion() {
  conexion = await mysql.createConnection({
    host: host,
    user: usuario,
    password: contrasena,
    database: "practica_hotel",
  });
}

function question(prompt) {
  return new Promise((resolver) => {
    rl.question(prompt, (respuesta) => {
      resolver(respuesta);
    });
  });
}

async function conexionSQL() {
  try {
    await generarConexion();
    conexion.connect();
    console.log("\nConexión a MySQL establecida correctamente");
  } catch (error) {
    console.error("\nError al conectar a MySQL:", error);
  }
}

async function consultaSQL(opcionTabla) {
  try {
    let consulta;
    switch (opcionTabla) {
      case 1:
        consulta = "SELECT * FROM cliente";
        break;
      case 2:
        consulta = "SELECT * FROM reserva";
        break;
      case 3:
        consulta = "SELECT * FROM habitacion";
        break;
      case 4:
        console.log("Volviendo...");
        break;
    }
    const [rows] = await conexion.promise().execute(consulta);
    console.log("Resultados de la consulta:");
    console.log(rows);
  } catch (error) {
    console.log("Error en la consulta:", error);
  }
}

//Menu
async function menu() {
  while (true) {
    console.clear();
    console.log(" == Gestor del hotel == ");
    console.log("\n  1. Conectar a la BD");
    console.log("  2. Ejecutar consulta");
    console.log("\n  3. Salir\n");

    let opcion = Number(await question("Selecciona una opción: "));
    switch (opcion) {
      case 1:
        host = await question("Introduce la dirección del host: ");
        usuario = await question("Introduce el usuario: ");
        contrasena = await question("Introduce la contraseña: ");
        await conexionSQL();
        await question("Pulsa enter para volver al menú...");
        break;
      case 2:
        console.log("Selecciona una tabla donde realizar la consulta:");
        console.log("\n  1. Clientes");
        console.log("  2. Reservas");
        console.log("  3. Habitaciones\n");
        let opcionTabla = Number(await question("Selecciona una opción: "));
        await consultaSQL(opcionTabla);
        await question("Pulsa enter para volver al menú...");
        break;
      case 3:
        await conexion.end();
        console.log("Saliendo...");
        rl.close();
        process.exit();
      default:
        console.log("¡Has especificado una opción inválida!");
        break;
    }
  }
}

menu();
