#!/usr/bin/env bash

DOTFILES="${DOTFILES_DIR:=$HOME/.dotfiles}"
FAILED=0
SUCCESS=0

[[ -z "$1" ]] && { echo "Usage: $0 <path1> [path2] [path3] ..."; exit 1; }
[[ ! -d "$DOTFILES" ]] && { echo "Error: $DOTFILES not found"; exit 1; }

for target in "$@"; do
    src="$HOME/$target"
    dest="$DOTFILES/$target"
    
    if [[ ! -e "$src" ]]; then
        echo "✗ $target (not found)"
        ((FAILED++))
        continue
    fi
    
    mkdir -p "$(dirname "$dest")" || true
    
    # Если это уже symlink на правильное место - пропускаем
    if [[ -L "$src" ]] && [[ "$(readlink "$src")" == "$dest" ]]; then
        echo "✓ $target (already linked)"
        ((SUCCESS++))
        continue
    fi
    
    # Если файл уже в dotfiles (и не symlink) - пропускаем
    if [[ -e "$dest" ]] && [[ ! -L "$dest" ]]; then
        echo "⚠ $target (exists in dotfiles)"
        ((SUCCESS++))
        continue
    fi
    
    # Если это symlink но на другое место - удаляем
    if [[ -L "$src" ]]; then
        rm "$src" || true
    fi
    
    # Основное действие
    if mv "$src" "$dest" 2>/dev/null && ln -sf "$dest" "$src" 2>/dev/null; then
        echo "✓ $target"
        ((SUCCESS++))
    else
        echo "✗ $target (failed)"
        ((FAILED++))
    fi
done

echo ""
[[ $SUCCESS -gt 0 ]] && echo "✓ Success: $SUCCESS"
[[ $FAILED -gt 0 ]] && echo "✗ Failed: $FAILED"
exit $FAILED

