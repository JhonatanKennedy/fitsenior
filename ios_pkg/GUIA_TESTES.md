# Guia de Testes - FitSênior iOS

Este guia explica como testar o app FitSênior em diferentes cenários e dispositivos.

## 📱 Testando no Simulador iOS

### Configuração Inicial

1. Abra o Xcode
2. Selecione um simulador no menu de dispositivos (topo da tela):
   - **iPhone 15 Pro** (recomendado)
   - **iPhone 14**
   - **iPad Pro**
   - Ou qualquer outro dispositivo disponível

### Executar no Simulador

1. Pressione `Cmd + R` ou clique no botão ▶️ (Play)
2. O simulador será iniciado (se ainda não estiver aberto)
3. O app será instalado e executado automaticamente

### Vantagens do Simulador

- ✅ Rápido para desenvolvimento
- ✅ Não precisa de dispositivo físico
- ✅ Fácil de testar em diferentes tamanhos de tela
- ✅ Screenshots fáceis

### Limitações do Simulador

- ❌ Não testa recursos de hardware (câmera, GPS real, etc.)
- ❌ Performance pode diferir do dispositivo real
- ❌ Alguns recursos podem não funcionar corretamente

## 📲 Testando no iPhone/iPad Físico

### Pré-requisitos

1. **iPhone/iPad** com iOS 17.0 ou superior
2. **Cabo USB** (Lightning ou USB-C)
3. **Mac** com Xcode instalado
4. **Conta Apple Developer** (gratuita para desenvolvimento)

### Passo 1: Conectar o Dispositivo

1. Conecte o iPhone/iPad ao Mac usando o cabo USB
2. Desbloqueie o dispositivo
3. Se aparecer "Confiar neste computador?", toque em **Confiar**
4. Digite a senha do dispositivo se solicitado

### Passo 2: Configurar o Dispositivo no Xcode

1. No Xcode, no menu de dispositivos (topo), você deve ver seu iPhone/iPad
2. Se aparecer um aviso sobre "Untrusted Developer":
   - No iPhone, vá em `Configurações > Geral > Gerenciamento de VPN e Dispositivo`
   - Toque no perfil do desenvolvedor
   - Toque em **Confiar**

### Passo 3: Selecionar e Executar

1. No Xcode, selecione seu dispositivo no menu
2. Pressione `Cmd + R` ou clique em ▶️
3. O Xcode irá:
   - Compilar o app
   - Instalar no dispositivo
   - Executar automaticamente

### Primeira Instalação

Na primeira vez que instalar o app:

1. O app aparecerá na tela inicial
2. Ao tentar abrir, pode aparecer "Não é possível verificar o app"
3. Vá em `Configurações > Geral > Gerenciamento de VPN e Dispositivo`
4. Toque no desenvolvedor
5. Toque em **Confiar**
6. Tente abrir o app novamente

## 🧪 Cenários de Teste

### 1. Teste de Autenticação

**Objetivo:** Verificar se login e cadastro funcionam

**Passos:**
1. Abra o app
2. Tente fazer login com credenciais válidas
3. Tente fazer login com credenciais inválidas
4. Tente criar uma nova conta
5. Verifique se a sessão persiste após fechar o app

**Resultado Esperado:**
- Login bem-sucedido redireciona para o dashboard
- Erros são exibidos corretamente
- Sessão persiste entre aberturas do app

### 2. Teste de Navegação

**Objetivo:** Verificar se todas as telas são acessíveis

**Passos:**
1. Navegue por todas as abas
2. Teste todos os botões de navegação
3. Verifique se os botões "Voltar" funcionam
4. Teste navegação em diferentes orientações (portrait/landscape)

**Resultado Esperado:**
- Todas as telas são acessíveis
- Navegação funciona corretamente
- Botões respondem aos toques

### 3. Teste de Busca de Aulas

**Objetivo:** Verificar funcionalidade de busca

**Passos:**
1. Vá para a tela "Buscar Aulas"
2. Digite um termo de busca
3. Aplique filtros
4. Verifique se os resultados são exibidos corretamente

