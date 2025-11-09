# Como Obter as Credenciais do Supabase

Guia passo a passo para encontrar sua URL e chave de API no dashboard do Supabase.

## 📍 Passo a Passo

### 1. Acesse o Dashboard do Supabase

Você já está logado! No dashboard, você verá seu projeto "lucena564's Project".

### 2. Vá para Settings (Configurações)

1. No menu lateral esquerdo, procure pelo ícone de **engrenagem** ⚙️
2. Clique em **Settings** (Configurações)

### 3. Acesse a Seção API

1. No menu lateral dentro de Settings, clique em **API**
2. Você verá uma página com várias informações sobre sua API

### 4. Encontre as Credenciais

Na página de API, você encontrará:

#### **Project URL** (URL do Projeto)
- Está na seção **Project URL**
- Formato: `https://xxxxxxxxxxxxx.supabase.co`
- **Esta é sua `supabaseURL`**

#### **anon public key** (Chave Pública Anônima)
- Está na seção **Project API keys**
- Procure por **`anon` `public`**
- É uma string longa que começa com `eyJ...`
- **Esta é sua `supabaseKey`**

### 5. Copiar as Credenciais

1. Clique no ícone de **copiar** ao lado de cada credencial
2. Ou selecione e copie manualmente (Cmd+C)

## 🔧 Como Configurar no Código

### Opção 1: Direto no SupabaseClient.swift

Abra o arquivo `FitSenior/Services/SupabaseClient.swift` e substitua:

```swift
self.supabaseURL = "SUA_SUPABASE_URL_AQUI"
self.supabaseKey = "SUA_SUPABASE_ANON_KEY_AQUI"
```

Por:

```swift
self.supabaseURL = "https://seu-projeto.supabase.co"  // Cole a URL aqui
self.supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."  // Cole a chave aqui
```

### Opção 2: Usar Config.swift (Recomendado)

1. Crie um novo arquivo: `FitSenior/Config.swift`
2. Copie o conteúdo de `Config.example.swift`
3. Preencha com suas credenciais:

```swift
import Foundation

struct Config {
    static let supabaseURL = "https://seu-projeto.supabase.co"
    static let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

4. Atualize o `SupabaseClient.swift` para usar:

```swift
self.supabaseURL = Config.supabaseURL
self.supabaseKey = Config.supabaseKey
```

## 📸 Localização Visual no Dashboard

No dashboard do Supabase, as credenciais estão em:

```
Dashboard
  └── Settings (⚙️ no menu lateral)
      └── API (no submenu)
          ├── Project URL ← Aqui está a URL
          └── Project API keys
              └── anon public ← Aqui está a chave
```

## ⚠️ Importante

### Segurança

- **NUNCA** commite essas credenciais no Git
- A chave `anon public` é segura para usar no cliente (app iOS)
- Não compartilhe essas credenciais publicamente

### Diferença entre as Chaves

- **`anon public`**: Use esta no app iOS (segura para cliente)
- **`service_role`**: NUNCA use no app (apenas no servidor)

## ✅ Verificação

Após configurar, você pode testar:

1. Compile o projeto (Cmd+B)
2. Execute no simulador (Cmd+R)
3. Verifique se não há erros de conexão

## 🐛 Problemas Comuns

### "Invalid API key"
- Verifique se copiou a chave completa (é muito longa)
- Certifique-se de que não há espaços extras
- Use a chave `anon public`, não a `service_role`

### "Invalid URL"
- Verifique se a URL começa com `https://`
- Certifique-se de que não há espaços
- A URL deve terminar com `.supabase.co`

## 📞 Precisa de Ajuda?

Se não conseguir encontrar as credenciais:

1. Verifique se está no projeto correto
2. Certifique-se de que está em **Settings > API**
3. Procure por "Project URL" e "anon public" na página

