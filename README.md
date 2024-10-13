# Pokémon List Application

## Descripción

Esta aplicación Flutter permite a los usuarios explorar una lista de Pokémon utilizando la [PokeAPI](https://pokeapi.co/). La aplicación está diseñada con una arquitectura limpia y utiliza Riverpod para la gestión de estado. Ofrece una interfaz de usuario atractiva y funcional, con la capacidad de alternar entre modos claro y oscuro.

## Características

- Visualización de una lista de Pokémon con nombre e imagen.
- Navegación a una pantalla de detalle de Pokémon al seleccionar un elemento de la lista.
- Carga infinita de Pokémon a medida que el usuario se desplaza hacia abajo.
- Alternancia entre modo claro y oscuro.

## Tecnologías Utilizadas

- Flutter
- Dart
- Riverpod
- Dio (para solicitudes HTTP)
- Mockito (para pruebas)
- Flutter Test (para pruebas unitarias)

## Instalación

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/tu-usuario/poke_app.git
   cd poke_app
   ```

2. **Instala las dependencias:**

   ```bash
   flutter pub get
   ```

3. **Ejecuta la aplicación:**

   ```bash
   flutter run
   ```

## Estructura del Proyecto

- **lib/**
  - **data/**
    - **datasources/**: Fuentes de datos remotas y locales.
    - **models/**: Modelos de datos.
    - **repositories/**: Implementaciones de repositorios.
  - **domain/**
    - **entities/**: Entidades de negocio.
    - **repositories/**: Interfaces de repositorio.
    - **usecases/**: Casos de uso.
  - **presentation/**
    - **providers/**: Proveedores de estado de Riverpod.
    - **screens/**: Pantallas de la aplicación.
    - **widgets/**: Widgets personalizados.
  - **main.dart**: Punto de entrada de la aplicación.

## Uso

1. Al abrir la aplicación, se mostrará una lista de Pokémon.
2. Desplázate hacia abajo para cargar más Pokémon.
3. Toca un Pokémon para ver su detalle.
4. Usa el menú desplegable para alternar entre el modo claro y oscuro.

## Pruebas

La aplicación incluye pruebas unitarias para verificar la funcionalidad de las principales características. Puedes ejecutar las pruebas utilizando:

```bash
flutter test
```

### Ejemplos de Pruebas

- **Prueba de Carga de Pokémon:** Verifica que se muestre una lista de Pokémon cuando se cargan los datos correctamente.
- **Indicador de Carga:** Asegura que se muestre un indicador de carga mientras se están obteniendo datos.

```dart
testWidgets('should display a list of Pokémon when data is loaded', (WidgetTester tester) async {
  // Configuración de prueba...
});
```

## Contribuciones

Las contribuciones son bienvenidas. Si deseas contribuir, por favor abre un issue o envía un pull request.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.
