# Início Rápido - FitSênior iOS

Guia rápido para começar a usar o app FitSênior iOS em 5 minutos.

## ⚡ Passos Rápidos

### 1. Abrir o Projeto (1 minuto)

```bash
# Navegue até a pasta
cd ios_pkg

# Abra no Xcode
open FitSenior.xcodeproj
```

### 2. Configurar Supabase (2 minutos)

1. Abra `FitSenior/Services/SupabaseClient.swift`
2. Substitua:
   ```swift
   private let supabaseURL = "SUA_SUPABASE_URL_AQUI"
   private let supabaseKey = "SUA_SUPABASE_ANON_KEY_AQUI"
   ```
3. Obtenha as credenciais em: https://app.supabase.com > Settings > API

### 3. Instalar Dependências (1 minuto)

1. No Xcode: `File > Add Package Dependencies...`
2. Cole: `https://github.com/supabase/supabase-swift`
3. Clique em `Add Package`

### 4. Rodar no Simulador (1 minuto)

1. Selecione um simulador (ex: iPhone 15 Pro)
2. Pressione `Cmd + R`
3. Pronto! 🎉

## 📱 Testar no iPhone

1. Conecte o iPhone ao Mac
2. Selecione o dispositivo no Xcode
3. Pressione `Cmd + R`
4. No iPhone: `Configurações > Geral > Gerenciamento de VPN e Dispositivo` > Confiar

## 📚 Documentação Completa

- **Configuração detalhada:** [GUIA_CONFIGURACAO.md](GUIA_CONFIGURACAO.md)
- **Como testar:** [GUIA_TESTES.md](GUIA_TESTES.md)
- **Implementar Supabase:** [IMPLEMENTACAO_SUPABASE.md](IMPLEMENTACAO_SUPABASE.md)
- **Índice completo:** [INDICE.md](INDICE.md)

## ⚠️ Problemas?

Consulte [TROUBLESHOOTING.md](TROUBLESHOOTING.md) ou o [README.md](README.md) completo.

---

**Tempo total:** ~5 minutos para começar! 🚀

