# Guia de Distribuição - FitSênior iOS

Este guia explica como distribuir o app FitSênior para usuários finais.

## 📋 Opções de Distribuição

Existem várias formas de distribuir um app iOS:

1. **App Store** - Distribuição pública (requer conta paga)
2. **TestFlight** - Beta testing (requer conta paga)
3. **Ad Hoc** - Distribuição limitada (até 100 dispositivos)
4. **Enterprise** - Distribuição interna (requer conta Enterprise)

## 🍎 Pré-requisitos

### Para App Store e TestFlight

- ✅ Conta **Apple Developer Program** (US$ 99/ano)
- ✅ App completamente funcional e testado
- ✅ Ícone do app
- ✅ Screenshots para App Store
- ✅ Descrição do app

### Para Ad Hoc

- ✅ Conta Apple Developer (gratuita ou paga)
- ✅ Lista de UDIDs dos dispositivos (máximo 100)

## 🚀 Método 1: TestFlight (Beta Testing)

TestFlight permite distribuir o app para até 10.000 testadores antes do lançamento.

### Passo 1: Preparar o App

1. No Xcode, selecione o target `FitSenior`
2. Vá em **General**
3. Certifique-se de que:
   - **Version** está incrementado (ex: 1.0, 1.1, etc.)
   - **Build** está incrementado (ex: 1, 2, 3, etc.)

### Passo 2: Criar Archive

1. No Xcode, selecione **Any iOS Device** no menu de dispositivos
2. Vá em `Product > Archive`
3. Aguarde a compilação terminar
4. O **Organizer** será aberto automaticamente

### Passo 3: Validar o Archive

1. No Organizer, selecione seu archive
2. Clique em **Validate App**
3. Siga as instruções na tela
4. Resolva quaisquer problemas encontrados

### Passo 4: Fazer Upload para App Store Connect

1. No Organizer, selecione seu archive
2. Clique em **Distribute App**
3. Selecione **App Store Connect**
4. Clique em **Next**
5. Selecione **Upload**
6. Siga as instruções
7. Aguarde o processamento (pode levar alguns minutos)

### Passo 5: Configurar no App Store Connect

