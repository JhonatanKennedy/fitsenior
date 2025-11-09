# 📸 Como Adicionar Imagens ao App FitSenior

## Método 1: Via Xcode (Recomendado)

### Passo 1: Preparar a Imagem
1. Tenha sua imagem pronta (formato PNG ou JPG)
2. Recomendado: prepare 3 versões:
   - `logo.png` (1x - tamanho normal)
   - `logo@2x.png` (2x - para telas Retina)
   - `logo@3x.png` (3x - para telas Retina HD)

### Passo 2: Adicionar ao Assets
1. No Xcode, abra o navegador de arquivos (lado esquerdo)
2. Expanda `FitSenior` > `Assets.xcassets`
3. Clique com botão direito em `Assets.xcassets`
4. Selecione `New Image Set`
5. Nomeie a imagem (ex: "Logo")
6. Arraste suas imagens para os slots:
   - `1x` → logo.png
   - `2x` → logo@2x.png
   - `3x` → logo@3x.png

### Passo 3: Usar no Código
```swift
Image("Logo")
    .resizable()
    .scaledToFit()
    .frame(width: 120, height: 120)
```

## Método 2: Adicionar Manualmente

### Passo 1: Criar a Estrutura
A estrutura já foi criada em:
- `FitSenior/Assets.xcassets/Logo.imageset/`

### Passo 2: Adicionar os Arquivos
1. Coloque suas imagens na pasta:
   - `/FitSenior/Assets.xcassets/Logo.imageset/logo.png`
   - `/FitSenior/Assets.xcassets/Logo.imageset/logo@2x.png`
   - `/FitSenior/Assets.xcassets/Logo.imageset/logo@3x.png`

2. Ou use apenas uma imagem:
   - Coloque `logo.png` na pasta
   - O iOS usará a mesma imagem para todas as escalas

### Passo 3: Usar no Código
```swift
Image("Logo")
    .resizable()
    .scaledToFit()
    .frame(width: 120, height: 120)
```

## Exemplo Completo no HomeView

Já preparei o código no `HomeView.swift`. Para usar sua imagem:

1. Adicione a imagem ao Assets (método 1 ou 2 acima)
2. Descomente as linhas no código:
```swift
Image("Logo")
    .resizable()
    .scaledToFit()
    .frame(width: 120, height: 120)
```

3. Comente ou remova o ícone do sistema:
```swift
// Image(systemName: "heart.fill")
```

## Dicas

### Tamanhos Recomendados
- **Logo/Ícone**: 200x200px (1x), 400x400px (2x), 600x600px (3x)
- **Imagem de fundo**: 1242x2208px (iPhone)
- **Imagens de conteúdo**: conforme necessário

### Formatos Suportados
- ✅ PNG (recomendado, com transparência)
- ✅ JPG/JPEG
- ✅ PDF (vetorial, escalável)

### Modificadores Úteis
```swift
Image("Logo")
    .resizable()                    // Permite redimensionar
    .scaledToFit()                  // Mantém proporção, ajusta ao frame
    .scaledToFill()                 // Preenche o frame, pode cortar
    .frame(width: 120, height: 120) // Define tamanho
    .clipShape(Circle())            // Forma circular
    .cornerRadius(10)               // Cantos arredondados
    .shadow(radius: 5)              // Sombra
```

## Exemplo: Logo Circular com Sombra

```swift
Image("Logo")
    .resizable()
    .scaledToFill()
    .frame(width: 120, height: 120)
    .clipShape(Circle())
    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
```

## Exemplo: Imagem de Fundo

```swift
ZStack {
    Image("Background")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
    
    // Conteúdo sobre a imagem
    VStack {
        Text("Conteúdo")
    }
}
```

## Verificar se a Imagem Foi Adicionada

1. No Xcode, vá em `Assets.xcassets`
2. Você deve ver sua imagem listada
3. Se aparecer vazia, arraste os arquivos novamente

## Problemas Comuns

### Imagem não aparece
- Verifique se o nome no código corresponde ao nome no Assets
- Certifique-se de que os arquivos estão na pasta correta
- Limpe o build: `Product` > `Clean Build Folder`

### Imagem pixelada
- Use imagens de alta resolução (@2x, @3x)
- Ou use PDF vetorial

### Imagem muito grande/pequena
- Use `.resizable()` e `.frame()` para ajustar
- Use `.scaledToFit()` ou `.scaledToFill()`

