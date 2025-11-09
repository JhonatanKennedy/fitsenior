#!/bin/bash

echo "🔧 Corrigindo ícone do aplicativo..."

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Verificar se a imagem existe
if [ ! -f "FitSenior/Assets.xcassets/AppIcon.appiconset/AppIcon-1024x1024.png" ]; then
    echo "❌ Erro: Imagem AppIcon-1024x1024.png não encontrada!"
    echo "   Por favor, adicione sua imagem de 1024x1024 na pasta:"
    echo "   FitSenior/Assets.xcassets/AppIcon.appiconset/"
    exit 1
fi

echo "✅ Imagem encontrada: AppIcon-1024x1024.png"

# 2. Verificar formato da imagem
file_info=$(file "FitSenior/Assets.xcassets/AppIcon.appiconset/AppIcon-1024x1024.png")
if [[ $file_info == *"1024 x 1024"* ]]; then
    echo "✅ Tamanho correto: 1024x1024"
else
    echo "⚠️  Aviso: Verifique se a imagem é 1024x1024 pixels"
fi

# 3. Limpar cache do Xcode
echo ""
echo "${YELLOW}Limpando cache do Xcode...${NC}"
rm -rf ~/Library/Developer/Xcode/DerivedData/*
echo "✅ Cache limpo"

# 4. Limpar build do projeto
echo ""
echo "${YELLOW}Limpando build do projeto...${NC}"
cd "$(dirname "$0")"
xcodebuild clean -project FitSenior.xcodeproj -scheme FitSenior 2>&1 | grep -E "(CLEAN|error)" | head -5
echo "✅ Build limpo"

echo ""
echo "${GREEN}✅ Processo concluído!${NC}"
echo ""
echo "📱 Próximos passos:"
echo "   1. Abra o Xcode"
echo "   2. Vá em: FitSenior → Assets.xcassets → AppIcon"
echo "   3. Verifique se a imagem aparece no slot 1024x1024"
echo "   4. Se não aparecer, arraste a imagem novamente para o slot"
echo "   5. No Xcode: Product → Clean Build Folder (⇧⌘K)"
echo "   6. Delete o app do simulador (pressione e segure o ícone → Remove App)"
echo "   7. Execute novamente: Product → Run (⌘R)"
echo ""
echo "💡 Dica: Às vezes é necessário reiniciar o simulador completamente"

