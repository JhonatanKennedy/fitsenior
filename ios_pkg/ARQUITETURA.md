# Arquitetura do Código - FitSênior iOS

Este documento explica a arquitetura e estrutura do código do app FitSênior iOS.

## 🏗️ Visão Geral da Arquitetura

O app segue uma arquitetura **MVVM (Model-View-ViewModel)** com separação clara de responsabilidades:

```
┌─────────────┐
│    Views    │  ← Interface do usuário (SwiftUI)
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Services   │  ← Lógica de negócio e comunicação com API
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Models    │  ← Estruturas de dados
└─────────────┘
```

## 📁 Estrutura de Pastas

```
FitSenior/
├── Models/              # Modelos de dados (Data Models)
│   ├── User.swift
│   ├── Professional.swift
│   ├── Class.swift
│   ├── Demand.swift
│   ├── Enrollment.swift
│   ├── Attendance.swift
│   ├── ForumMessage.swift
│   └── Payment.swift
│
├── Services/            # Serviços e lógica de negócio
│   ├── SupabaseClient.swift    # Cliente Supabase
│   ├── AuthService.swift       # Autenticação
│   └── DatabaseService.swift   # Operações de banco de dados
│
├── Views/               # Telas do app (SwiftUI Views)
│   ├── AuthView.swift
│   ├── HomeView.swift
│   ├── DashboardView.swift
│   ├── SearchClassesView.swift
│   ├── CreateClassView.swift
│   ├── ClassManagementView.swift
│   ├── ProfessionalRegistrationView.swift
│   └── FinancialView.swift
│
├── Components/         # Componentes reutilizáveis
│   ├── CardView.swift
│   ├── ButtonView.swift
│   └── InputView.swift
│
├── FitSeniorApp.swift   # Ponto de entrada do app
├── ContentView.swift  # View principal (rota inicial)
└── Info.plist          # Configurações do app
```

## 🧩 Componentes Principais

### 1. Models (Modelos de Dados)

Os models representam as estruturas de dados do app. Eles são:

- **Codable**: Podem ser serializados/deserializados para JSON
- **Identifiable**: Têm um ID único (para uso em listas SwiftUI)
- **Estruturados**: Seguem a estrutura do banco de dados Supabase

**Exemplo:**

```swift
struct Class: Codable, Identifiable {
    let id: String
    let professionalId: String
    let activity: String
    // ...
}
```

**Responsabilidades:**
- Definir estrutura de dados
- Mapear entre JSON e objetos Swift
- Garantir type safety

### 2. Services (Serviços)

Os services contêm a lógica de negócio e comunicação com APIs externas.

#### SupabaseClient

- Gerencia a conexão com Supabase
- Singleton pattern (uma única instância)
- Configuração centralizada

#### AuthService

- Gerencia autenticação de usuários
- ObservableObject (para atualizar UI)
- Métodos: signIn, signUp, signOut, checkAuthState

#### DatabaseService

- Operações CRUD no banco de dados
- Queries para diferentes tabelas
- Tratamento de erros

**Padrão usado:**
- Singleton para acesso global
- Async/await para operações assíncronas
- ObservableObject para reatividade

### 3. Views (Telas)

As views são as interfaces do usuário construídas com SwiftUI.

**Características:**
- Declarativas (descrevem o que mostrar, não como)
- Reativas (atualizam automaticamente quando dados mudam)
- Composable (podem ser combinadas)

**Estrutura típica:**

```swift
struct MyView: View {
    @StateObject private var service = Service.shared
    @State private var data: [Item] = []
    
    var body: some View {
        // UI aqui
    }
}
```

**Property Wrappers usados:**
- `@State`: Estado local da view
- `@StateObject`: Objeto observável (geralmente services)
- `@EnvironmentObject`: Objeto compartilhado entre views
- `@Binding`: Binding bidirecional

### 4. Components (Componentes)

Componentes reutilizáveis que podem ser usados em múltiplas views.

**Exemplos:**
- `CardView`: Card genérico com estilo consistente
- `PrimaryButton`: Botão primário padronizado
- `TextInput`: Campo de texto com label

**Vantagens:**
- Consistência visual
- Reutilização de código
- Manutenção facilitada

