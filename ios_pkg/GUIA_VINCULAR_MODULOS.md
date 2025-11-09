# 🔧 Guia: Como Vincular Módulos Supabase ao Target

## ⚠️ Problema

Os erros "Unable to find module dependency: 'Auth'" e "Unable to find module dependency: 'PostgREST'" indicam que os módulos do pacote Supabase não estão vinculados ao target "FitSenior".

## ✅ Solução Passo a Passo

### Passo 1: Verificar se o Pacote Está Adicionado

1. No Xcode, selecione o projeto "FitSenior" (ícone azul no topo do navegador de arquivos)
2. Selecione o target "FitSenior" (não o projeto, mas o target dentro dele)
3. Vá na aba **"Package Dependencies"** (ou "General" se não aparecer)
4. Você deve ver "supabase-swift" listado

### Passo 2: Vincular os Módulos ao Target

**Opção A: Via "Frameworks, Libraries, and Embedded Content"**

1. Com o target "FitSenior" selecionado, vá na aba **"General"**
2. Role até a seção **"Frameworks, Libraries, and Embedded Content"**
3. Clique no botão **"+"** (adicionar)
4. Você verá uma lista com os módulos disponíveis
5. Adicione cada um dos seguintes módulos:
   - ✅ **Auth**
   - ✅ **Functions**
   - ✅ **PostgREST**
   - ✅ **Realtime**
   - ✅ **Storage**
6. Para cada módulo adicionado, certifique-se de que está configurado como **"Do Not Embed"**

**Opção B: Via "Build Phases"**

1. Com o target "FitSenior" selecionado, vá na aba **"Build Phases"**
2. Expanda a seção **"Link Binary With Libraries"**
3. Clique no botão **"+"** (adicionar)
4. Adicione os seguintes frameworks:
   - ✅ **Auth.framework** (ou Auth)
   - ✅ **Functions.framework** (ou Functions)
   - ✅ **PostgREST.framework** (ou PostgREST)
   - ✅ **Realtime.framework** (ou Realtime)
   - ✅ **Storage.framework** (ou Storage)

### Passo 3: Verificar "Package Product Dependencies"

1. Ainda na aba "Build Phases"
2. Procure por uma seção chamada **"Package Product Dependencies"** (pode estar no final)
3. Certifique-se de que todos os módulos estão listados:
   - Auth
   - Functions
   - PostgREST
   - Realtime
   - Storage

### Passo 4: Limpar e Recompilar

1. **Limpe o build**: `Product > Clean Build Folder` (ou `Shift + ⌘ + K`)
2. **Feche o Xcode completamente** (⌘ + Q)
3. **Limpe o cache** (no Terminal):
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData/*
   ```
4. **Reabra o Xcode** e o projeto
5. **Resolva as dependências**: `File > Packages > Resolve Package Versions`
6. **Compile novamente**: `Product > Build` (ou `⌘ + B`)

## 🔍 Verificação

Após seguir os passos acima, verifique:

1. **No navegador de arquivos do Xcode**:
   - Expanda "Package Dependencies"
   - Expanda "supabase-swift"
   - Você deve ver todos os módulos listados

2. **No código**:
   - Os erros de "Unable to find module dependency" devem desaparecer
   - O código deve compilar sem erros relacionados aos módulos

## ⚠️ Se Ainda Não Funcionar

### Remover e Re-adicionar o Pacote

1. No Xcode, selecione o projeto "FitSenior"
2. Vá em "Package Dependencies"
3. Remova o pacote "supabase-swift" (clique com botão direito > Remove)
4. Adicione novamente:
   - `File > Add Package Dependencies...`
   - URL: `https://github.com/supabase/supabase-swift`
   - Versão: `Up to Next Major Version` com `2.5.1`
   - **IMPORTANTE**: Ao adicionar, certifique-se de selecionar **todos os produtos** e vinculá-los ao target "FitSenior"

### Verificar Versão do Xcode

Certifique-se de que está usando uma versão recente do Xcode (15.0 ou superior). Versões antigas podem ter problemas com Swift Package Manager.

## 📝 Notas

- Os módulos devem aparecer como "Do Not Embed" em "Frameworks, Libraries, and Embedded Content"
- Não é necessário adicionar os módulos em "Embed Frameworks"
- O Swift Package Manager gerencia automaticamente as dependências

## ✅ Checklist Final

- [ ] Pacote supabase-swift adicionado ao projeto
- [ ] Todos os 5 módulos (Auth, Functions, PostgREST, Realtime, Storage) vinculados ao target
- [ ] Módulos aparecem em "Frameworks, Libraries, and Embedded Content"
- [ ] Build limpo e cache limpo
- [ ] Dependências resolvidas
- [ ] Projeto compila sem erros de módulo

