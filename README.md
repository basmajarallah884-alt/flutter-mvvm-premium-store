# Flutter Premium E-Commerce Store

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)

A sophisticated, high-performance cross-platform e-commerce solution built with **Flutter**, demonstrating industry-standard design patterns, robust architectural choices, and a seamless user experience. Designed for scalability and maintainability, this project showcases a clean implementation of the **MVVM (Model-View-ViewModel)** architecture.

---

## 🏗️ Architecture & Design Patterns

### 🏛️ MVVM (Model-View-ViewModel)
The project adheres to a strict separation of concerns, ensuring high testability and modularity:
- **Model**: Immutable data structures representing business entities (Products, Categories, Users).
- **View**: A declarative UI layer built with Flutter's widget tree, kept thin and decoupled from business logic.
- **ViewModel**: Powered by the **Provider** state management pattern, acting as a reactive bridge between UI and data services.
- **Services**: Abstracted data access layers handling networking (REST API) and local persistence.

### 🔌 Networking & API Integration
Utilizing the **Dio** package for robust asynchronous networking:
- Centralized `ApiService` with configurable base options (timeouts, base URLs).
- Efficient JSON parsing and mapping to Dart objects.
- Error handling strategies for resilient connectivity.

---

## 💾 Data Persistence Strategy

The application implements an **Offline-First capable** approach using a hybrid storage model:
- **SQLite (sqflite)**: Used for managing relational data such as cart Items and product caching, ensuring a persistent shopping experience.
- **Shared Preferences**: Leveraged for lightweight storage of user sessions, tokens, and preference flags.

---

## 🚀 Key Features

- **🔐 Secure Authentication**: Integrated login flow with stateful session management.
- **🛍️ Intelligent Product Catalog**: Efficient fetching and categorization using external APIs (DummyJSON).
- **🛒 Persistent Cart System**: Local database storage for car persistency across app restarts.
- **📱 Responsive UI**: A premium, Material 3-inspired design that adapts to various screen dimensions.
- **⚡ Performance Optimized**: Optimized image loading and state rebuilding strategies to maintain 60FPS.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **HTTP Client**: [Dio](https://pub.dev/packages/dio)
- **Local Database**: [Sqflite](https://pub.dev/packages/sqflite)
- **Backend API**: [DummyJSON](https://dummyjson.com)

---

## 🇸🇦 وصف احترافي بالعربية (Professional Description in Arabic)

تطبيق متجر إلكتروني متكامل تم تطويره باستخدام إطار العمل **Flutter**، مع تبني أفضل الممارسات الهندسية والمعايير المعتمدة في كبرى الشركات التقنية مثل **جاوجل**. 

### **أبرز الجوانب التقنية للمشروع:**
1. **هندسة البرمجيات (Architecture):** تم اعتماد نمط **MVVM** لضمان فصل منطق الأعمال عن واجهة المستخدم، مما يسهل عملية الصيانة والاختبار (Testing).
2. **إدارة الحالة (State Management):** استخدام حزمة **Provider** لإدارة بيانات التطبيق بكفاءة عالية وبشكل تفاعلي (Reactive).
3. **التعامل مع البيانات:** 
   - الربط مع واجهات برمجية **REST API** باستخدام حزمة **Dio** المتطورة.
   - بناء قاعدة بيانات محلية باستخدام **SQLite** لحفظ بيانات السلة وضمان استمرارية العمل حتى في حالات ضعف الاتصال.
4. **التصميم (Design):** واجهة مستخدم حديثة تتبع معايير **Material 3**، مع التركيز التام على تجربة المستخدم (UX) واستجابة الواجهات لمختلف أحجام الشاشات.
5. **إدارة المهام غير المتزامنة:** التعامل الاحترافي مع الـ **Futures** والـ **Streams** لضمان سلاسة التطبيق وعدم تجميد واجهة المستخدم أثناء جلب البيانات.

هذا المشروع يمثل نموذجاً برمجياً قوياً يجمع بين الأداء العالي، الكود النظيف (Clean Code)، والقابلية للتوسع المستقبلي.

---

## 👨‍💻 Author
**[Your Name/Basma Jarallah as per context]**  
*Flutter & Mobile Software Engineer*
