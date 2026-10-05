#!/usr/bin/env bash
# Собирает .mrpack: подставляет актуальный NeoForge, добавляет недостающие моды
# из modlist.txt через Modrinth и экспортирует сборку.
# Нужны packwiz в PATH и доступ к api.modrinth.com и maven.neoforged.net.
set -uo pipefail
cd "$(dirname "$0")/.."

echo "==> Обновляю NeoForge до последней версии для 1.21.1"
packwiz migrate loader latest -y || { echo "Не удалось обновить NeoForge"; exit 1; }

failed=()
while read -r line; do
  slug="${line%%#*}"
  slug="$(echo "$slug" | xargs)"
  [ -z "$slug" ] && continue
  if compgen -G "*/${slug}.pw.toml" > /dev/null; then
    echo "==> $slug уже в сборке"
    continue
  fi
  echo "==> Добавляю $slug"
  if ! packwiz modrinth add "$slug" -y; then
    echo "!! $slug: нет версии под NeoForge 1.21.1 или ошибка"
    failed+=("$slug")
  fi
done < modlist.txt

packwiz refresh
mkdir -p dist
packwiz modrinth export -o "dist/$(sed -n 's/^version = "\(.*\)"/Dezelo-Eternal-Frost-\1/p' pack.toml).mrpack" || exit 1

if [ ${#failed[@]} -gt 0 ]; then
  echo "Не добавлены: ${failed[*]}"
  [ -n "${GITHUB_STEP_SUMMARY:-}" ] && printf '### Не добавлены\n%s\n' "$(printf -- '- %s\n' "${failed[@]}")" >> "$GITHUB_STEP_SUMMARY"
fi
ls -la dist