1. Acesse [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Faça login com sua conta Apple Developer
3. Vá em **My Apps**
4. Crie um novo app ou selecione um existente
5. Vá em **TestFlight**
6. Adicione testadores internos ou externos
7. Envie convites

### Passo 6: Testadores Instalam o App

1. Testadores recebem um email de convite
2. Eles instalam o app **TestFlight** da App Store
3. Aceitam o convite
4. Instalam seu app pelo TestFlight

## 📱 Método 2: Ad Hoc Distribution

Distribuição direta para dispositivos específicos (sem App Store).

### Passo 1: Obter UDIDs dos Dispositivos

Cada dispositivo iOS tem um UDID único. Você precisa coletá-los:

**No Mac (com dispositivo conectado):**
1. Abra o **Finder**
2. Conecte o iPhone/iPad
3. Selecione o dispositivo
4. Clique em **Informações Gerais**
5. O UDID aparece (clique para copiar)

**No iPhone/iPad:**
1. Instale o app [UDID Checker](https://apps.apple.com/app/udid-checker/id1234567890) (ou similar)
2. Abra o app
3. Copie o UDID

### Passo 2: Registrar Dispositivos no Apple Developer

1. Acesse [developer.apple.com/account](https://developer.apple.com/account)
2. Faça login
3. Vá em **Certificates, Identifiers & Profiles**
4. Clique em **Devices**
5. Clique no botão **+**
6. Adicione os UDIDs coletados
7. Dê um nome descritivo para cada dispositivo

### Passo 3: Criar Perfil de Provisionamento Ad Hoc

1. No Apple Developer, vá em **Profiles**
2. Clique no botão **+**
3. Selecione **Ad Hoc**
4. Selecione seu App ID
5. Selecione o certificado de desenvolvimento
6. Selecione os dispositivos registrados
7. Dê um nome ao perfil
8. Baixe o perfil

### Passo 4: Instalar o Perfil no Xcode

1. No Xcode, vá em `Xcode > Settings > Accounts`
2. Selecione sua conta
3. Clique em **Download Manual Profiles**
4. Ou arraste o arquivo `.mobileprovision` para o Xcode

### Passo 5: Criar Archive Ad Hoc

1. No Xcode, selecione **Any iOS Device**
2. Vá em `Product > Archive`
3. No Organizer, selecione seu archive
4. Clique em **Distribute App**
5. Selecione **Ad Hoc**
6. Siga as instruções
7. Exporte o arquivo `.ipa`

### Passo 6: Distribuir o .ipa

**Opção A: Via iTunes/Finder**
1. Conecte o dispositivo ao Mac
2. Abra o **Finder** (ou iTunes em macOS antigo)
3. Selecione o dispositivo
4. Arraste o arquivo `.ipa` para a área de apps
5. Sincronize

**Opção B: Via Servidor Web**
1. Faça upload do `.ipa` para um servidor web
2. Crie uma página HTML com link para o `.ipa`
3. Compartilhe o link
4. Testadores abrem no Safari do iPhone
5. Instalam o app

**Opção C: Via Ferramentas de Distribuição**
- Use serviços como [Diawi](https://www.diawi.com/) ou [InstallOnAir](https://www.installonair.com/)

## 🏪 Método 3: App Store (Distribuição Pública)

### Passo 1: Preparar Assets

Você precisará de:

- **Ícone do app**: 1024x1024 pixels (PNG, sem transparência)
- **Screenshots**: 
  - iPhone: 6.7", 6.5", 5.5" (portrait)
  - iPad: 12.9" (portrait e landscape)
- **Descrição**: Texto descrevendo o app
- **Palavras-chave**: Para busca na App Store
- **Categoria**: Ex: Health & Fitness

### Passo 2: Configurar no App Store Connect

1. Acesse [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Crie um novo app
3. Preencha todas as informações:
   - Nome do app
   - Bundle ID
   - Categoria
   - Descrição
   - Screenshots
   - Ícone
   - Informações de privacidade

### Passo 3: Submeter para Revisão

1. No App Store Connect, vá em **App Store**
2. Preencha todas as seções obrigatórias
3. Faça upload do build (via Xcode ou Transporter)
4. Clique em **Submit for Review**
5. Aguarde a revisão (geralmente 1-3 dias)

### Passo 4: Após Aprovação

1. Você receberá um email de aprovação
2. O app estará disponível na App Store
3. Você pode escolher quando lançar (automático ou manual)

## 📝 Checklist de Distribuição

Antes de distribuir, verifique:

- [ ] App está completamente funcional
- [ ] Todos os bugs conhecidos foram corrigidos
- [ ] Testado em diferentes dispositivos
- [ ] Ícone do app está configurado
- [ ] Versão e Build estão corretos
- [ ] Credenciais do Supabase estão configuradas
- [ ] Política de privacidade está disponível (se necessário)
- [ ] Termos de uso estão disponíveis (se necessário)
- [ ] Screenshots estão prontos (para App Store)
- [ ] Descrição do app está escrita

## 🔐 Segurança e Privacidade

### Política de Privacidade

Se seu app coleta dados do usuário, você precisa de uma política de privacidade:

1. Crie uma página web com a política
2. Adicione o link no App Store Connect
3. Inclua informações sobre:
   - Quais dados são coletados
   - Como os dados são usados
   - Como os dados são protegidos

### Permissões

Certifique-se de que todas as permissões solicitadas são necessárias e explicadas ao usuário.

## 📊 Monitoramento

Após o lançamento:

1. **App Store Connect Analytics**: Veja estatísticas de downloads, uso, etc.
2. **Crash Reports**: Monitore crashes do app
3. **Feedback**: Responda a avaliações e comentários

## 🐛 Troubleshooting

### Erro: "No valid code signing identities found"

- Verifique se você tem um certificado válido
- Vá em `Xcode > Settings > Accounts` e baixe certificados

### Erro: "Device not registered"

- Adicione o UDID do dispositivo no Apple Developer

### Erro: "Provisioning profile expired"

- Crie um novo perfil de provisionamento
- Baixe e instale no Xcode

## 🔗 Recursos Adicionais

- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

## 📞 Suporte

Para problemas com distribuição:

1. Consulte a documentação do Apple Developer
2. Entre em contato com o suporte da Apple
3. Verifique fóruns da comunidade

