#!/bin/bash
# Script para limpar cache do Xcode e resolver dependências

echo "🧹 Limpando cache do Xcode..."

# Limpar Derived Data
echo "1. Limpando Derived Data..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Limpar cache do Swift Package Manager
echo "2. Limpando cache do Swift Package Manager..."
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/org.swift.swiftpm

# Limpar cache de build do projeto
echo "3. Limpando cache de build do projeto..."
rm -rf ~/Library/Developer/Xcode/DerivedData/FitSenior-*

echo "✅ Cache limpo com sucesso!"
echo ""
echo "📝 Próximos passos:"
echo "1. Feche o Xcode completamente (Cmd+Q)"
echo "2. Reabra o projeto FitSenior.xcodeproj"
echo "3. Vá em File > Packages > Resolve Package Versions"
echo "4. Tente compilar novamente (Cmd+B)"
