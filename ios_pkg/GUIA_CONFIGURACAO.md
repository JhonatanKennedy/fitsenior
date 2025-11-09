# Guia de Configuração Detalhada

Este guia fornece instruções passo a passo para configurar completamente o app FitSênior iOS.

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter:

1. ✅ Conta no Supabase (gratuita em [supabase.com](https://supabase.com))
2. ✅ Projeto Supabase criado e configurado
3. ✅ Xcode instalado no Mac
4. ✅ Conta Apple Developer (gratuita para desenvolvimento)

## 🔑 Passo 1: Configurar Supabase

### 1.1 Obter Credenciais do Supabase

1. Acesse [app.supabase.com](https://app.supabase.com)
2. Faça login na sua conta
3. Selecione seu projeto (ou crie um novo)
4. Vá em **Settings** (ícone de engrenagem) no menu lateral
5. Clique em **API** no submenu
6. Você verá:
   - **Project URL**: Esta é sua `supabaseURL`
   - **anon public key**: Esta é sua `supabaseKey`

### 1.2 Configurar o Cliente Supabase no App

1. Abra o arquivo `FitSenior/Services/SupabaseClient.swift` no Xcode
2. Localize as linhas:

```swift
private let supabaseURL = "SUA_SUPABASE_URL_AQUI"
private let supabaseKey = "SUA_SUPABASE_ANON_KEY_AQUI"
```

3. Substitua pelos valores reais:

```swift
private let supabaseURL = "https://seu-projeto.supabase.co"
private let supabaseKey = "sua-chave-anon-aqui"
```

**⚠️ IMPORTANTE:** Nunca commite essas credenciais em repositórios públicos!

### 1.3 Verificar Tabelas no Supabase

Certifique-se de que todas as tabelas necessárias existem no seu banco de dados:

- `profiles`
- `professionals`
- `classes`
- `demands`
- `enrollments`
- `attendance`
- `forum_messages`
- `payments`
- `user_roles`

Veja o arquivo SQL de migração no projeto original: `supabase/migrations/`

## 🍎 Passo 2: Configurar Xcode

### 2.1 Abrir o Projeto

1. Abra o Xcode
2. Vá em `File > Open`
3. Navegue até `ios_pkg/FitSenior.xcodeproj`
4. Clique em `Open`

### 2.2 Configurar Bundle Identifier

1. No navegador de arquivos do Xcode (lado esquerdo), clique no projeto `FitSenior` (ícone azul no topo)
2. Selecione o target `FitSenior` na lista
3. Vá na aba **General**
4. Em **Identity**, altere o **Bundle Identifier**:
   - Padrão: `com.fitsenior.app`
   - Recomendado: `com.seunome.fitsenior` (use algo único)

### 2.3 Configurar Signing & Capabilities

1. Na mesma aba, vá para **Signing & Capabilities**
2. Marque a opção **Automatically manage signing**
3. Selecione seu **Team** (sua conta Apple Developer)
   - Se não aparecer, clique em **Add Account...** e faça login
4. O Xcode criará automaticamente um certificado de desenvolvimento

### 2.4 Configurar Deployment Target

1. Na aba **General**, em **Deployment Info**
2. Certifique-se de que **iOS** está definido como `17.0` ou superior
3. Isso garante compatibilidade com dispositivos mais recentes

## 📦 Passo 3: Instalar Dependências

### 3.1 Adicionar Supabase Swift SDK

1. No Xcode, vá em `File > Add Package Dependencies...`
2. Cole a URL: `https://github.com/supabase/supabase-swift`
3. Clique em **Add Package**
4. Selecione a versão `2.0.0` ou superior
5. Marque o pacote **Supabase**
6. Clique em **Add Package**

### 3.2 Verificar Dependências

1. No navegador de arquivos, expanda o projeto
2. Você deve ver uma seção **Package Dependencies**
3. O Supabase deve aparecer listado

## 🔧 Passo 4: Configurar Variáveis de Ambiente (Opcional)

Para maior segurança, você pode usar variáveis de ambiente:

### 4.1 Criar Arquivo de Configuração

1. Crie um novo arquivo Swift: `FitSenior/Config.swift`
2. Adicione:

```swift
import Foundation

struct Config {
    static let supabaseURL: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String else {
            fatalError("SUPABASE_URL não encontrado no Info.plist")
        }
        return url
    }()
    
    static let supabaseKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as? String else {
            fatalError("SUPABASE_KEY não encontrado no Info.plist")
        }
        return key
    }()
}
```

### 4.2 Adicionar ao Info.plist

1. Abra `FitSenior/Info.plist`
2. Adicione as chaves:

```xml
<key>SUPABASE_URL</key>
<string>https://seu-projeto.supabase.co</string>
<key>SUPABASE_KEY</key>
<string>sua-chave-aqui</string>
```

**⚠️ IMPORTANTE:** Adicione `Info.plist` ao `.gitignore` se usar este método!

## 🎨 Passo 5: Personalizar o App (Opcional)

### 5.1 Alterar Nome do App

1. Abra `FitSenior/Info.plist`
2. Altere o valor de `CFBundleDisplayName`:

```xml
<key>CFBundleDisplayName</key>
<string>FitSênior</string>
```

### 5.2 Alterar Ícone do App

1. Adicione seus ícones em `FitSenior/Assets.xcassets/AppIcon.appiconset`
2. Ou use o Asset Catalog do Xcode para gerar automaticamente

### 5.3 Alterar Cores

1. Abra `FitSenior/Assets.xcassets`
2. Crie um novo Color Set chamado `AccentColor`
3. Defina as cores desejadas

## ✅ Passo 6: Verificar Configuração

### 6.1 Build do Projeto

1. Pressione `Cmd + B` para compilar
2. Verifique se não há erros
3. Se houver erros, consulte [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### 6.2 Testar no Simulador

1. Selecione um simulador (ex: iPhone 15 Pro)
2. Pressione `Cmd + R` para rodar
3. O app deve abrir no simulador

## 🔐 Passo 7: Configurações de Segurança

### 7.1 App Transport Security

O `Info.plist` já está configurado para permitir conexões HTTPS com Supabase. Se precisar de HTTP (não recomendado):

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### 7.2 Proteger Credenciais

**NUNCA** commite credenciais em repositórios públicos:

1. Use `.gitignore` para excluir arquivos sensíveis
2. Use variáveis de ambiente
3. Use serviços de gerenciamento de segredos (ex: AWS Secrets Manager)

## 📝 Checklist Final

Antes de começar a desenvolver, verifique:

- [ ] Credenciais do Supabase configuradas
- [ ] Bundle Identifier único configurado
- [ ] Signing & Capabilities configurado
- [ ] Dependências instaladas
- [ ] Projeto compila sem erros
- [ ] App roda no simulador
- [ ] Tabelas do banco de dados criadas no Supabase

## 🚀 Próximos Passos

Agora que está tudo configurado:

1. Leia [ARQUITETURA.md](ARQUITETURA.md) para entender o código
2. Veja [GUIA_TESTES.md](GUIA_TESTES.md) para testar o app
3. Consulte [TROUBLESHOOTING.md](TROUBLESHOOTING.md) se tiver problemas

## 📞 Ajuda

Se encontrar problemas:

1. Verifique [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
2. Consulte a documentação do [Supabase Swift](https://github.com/supabase/supabase-swift)
3. Verifique os logs do Xcode (aba Console)

