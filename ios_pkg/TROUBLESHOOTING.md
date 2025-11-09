# Troubleshooting - FitSênior iOS

Este guia ajuda a resolver problemas comuns ao desenvolver e executar o app FitSênior.

## 🔧 Problemas de Compilação

### Erro: "No such module 'Supabase'"

**Causa:** Dependência não instalada ou não encontrada.

**Solução:**
1. No Xcode, vá em `File > Add Package Dependencies...`
2. Adicione: `https://github.com/supabase/supabase-swift`
3. Certifique-se de que o pacote está selecionado no target
4. Limpe o build: `Product > Clean Build Folder` (Cmd + Shift + K)
5. Reconstrua: `Product > Build` (Cmd + B)

### Erro: "Cannot find type 'X' in scope"

**Causa:** Arquivo não está incluído no target ou import faltando.

**Solução:**
1. Verifique se o arquivo está no target `FitSenior`
2. No File Inspector (lado direito), marque o target
3. Adicione imports necessários no topo do arquivo
4. Limpe e reconstrua o projeto

### Erro: "Use of unresolved identifier"

**Causa:** Variável ou função não definida.

**Solução:**
1. Verifique se a variável/função existe
2. Verifique o escopo (pode estar em outro arquivo)
3. Verifique se há typos no nome
4. Certifique-se de que está acessível (public/internal)

## 🔐 Problemas de Autenticação

### Erro: "Invalid API key" ou "Invalid URL"

**Causa:** Credenciais do Supabase incorretas.

