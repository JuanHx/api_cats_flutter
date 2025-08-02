# 🐱 API Cats App

Una aplicación Flutter que consume la API de The Cat API para mostrar información sobre razas de gatos y imágenes aleatorias.

## 📱 Características

- **Lista de Razas**: Explora todas las razas de gatos disponibles con información detallada
- **Gatos Aleatorios**: Descubre gatos aleatorios con imágenes hermosas
- **Detalles de Raza**: Visualiza información específica de cada raza de gato
- **Galería de Imágenes**: Navega por múltiples imágenes de cada raza
- **Interfaz Moderna**: Diseño limpio y atractivo con animaciones Lottie
- **Arquitectura BLoC**: Implementación de patrón BLoC para gestión de estado

## 🏗️ Arquitectura del Proyecto

```
lib/
├── data/
│   ├── datasources/          # Fuentes de datos
│   ├── models/              # Modelos de datos
│   ├── dio_client.dart      # Cliente HTTP
│   └── interceptors/        # Interceptores HTTP
├── domain/
│   └── entities/            # Entidades del dominio
├── presentation/
│   ├── bloc/               # Lógica de negocio (BLoC)
│   ├── pages/              # Páginas de la aplicación
│   └── widgets/            # Widgets reutilizables
└── main.dart               # Punto de entrada
```

## 🚀 Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **BLoC Pattern**: Gestión de estado
- **Dio**: Cliente HTTP para llamadas a API
- **Lottie**: Animaciones
- **Carousel Slider**: Carrusel de imágenes
- **Google Fonts**: Tipografías personalizadas
- **WebView Flutter**: Visualización de contenido web

## 📋 Requisitos Previos

- Flutter SDK 3.8.1 o superior
- Dart SDK
- Android Studio / VS Code
- Dispositivo Android/iOS o emulador

## ⚙️ Instalación

1. **Clona el repositorio**
   ```bash
   git clone <url-del-repositorio>
   cd api_cats_flutter
   ```

2. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecuta la aplicación**
   ```bash
   flutter run
   ```

## 🔧 Configuración

### API Key (Opcional)
La aplicación funciona sin API key, pero para mejor rendimiento puedes configurar una:

1. Obtén una API key gratuita en [The Cat API](https://thecatapi.com/)
2. Modifica el archivo `lib/data/interceptors/auth_interceptor.dart`
3. Agrega tu API key en el header de autorización

## 📱 Funcionalidades

### 🏠 Página Principal
- Interfaz con dos botones principales
- Navegación a lista de razas y gatos aleatorios
- Diseño triangular de botones con animaciones

### 📋 Lista de Razas
- Muestra todas las razas de gatos disponibles
- Información detallada de cada raza
- Navegación a detalles específicos

### 🎲 Gatos Aleatorios
- Imágenes aleatorias de gatos
- Botones de like/dislike
- Navegación a información de la raza

### 🖼️ Detalles de Raza
- Información completa de la raza
- Galería de imágenes con carrusel
- Enlaces a recursos externos

## 🎨 Assets y Recursos

### Iconos
- `pata.png`: Icono principal de la aplicación
- `lista.gif`: Icono para lista de razas
- `toma-de-decisiones.gif`: Icono para gatos aleatorios
- `me-gusta.png` / `no-me-gusta.png`: Botones de interacción

### Animaciones Lottie
- `cat_paw_loading.json`: Animación de carga
- `error_404.json`: Animación de error
- `lovely_cats.json`: Animación de gatos

## 🔄 Patrón BLoC

La aplicación utiliza el patrón BLoC para la gestión de estado:

- **BreedBloc**: Maneja el estado de las razas de gatos
- **BreedEvent**: Eventos para cargar y gestionar razas
- **BreedState**: Estados de la aplicación (loading, loaded, error)

## 🌐 API Externa

La aplicación consume [The Cat API](https://thecatapi.com/):
- **Base URL**: `https://api.thecatapi.com/v1`
- **Endpoints principales**:
  - `/breeds`: Lista de todas las razas
  - `/images/search`: Búsqueda de imágenes por raza

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter_bloc: ^9.1.1    # Gestión de estado
  dio: ^5.8.0+1           # Cliente HTTP
  lottie: ^3.3.1          # Animaciones
  carousel_slider: ^5.1.1  # Carrusel de imágenes
  google_fonts: ^6.2.1     # Tipografías
  webview_flutter: ^4.13.0 # Visualización web
```


## 📱 Build

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

## 👨‍💻 Autor

Desarrollado con ❤️ usando Flutter
