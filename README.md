# Chat App (Flutter)

Una aplicación de chat multiplataforma construida con **Flutter**, con soporte para **Android, iOS, Web, Windows, macOS y Linux**, e integración con un **backend** para mensajería en tiempo real.

---

## Características

UI moderna en Flutter  
Envío y recepción de mensajes  
Arquitectura lista para escalar  
Soporte multiplataforma: **Android / iOS / Web / Desktop**  
Backend incluido en la carpeta `/backend`

---

## Estructura del proyecto

```bash
chat_app/
│── lib/                # Código principal Flutter
│── android/            # Configuración Android
│── ios/                # Configuración iOS
│── web/                # Flutter Web
│── windows/            # Desktop Windows
│── macos/              # Desktop macOS
│── linux/              # Desktop Linux
│── backend/            # Backend (API / Socket / DB)
│── pubspec.yaml        # Dependencias Flutter
│── README.md
```

---

## Requisitos

- Flutter SDK instalado (recomendado la versión estable)
- Dart
- Android Studio / Xcode / Chrome (según plataforma)
- (Opcional) Backend: Node.js / Python / etc. dependiendo del stack

---

## Instalación

### 1Clonar repositorio

```bash
git clone https://github.com/omarbermejo/chat_app.git
cd chat_app
```

### Instalar dependencias Flutter

```bash
flutter pub get
```

### Ejecutar la app

#### Android / iOS

```bash
flutter run
```

#### Web

```bash
flutter run -d chrome
```

#### Desktop (ejemplo Windows)

```bash
flutter run -d windows
```

---

## Backend

El backend se encuentra en:

```bash
/backend
```

### Iniciar backend (placeholder)

> Ajusta este bloque dependiendo de tu backend real.

Ejemplo (Node.js):
```bash
cd backend
npm install
npm run dev
```

Ejemplo (Python):
```bash
cd backend
pip install -r requirements.txt
python main.py
```

---

## Variables de entorno

Si usas credenciales/API keys, se recomienda:

- Crear archivo `.env`
- Agregarlo a `.gitignore`
- Proveer `.env.example`

Ejemplo `.env.example`:

```env
API_URL=http://localhost:3000
SOCKET_URL=http://localhost:3000
```

---

## Tests

```bash
flutter test
```

---

## Build / Release

### Android APK

```bash
flutter build apk
```

### Web build

```bash
flutter build web
```

---

## Tecnologías

- Flutter
- Dart
- Backend (según implementación)
- WebSockets / REST (si aplica)

---

## Roadmap (ideas)

- [ ] Login / Registro
- [ ] Chats 1:1 y grupos
- [ ] Emojis / stickers
- [ ] Envío de imágenes / archivos
- [ ] Notificaciones push
- [ ] Historial persistente con DB

---


## Licencia

Este proyecto está bajo la licencia **MIT** (puedes cambiarla si lo deseas).

---

### Autor

**Omar Bermejo**  
GitHub: [@omarbermejo](https://github.com/omarbermejo)