**Solução:**
1. Abra `FitSenior/Services/SupabaseClient.swift`
2. Verifique se `supabaseURL` e `supabaseKey` estão corretos
3. Obtenha as credenciais corretas no [Supabase Dashboard](https://app.supabase.com)
4. Certifique-se de que não há espaços extras

### Erro: "Network request failed"

**Causa:** Problema de conexão ou configuração.

**Solução:**
1. Verifique sua conexão com a internet
2. Verifique se o projeto Supabase está ativo
3. Verifique se a URL está correta (deve começar com `https://`)
4. Verifique configurações de firewall/proxy

### Login não funciona

**Causa:** Várias possíveis.

**Solução:**
1. Verifique se o email/senha estão corretos
2. Verifique se o usuário existe no Supabase
3. Verifique logs no console do Xcode
4. Verifique se a autenticação está habilitada no Supabase
5. Teste criar um novo usuário

## 📱 Problemas no Dispositivo

### App não instala no iPhone

**Causa:** Certificado ou perfil de provisionamento inválido.

**Solução:**
1. Verifique se você confiou no desenvolvedor:
   - `Configurações > Geral > Gerenciamento de VPN e Dispositivo`
2. Verifique o Bundle Identifier:
   - Deve ser único
   - Deve corresponder ao perfil de provisionamento
3. Limpe e reconstrua:
   - `Product > Clean Build Folder`
   - `Product > Build`
4. Reconecte o dispositivo

### App abre mas fecha imediatamente (crash)

**Causa:** Erro em tempo de execução.

**Solução:**
1. Abra o Console do Xcode
2. Veja a mensagem de erro
3. Verifique se todas as dependências estão instaladas
4. Verifique se as credenciais do Supabase estão configuradas
5. Verifique logs de crash no Xcode

### "Untrusted Developer" no iPhone

**Causa:** Dispositivo não confia no certificado.

**Solução:**
1. No iPhone, vá em `Configurações > Geral > Gerenciamento de VPN e Dispositivo`
2. Toque no perfil do desenvolvedor
3. Toque em **Confiar**
4. Digite sua senha se solicitado

## 🗄️ Problemas com Banco de Dados

### Erro: "Table does not exist"

**Causa:** Tabela não criada no Supabase.

**Solução:**
1. Acesse o Supabase Dashboard
2. Vá em **SQL Editor**
3. Execute as migrações do projeto original
4. Verifique se as tabelas foram criadas em **Table Editor**

### Erro: "Row Level Security" bloqueando acesso

**Causa:** Políticas RLS muito restritivas.

**Solução:**
1. No Supabase, vá em **Authentication > Policies**
2. Verifique as políticas RLS
3. Ajuste conforme necessário
4. Ou desabilite RLS temporariamente para testes (não recomendado em produção)

### Dados não aparecem

**Causa:** Query incorreta ou sem dados.

**Solução:**
1. Verifique se há dados no banco (via Supabase Dashboard)
2. Verifique a query no código
3. Adicione logs para debug:
   ```swift
   print("Data received: \(data)")
   ```
4. Verifique filtros na query

## 🎨 Problemas de UI

### View não atualiza

**Causa:** Estado não está sendo observado corretamente.

**Solução:**
1. Certifique-se de que está usando `@StateObject` ou `@ObservedObject`
2. Verifique se a propriedade é `@Published`
3. Certifique-se de atualizar no thread principal:
   ```swift
   await MainActor.run {
       self.data = newData
   }
   ```

### Layout quebrado

**Causa:** Constraints ou tamanhos incorretos.

**Solução:**
1. Use Preview no Xcode para visualizar
2. Teste em diferentes tamanhos de tela
3. Verifique se há elementos com tamanhos fixos
4. Use `Spacer()` e `frame()` adequadamente

### Navegação não funciona

**Causa:** NavigationLink ou NavigationView incorreto.

**Solução:**
1. Certifique-se de que está dentro de um `NavigationView`
2. Verifique se o destino existe
3. Verifique se há loops de navegação
4. Use `NavigationStack` (iOS 16+) ou `NavigationView` (iOS anterior)

## ⚡ Problemas de Performance

### App lento

**Causa:** Operações pesadas no thread principal.

**Solução:**
1. Use `async/await` para operações de rede
2. Use `Task` para operações assíncronas
3. Evite operações pesadas no `body` da view
4. Use `@MainActor` apenas quando necessário

### Alto uso de memória

**Causa:** Retenção de objetos ou vazamentos.

**Solução:**
1. Use Instruments para identificar vazamentos
2. Verifique se há referências circulares
3. Use `weak` para referências opcionais
4. Limpe recursos quando não precisar mais

## 🔍 Debugging

### Como ver logs

1. Abra o Xcode
2. Execute o app
3. Abra a aba **Console** (parte inferior)
4. Veja mensagens de `print()` e erros

### Como adicionar breakpoints

1. Clique na margem esquerda do editor (ao lado do número da linha)
2. Um breakpoint azul aparecerá
3. Quando o código chegar nesse ponto, a execução pausa
4. Você pode inspecionar variáveis e executar passo a passo

### Como usar Instruments

1. No Xcode, vá em `Product > Profile` (Cmd + I)
2. Selecione um template (ex: **Time Profiler**, **Leaks**)
3. Execute o app
4. Analise os dados coletados

## 📋 Checklist de Troubleshooting

Antes de pedir ajuda, verifique:

- [ ] Limpei o build (`Cmd + Shift + K`)
- [ ] Reconstruí o projeto (`Cmd + B`)
- [ ] Verifiquei as credenciais do Supabase
- [ ] Verifiquei a conexão com a internet
- [ ] Verifiquei os logs do console
- [ ] Verifiquei se as dependências estão instaladas
- [ ] Verifiquei se o target está correto
- [ ] Verifiquei se o Bundle Identifier está correto
- [ ] Verifiquei se o certificado está válido
- [ ] Testei em simulador e dispositivo

## 🆘 Ainda com Problemas?

### Recursos de Ajuda

1. **Documentação Oficial:**
   - [SwiftUI Docs](https://developer.apple.com/documentation/swiftui/)
   - [Supabase Swift Docs](https://github.com/supabase/supabase-swift)

2. **Fóruns:**
   - [Stack Overflow](https://stackoverflow.com/questions/tagged/swiftui)
   - [Apple Developer Forums](https://developer.apple.com/forums/)

3. **Comunidade:**
   - [Swift Forums](https://forums.swift.org/)
   - [r/SwiftUI](https://www.reddit.com/r/SwiftUI/)

### Informações para Reportar Problemas

Ao pedir ajuda, inclua:

1. **Descrição do problema**: O que acontece?
2. **Passos para reproduzir**: Como fazer o problema acontecer?
3. **Resultado esperado**: O que deveria acontecer?
4. **Resultado real**: O que realmente acontece?
5. **Código relevante**: Trechos de código relacionados
6. **Logs/Erros**: Mensagens de erro completas
7. **Ambiente**:
   - Versão do Xcode
   - Versão do iOS
   - Dispositivo/Simulador
   - Versão do macOS

## 🔄 Reset Completo

Se nada funcionar, tente resetar:

1. **Limpar Derived Data:**
   - `Xcode > Settings > Locations`
   - Clique na seta ao lado de "Derived Data"
   - Delete a pasta do projeto

2. **Reinstalar Dependências:**
   - Remova os pacotes
   - Adicione novamente

3. **Recriar Certificados:**
   - No Apple Developer, revogue certificados antigos
   - Deixe o Xcode criar novos

4. **Recriar Perfis:**
   - Delete perfis antigos
   - Crie novos

## ✅ Problemas Resolvidos

Se você resolveu um problema, considere:

1. Documentar a solução
2. Adicionar ao troubleshooting
3. Compartilhar com a comunidade