## 🔄 Fluxo de Dados

### Autenticação

```
User Input (AuthView)
    ↓
AuthService.signIn()
    ↓
SupabaseClient
    ↓
Supabase API
    ↓
Response
    ↓
AuthService atualiza @Published properties
    ↓
Views atualizam automaticamente (SwiftUI)
```

### Carregamento de Dados

```
View aparece
    ↓
.task { await loadData() }
    ↓
DatabaseService.getClasses()
    ↓
SupabaseClient query
    ↓
Response → Models
    ↓
@State atualizado
    ↓
View re-renderiza
```

## 🎨 Padrões de Design

### 1. Singleton Pattern

Usado em Services para garantir uma única instância:

```swift
class AuthService: ObservableObject {
    static let shared = AuthService()
    private init() {}
}
```

### 2. Observable Pattern

Services são `ObservableObject` para atualizar UI automaticamente:

```swift
@Published var isAuthenticated = false
```

### 3. Dependency Injection

Services são injetados via `@StateObject` ou `@EnvironmentObject`:

```swift
@StateObject private var authService = AuthService.shared
```

### 4. Async/Await

Operações assíncronas usam async/await:

```swift
func loadData() async {
    let data = try await dbService.getClasses()
    // ...
}
```

## 🔐 Gerenciamento de Estado

### Estado Global

- `AuthService`: Estado de autenticação
- Compartilhado via `@EnvironmentObject`

### Estado Local

- `@State` em views individuais
- Para dados específicos da view

### Estado Compartilhado entre Views

- `@StateObject` quando a view é dona
- `@ObservedObject` quando recebe de outra view
- `@EnvironmentObject` para estado global

## 📡 Comunicação com API

### Supabase

O app usa o Supabase como backend:

1. **Autenticação**: Via Supabase Auth
2. **Banco de Dados**: Via Supabase Postgres
3. **Real-time**: (Pode ser adicionado no futuro)

### Estrutura de Queries

```swift
let response = try await supabase
    .from("classes")
    .select()
    .eq("professional_id", value: id)
    .execute()
```

## 🎯 Princípios de Design

### 1. Separation of Concerns

- Models: Apenas dados
- Services: Lógica de negócio
- Views: Apenas UI

### 2. Single Responsibility

Cada classe/struct tem uma responsabilidade única.

### 3. DRY (Don't Repeat Yourself)

Componentes reutilizáveis evitam duplicação.

### 4. Type Safety

Swift garante type safety em tempo de compilação.

## 🚀 Melhorias Futuras

### Possíveis Adições

1. **Repository Pattern**: Camada adicional entre Services e API
2. **ViewModels**: Separar lógica de apresentação das Views
3. **Dependency Injection Container**: Para melhor gerenciamento de dependências
4. **Error Handling**: Sistema centralizado de tratamento de erros
5. **Caching**: Cache local para melhor performance
6. **Offline Support**: Funcionalidade offline

## 📚 Recursos de Aprendizado

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [MVVM Pattern](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)
- [Async/Await](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [Combine Framework](https://developer.apple.com/documentation/combine)

## 🔍 Debugging

### Ferramentas

1. **Xcode Debugger**: Breakpoints, inspeção de variáveis
2. **Console Logs**: `print()` ou `os.log`
3. **Instruments**: Profiling de performance
4. **SwiftUI Previews**: Visualização rápida de views

### Boas Práticas

- Use breakpoints estratégicos
- Log informações relevantes
- Monitore uso de memória
- Teste em diferentes dispositivos

## 📝 Convenções de Código

### Nomenclatura

- **Classes**: PascalCase (ex: `AuthService`)
- **Structs**: PascalCase (ex: `User`)
- **Variáveis**: camelCase (ex: `isAuthenticated`)
- **Constantes**: camelCase ou UPPER_CASE

### Organização

- Um arquivo por classe/struct
- Agrupar por funcionalidade
- Comentários para lógica complexa

## ✅ Checklist de Qualidade

- [ ] Código segue padrões Swift
- [ ] Sem código duplicado
- [ ] Tratamento de erros adequado
- [ ] Performance otimizada
- [ ] Acessibilidade considerada
- [ ] Testes unitários (se aplicável)