**Resultado Esperado:**
- Busca retorna resultados relevantes
- Filtros funcionam corretamente
- Resultados são exibidos de forma clara

### 4. Teste de Criação de Turma

**Objetivo:** Verificar se profissionais podem criar turmas

**Passos:**
1. Faça login como profissional
2. Vá para "Cadastrar Aula"
3. Preencha o formulário
4. Tente criar uma turma
5. Verifique se aparece no dashboard

**Resultado Esperado:**
- Formulário valida campos obrigatórios
- Turma é criada com sucesso
- Turma aparece no dashboard

### 5. Teste de Gerenciamento de Turma

**Objetivo:** Verificar funcionalidades de gerenciamento

**Passos:**
1. Acesse uma turma no dashboard
2. Teste a lista de chamada
3. Marque presenças
4. Teste o fórum
5. Envie mensagens

**Resultado Esperado:**
- Lista de chamada funciona
- Presenças são salvas
- Mensagens são enviadas e exibidas

### 6. Teste de Performance

**Objetivo:** Verificar se o app é responsivo

**Passos:**
1. Navegue rapidamente entre telas
2. Carregue listas grandes
3. Teste em conexão lenta (simular no Xcode)
4. Monitore uso de memória

**Resultado Esperado:**
- App responde rapidamente
- Não há travamentos
- Uso de memória é razoável

### 7. Teste de Conectividade

**Objetivo:** Verificar comportamento sem internet

**Passos:**
1. Desative Wi-Fi e dados móveis
2. Tente usar o app
3. Reative a conexão
4. Verifique se o app se recupera

**Resultado Esperado:**
- Erros de conexão são exibidos
- App não trava
- Dados são carregados quando conexão é restaurada

## 🔍 Ferramentas de Debug

### Console do Xcode

1. Abra o Xcode
2. Execute o app
3. Abra a aba **Console** (parte inferior)
4. Veja logs e mensagens de erro

### Instruments

Para análise de performance:

1. No Xcode, vá em `Product > Profile` (Cmd + I)
2. Selecione um template (ex: **Time Profiler**, **Leaks**)
3. Analise os dados

### Breakpoints

Para debugar código:

1. Clique na margem esquerda do editor para criar um breakpoint
2. Execute o app
3. Quando o breakpoint for atingido, você pode:
   - Ver valores de variáveis
   - Executar código passo a passo
   - Inspecionar o estado do app

## 📊 Checklist de Testes

Antes de considerar o app pronto, teste:

- [ ] Login e cadastro funcionam
- [ ] Todas as telas são acessíveis
- [ ] Navegação funciona corretamente
- [ ] Busca de aulas funciona
- [ ] Criação de turmas funciona
- [ ] Gerenciamento de turmas funciona
- [ ] App funciona em diferentes tamanhos de tela
- [ ] App funciona em portrait e landscape
- [ ] Erros são tratados adequadamente
- [ ] App funciona sem internet (com mensagens de erro)
- [ ] Performance é aceitável
- [ ] Não há vazamentos de memória
- [ ] App funciona em iPhone e iPad

## 🐛 Reportando Problemas

Se encontrar bugs:

1. **Descreva o problema** claramente
2. **Passos para reproduzir** o problema
3. **Resultado esperado** vs **resultado real**
4. **Dispositivo e versão do iOS** testados
5. **Screenshots** se aplicável**
6. **Logs do console** se houver erros

## 📝 Próximos Passos

Após testar:

1. Corrija bugs encontrados
2. Otimize performance se necessário
3. Prepare para distribuição (veja [GUIA_DISTRIBUICAO.md](GUIA_DISTRIBUICAO.md))
4. Considere testes automatizados (Unit Tests, UI Tests)

## 🔗 Recursos Adicionais

- [Documentação de Testes do Xcode](https://developer.apple.com/documentation/xcode/testing)
- [Guia de Instruments](https://developer.apple.com/documentation/instruments)
- [TestFlight Beta Testing](https://developer.apple.com/testflight/)

