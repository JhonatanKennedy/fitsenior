# Nota sobre Package.swift

## ⚠️ Importante

Este projeto **NÃO usa Package.swift**. É um projeto Xcode tradicional (.xcodeproj).

## Por quê?

O projeto está estruturado como um aplicativo iOS tradicional, não como um Swift Package. O arquivo `Package.swift` foi removido porque estava causando conflitos.

## Como adicionar dependências?

Use o Swift Package Manager do Xcode:

1. No Xcode: `File > Add Package Dependencies...`
2. Cole a URL do pacote (ex: `https://github.com/supabase/supabase-swift`)
3. Selecione a versão
4. Adicione ao target `FitSenior`
5. Clique em `Add Package`

As dependências serão gerenciadas automaticamente pelo Xcode e aparecerão no navegador de arquivos do projeto.

## Estrutura do Projeto

```
ios_pkg/
├── FitSenior.xcodeproj/    ← Projeto Xcode
├── FitSenior/               ← Código fonte
│   ├── Models/
│   ├── Services/
│   ├── Views/
│   └── Components/
└── [Documentação .md]
```

**Não há** pasta `Sources/` ou `Tests/` porque não é um Swift Package.

## Se você quiser converter para Swift Package

Se preferir usar Swift Package Manager, você precisaria:

1. Reorganizar arquivos para `Sources/FitSenior/`
2. Criar `Package.swift` apropriado
3. Remover o `.xcodeproj`

Mas para um app iOS, usar `.xcodeproj` é a abordagem padrão e recomendada.

