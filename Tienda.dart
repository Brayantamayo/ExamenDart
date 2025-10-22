import 'dart:io';

// Lista de productos y contador de IDs
List<Map<String, dynamic>> productos = [];
int id = 1;

void main() {
  bool continuar = true;

  while (continuar) {
    print('\n===== MENÚ PRINCIPAL =====');
    print('1. Agregar producto');
    print('2. Listar productos');
    print('3. Actualizar producto');
    print('4. Eliminar producto');
    print('5. Salir');
    stdout.write('Elige una opción: ');
    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        agregarProducto();
        break;
      case '2':
        listarProductos();
        break;
      case '3':
        actualizarProducto();
        break;
      case '4':
        eliminarProducto();
        break;
      case '5':
        print('Programa finalizado.');
        continuar = false;
        break;
      default:
        print('Opción inválida. Intenta nuevamente.');
    }
  }
}

// 🔹 Agregar producto
void agregarProducto() {
  stdout.write('Nombre del producto: ');
  String? nombre = stdin.readLineSync();

  stdout.write('Precio: ');
  double? precio = double.tryParse(stdin.readLineSync() ?? '');

  stdout.write('Cantidad: ');
  int? cantidad = int.tryParse(stdin.readLineSync() ?? '');

  if (nombre != null && precio != null && cantidad != null) {
    productos.add({
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
    });
    print(' Producto agregado con ID $id');
    id++;
  } else {
    print('Datos inválidos. Intenta de nuevo.');
  }
}

// 🔹 Listar productos
void listarProductos() {
  if (productos.isEmpty) {
    print('No hay productos registrados.');
  } else {
    print('\n===== LISTA DE PRODUCTOS =====');
    for (var p in productos) {
      print(
          'ID: ${p['id']} | ${p['nombre']} | Precio: \$${p['precio']} | Cantidad: ${p['cantidad']}');
    }
  }
}

// 🔹 Actualizar producto
void actualizarProducto() {
  if (productos.isEmpty) {
    print(' No hay productos para actualizar.');
    return;
  }

  stdout.write('Ingrese el ID del producto a actualizar: ');
  int? idBuscar = int.tryParse(stdin.readLineSync() ?? '');
  var producto =
      productos.firstWhere((p) => p['id'] == idBuscar, orElse: () => {});

  if (producto.isEmpty) {
    print('Producto no encontrado.');
  } else {
    stdout.write('Nuevo nombre (${producto['nombre']}): ');
    String? nuevoNombre = stdin.readLineSync();
    if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
      producto['nombre'] = nuevoNombre;
    }

    stdout.write('Nuevo precio (${producto['precio']}): ');
    double? nuevoPrecio = double.tryParse(stdin.readLineSync() ?? '');
    if (nuevoPrecio != null) producto['precio'] = nuevoPrecio;

    stdout.write('Nueva cantidad (${producto['cantidad']}): ');
    int? nuevaCantidad = int.tryParse(stdin.readLineSync() ?? '');
    if (nuevaCantidad != null) producto['cantidad'] = nuevaCantidad;

    print('✅ Producto actualizado.');
  }
}

// 🔹 Eliminar producto
void eliminarProducto() {
  if (productos.isEmpty) {
    print('📭 No hay productos para eliminar.');
    return;
  }

  stdout.write('Ingrese el ID del producto a eliminar: ');
  int? idEliminar = int.tryParse(stdin.readLineSync() ?? '');
  int index = productos.indexWhere((p) => p['id'] == idEliminar);

  if (index == -1) {
    print('Producto no encontrado.');
  } else {
    productos.removeAt(index);
    print('Producto eliminado correctamente.');
  }
}
