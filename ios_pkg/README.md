# FitSênior iOS App

Aplicativo iOS nativo desenvolvido em Swift/SwiftUI para conectar idosos a profissionais de educação física.

## 📋 Índice

- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Como Rodar](#como-rodar)
- [Como Testar no iPhone](#como-testar-no-iphone)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Documentação Adicional](#documentação-adicional)

## 🔧 Requisitos

### Software Necessário

- **macOS** 13.0 ou superior
- **Xcode** 15.0 ou superior
- **iOS SDK** 17.0 ou superior
- **Swift** 5.9 ou superior

### Hardware Necessário (para testar no dispositivo)

- iPhone ou iPad com iOS 17.0 ou superior
- Cabo USB-C ou Lightning (dependendo do dispositivo)
- Conta Apple Developer (gratuita para desenvolvimento, paga para distribuição)

## 📦 Instalação

### 1. Clonar/Obter o Projeto

Se você já tem o projeto na pasta `ios_pkg`, pule para o próximo passo.

### 2. Abrir no Xcode

1. Abra o Xcode
2. Vá em `File > Open`
3. Navegue até a pasta `ios_pkg`
4. Selecione o arquivo `FitSenior.xcodeproj`
5. Clique em `Open`

### 3. Instalar Dependências

O projeto usa o Supabase Swift SDK. As dependências são gerenciadas pelo Swift Package Manager do Xcode.

1. No Xcode, vá em `File > Add Package Dependencies...`
2. Cole a URL: `https://github.com/supabase/supabase-swift`
3. Selecione a versão `2.0.0` ou superior
4. Certifique-se de que o pacote está adicionado ao target `FitSenior`
5. Clique em `Add Package`

**Nota:** Este é um projeto Xcode tradicional (.xcodeproj), não um Swift Package. As dependências são gerenciadas diretamente pelo Xcode.

## ⚙️ Configuração

### 1. Configurar Credenciais do Supabase

Antes de rodar o app, você precisa configurar suas credenciais do Supabase:

1. Abra o arquivo `FitSenior/Services/SupabaseClient.swift`
2. Substitua os valores:

```swift
private let supabaseURL = "SUA_SUPABASE_URL_AQUI"
private let supabaseKey = "SUA_SUPABASE_ANON_KEY_AQUI"
```

**Onde encontrar essas credenciais:**
- Acesse seu projeto no [Supabase Dashboard](https://app.supabase.com)
- Vá em `Settings > API`
- Copie a `URL` e a `anon public` key

### 2. Configurar Bundle Identifier

1. No Xcode, selecione o projeto no navegador
2. Selecione o target `FitSenior`
3. Vá na aba `Signing & Capabilities`
4. Altere o `Bundle Identifier` para algo único (ex: `com.seunome.fitsenior`)
5. Selecione seu `Team` (sua conta Apple Developer)

### 3. Configurar Permissões (se necessário)

O app pode precisar de permissões para:
- **Internet**: Já configurado no `Info.plist`
- **Localização**: Se você quiser usar localização para buscar aulas próximas

## 🚀 Como Rodar

### No Simulador iOS

1. No Xcode, selecione um simulador no menu de dispositivos (topo da tela)
2. Pressione `Cmd + R` ou clique no botão ▶️ (Play)
3. O app será compilado e aberto no simulador

### No Dispositivo Físico

Veja a seção [Como Testar no iPhone](#como-testar-no-iphone) abaixo.

## 📱 Como Testar no iPhone

### Método 1: Via Xcode (Recomendado)

#### Passo 1: Conectar o iPhone

1. Conecte seu iPhone ao Mac usando o cabo USB
2. No iPhone, desbloqueie a tela e confie no computador (se solicitado)

#### Passo 2: Configurar o iPhone para Desenvolvimento

1. No iPhone, vá em `Configurações > Geral > Gerenciamento de VPN e Dispositivo`
2. Toque no perfil do seu Mac (se aparecer)
3. Toque em `Confiar`

#### Passo 3: Selecionar o Dispositivo no Xcode

1. No Xcode, no menu de dispositivos (topo), selecione seu iPhone
2. Se aparecer um aviso sobre "Untrusted Developer", vá no iPhone em `Configurações > Geral > Gerenciamento de VPN e Dispositivo` e confie no desenvolvedor

#### Passo 4: Compilar e Instalar

1. Pressione `Cmd + R` ou clique no botão ▶️
2. O Xcode irá compilar e instalar o app no seu iPhone
3. No iPhone, o app aparecerá na tela inicial

**Nota:** Na primeira vez, você precisará ir em `Configurações > Geral > Gerenciamento de VPN e Dispositivo` e confiar no desenvolvedor.

### Método 2: Via TestFlight (Para Distribuição)

1. Crie um arquivo `.ipa` (veja [GUIA_DISTRIBUICAO.md](GUIA_DISTRIBUICAO.md))
2. Faça upload para o TestFlight
3. Convide testadores

### Método 3: Via Ad Hoc Distribution

Veja [GUIA_DISTRIBUICAO.md](GUIA_DISTRIBUICAO.md) para mais detalhes.

## 📁 Estrutura do Projeto

```
FitSenior/
├── Models/              # Modelos de dados
│   ├── User.swift
│   ├── Professional.swift
│   ├── Class.swift
│   ├── Demand.swift
│   ├── Enrollment.swift
│   ├── Attendance.swift
│   ├── ForumMessage.swift
│   └── Payment.swift
├── Services/            # Serviços e lógica de negócio
│   ├── SupabaseClient.swift
│   ├── AuthService.swift
│   └── DatabaseService.swift
├── Views/               # Telas do app
│   ├── AuthView.swift
│   ├── HomeView.swift
│   ├── DashboardView.swift
│   ├── SearchClassesView.swift
│   ├── CreateClassView.swift
│   ├── ClassManagementView.swift
│   ├── ProfessionalRegistrationView.swift
│   └── FinancialView.swift
├── Components/          # Componentes reutilizáveis
│   ├── CardView.swift
│   ├── ButtonView.swift
│   └── InputView.swift
├── FitSeniorApp.swift   # Ponto de entrada do app
├── ContentView.swift    # View principal
└── Info.plist          # Configurações do app
```

## 📚 Documentação Adicional

- [GUIA_CONFIGURACAO.md](GUIA_CONFIGURACAO.md) - Configuração detalhada
- [GUIA_TESTES.md](GUIA_TESTES.md) - Como testar o app
- [GUIA_DISTRIBUICAO.md](GUIA_DISTRIBUICAO.md) - Como distribuir o app
- [ARQUITETURA.md](ARQUITETURA.md) - Arquitetura do código
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Solução de problemas

## 🐛 Problemas Comuns

### Erro de Compilação

- Verifique se todas as dependências foram instaladas
- Limpe o build: `Product > Clean Build Folder` (Cmd + Shift + K)
- Reconstrua: `Product > Build` (Cmd + B)

### App não abre no iPhone

- Verifique se você confiou no desenvolvedor nas configurações do iPhone
- Verifique se o Bundle Identifier está correto
- Verifique se o certificado de desenvolvimento está válido

### Erro de Conexão com Supabase

- Verifique se as credenciais estão corretas em `SupabaseClient.swift`
- Verifique sua conexão com a internet
- Verifique se o projeto Supabase está ativo

## 📞 Suporte

Para mais ajuda, consulte:
- [Documentação do Supabase Swift](https://github.com/supabase/supabase-swift)
- [Documentação do SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [Fórum da Apple Developer](https://developer.apple.com/forums/)

## 📄 Licença

Este projeto é parte do FitSênior. Todos os direitos reservados.

