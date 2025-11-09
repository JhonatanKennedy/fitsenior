# 🧪 Como Testar o App FitSenior

## ✅ Build Bem-Sucedido!

O projeto compila sem erros. Agora vamos testar o app.

## 🚀 Como Executar no Simulador

### Opção 1: Via Xcode (Recomendado)

1. **Abra o projeto no Xcode:**
   ```bash
   open /Users/antoniolucena/Desktop/fitsenior/ios_pkg/FitSenior.xcodeproj
   ```

2. **Selecione um simulador:**
   - No topo do Xcode, clique no dispositivo (ex: "iPhone 15 Pro")
   - Escolha um simulador iOS (ex: "iPhone 15 Pro", "iPhone 15", etc.)

3. **Execute o app:**
   - Pressione `⌘ + R` (ou clique no botão ▶️)
   - O simulador abrirá automaticamente
   - O app será instalado e executado

### Opção 2: Via Terminal

```bash
cd /Users/antoniolucena/Desktop/fitsenior/ios_pkg

# Listar simuladores disponíveis
xcrun simctl list devices available

# Executar no simulador (substitua "iPhone 15" pelo nome do simulador desejado)
xcodebuild -project FitSenior.xcodeproj -scheme FitSenior -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15' build

# Abrir o simulador
open -a Simulator

# Instalar e executar (após o build)
xcrun simctl boot "iPhone 15" 2>/dev/null || true
xcrun simctl install booted ~/Library/Developer/Xcode/DerivedData/FitSenior-*/Build/Products/Debug-iphonesimulator/FitSenior.app
xcrun simctl launch booted com.fitsenior.app
```

## 🔍 Sobre o EXC_BREAKPOINT

Se você ver o erro `EXC_BREAKPOINT` ao executar:

1. **Verifique se há breakpoints ativos:**
   - No Xcode, vá em `Debug` > `Breakpoints` > `Show Breakpoints`
   - Desative todos os breakpoints (ou pressione `⌘ + Y`)

2. **Pode ser um `fatalError`:**
   - O código tem um `fatalError` se a URL do Supabase for inválida
   - Verifique se a URL em `SupabaseClient.swift` está correta

3. **Limpe e recompile:**
   - `Product` > `Clean Build Folder` (Shift + ⌘ + K)
   - `Product` > `Build` (⌘ + B)
   - Execute novamente (⌘ + R)

## 📱 Testando Funcionalidades

### 1. Teste de Autenticação

1. Execute o app
2. Você verá a tela de login
3. Teste:
   - **Cadastro:** Clique em "Cadastrar" e crie uma conta
   - **Login:** Use as credenciais criadas para fazer login

### 2. Teste de Navegação

- Após o login, você deve ver a tela principal
- Navegue pelas diferentes telas do app

### 3. Teste de Funcionalidades

- **Cadastro de Profissional:** Teste o formulário de cadastro
- **Criação de Turma:** Teste criar uma nova turma
- **Busca de Turmas:** Teste buscar turmas disponíveis

## 🐛 Debugging

### Ver Logs no Console

1. No Xcode, abra o Console (View > Debug Area > Activate Console)
2. Execute o app
3. Os logs aparecerão no console

### Adicionar Breakpoints

1. Clique na margem esquerda do editor (ao lado do número da linha)
2. Um breakpoint azul aparecerá
3. Quando o código chegar nesse ponto, a execução pausará
4. Você pode inspecionar variáveis e valores

### Verificar Erros de Rede

Se houver problemas com chamadas ao Supabase:

1. Verifique a URL e a chave API em `SupabaseClient.swift`
2. Verifique se o Supabase está acessível
3. Veja os logs no console do Xcode para mensagens de erro

## ✅ Checklist de Teste

- [ ] App compila sem erros
- [ ] App abre no simulador
- [ ] Tela de login aparece
- [ ] Cadastro de usuário funciona
- [ ] Login funciona
- [ ] Navegação entre telas funciona
- [ ] Formulários funcionam
- [ ] Sem crashes ou erros

## 🆘 Problemas Comuns

### App não abre no simulador
- Verifique se o simulador está rodando
- Tente selecionar outro simulador
- Limpe o build e tente novamente

### Erro de conexão com Supabase
- Verifique a URL e a chave API
- Verifique sua conexão com a internet
- Verifique se o projeto Supabase está ativo

### App trava ou fecha inesperadamente
- Veja os logs no console do Xcode
- Verifique se há erros de memória
- Tente limpar o build e executar novamente

## 📝 Próximos Passos

Após testar o app básico, você pode:

1. Implementar as funcionalidades restantes
2. Adicionar validações nos formulários
3. Melhorar o tratamento de erros
4. Adicionar testes unitários
5. Preparar para distribuição

