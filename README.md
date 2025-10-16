# My Expenses

My Expenses es una aplicación Flutter multiplataforma para el registro y visualización de gastos e ingresos personales. Permite llevar el control financiero mensual de manera sencilla y visual.

## Características

- **Registro de transacciones:** Puedes añadir ingresos y gastos, seleccionando categoría, tipo y monto.
- **Historial de transacciones:** Visualiza todas tus transacciones, con opción de editar o eliminar.
- **Resumen mensual:** Muestra el total de ingresos y gastos del mes.
- **Gráfico de gastos:** Visualización de gastos por categoría usando gráficos circulares.
- **Persistencia local:** Los datos se guardan en una base de datos SQLite local.
- **Diseño adaptativo:** Interfaz moderna y responsiva.
  
## ¿Cómo se hizo?

La app fue desarrollada con Flutter, usando el patrón Provider para la gestión de estado. La persistencia de datos se realiza con SQLite mediante el paquete [sqflite](https://pub.dev/packages/sqflite). El gráfico de gastos utiliza [fl_chart](https://pub.dev/packages/fl_chart).

La arquitectura separa la lógica de negocio (providers y servicios) de la interfaz (screens y widgets), facilitando la escalabilidad y el mantenimiento.

## Instalación y ejecución

1. Clona el repositorio.
2. Ejecuta `flutter pub get` para instalar dependencias.
3. Corre la app con `flutter run` en tu dispositivo o emulador.

## Personalización

Puedes modificar las categorías de gastos en el archivo [`lib/widgets/expense_chart.dart`](lib/widgets/expense_chart.dart) y en el formulario de transacciones.

## Créditos

Desarrollado por Breiner Gonzalez Machado.  
Basado en Flutter y paquetes open source.
