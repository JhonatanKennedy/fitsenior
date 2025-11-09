#!/bin/bash
# Script para forçar a construção dos módulos do Supabase

echo "🔨 Forçando construção dos módulos do Supabase..."

cd "$(dirname "$0")"

# Limpar cache
echo "1. Limpando cache..."
rm -rf ~/Library/Developer/Xcode/DerivedData/FitSenior-*

# Resolver pacotes
echo "2. Resolvendo pacotes..."
xcodebuild -resolvePackageDependencies -project FitSenior.xcodeproj

# Construir apenas os módulos do pacote
echo "3. Construindo módulos do pacote..."
xcodebuild -project FitSenior.xcodeproj -scheme FitSenior -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15' clean build 2>&1 | grep -E "(Building|Compiling|error:|BUILD)" | head -20

echo ""
echo "✅ Processo concluído!"
echo "📝 Agora tente compilar no Xcode (⌘ + B)"

