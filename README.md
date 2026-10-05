# Dezelo: Eternal Frost ❄️

Сборка модов для **Minecraft 1.21.1 / NeoForge** про вечную зиму и лютый холод.
Лета нет. Каждый биом заморожен, снег идёт всегда, а без огня и тёплой одежды
быстро наступает обморожение.

## Как получить .mrpack

1. Открой вкладку **Actions** → последний запуск **Build modpack** → артефакт `mrpack`.
2. Или поставь тег `v0.1.0` и запушь его: `.mrpack` появится в **Releases**.
3. Импортируй файл в Modrinth App, Prism Launcher или ATLauncher.

Локальная сборка (нужен Go и доступ к Modrinth):

```bash
go install github.com/packwiz/packwiz@latest
scripts/build.sh            # результат в dist/
```

## Что внутри

| Категория | Моды |
|---|---|
| Вечная зима | Primal Winter, Cold Sweat, Particle Rain, Snow! Real Magic! |
| Быт в мороз | Comforts, Farmer's Delight, Supplementaries, Sophisticated Backpacks |
| Опасности | Mowzie's Mobs (ледяной босс Frostmaw), YUNG's Better Dungeons/Mineshafts/Strongholds, Terralith |
| Интерфейс | JEI, Jade, AppleSkin, Mouse Tweaks, Xaero's Minimap |
| Производительность | Sodium, Iris, FerriteCore, ModernFix, Entity Culling, ImmediatelyFast |
| Шейдеры | Complementary Reimagined |

Primal Winter опускает температуру биомов ниже нуля, а Cold Sweat её читает,
поэтому на поверхности по-настоящему холодно. Спасают костры, жаровни,
очаг (Hearth из Cold Sweat), меховая броня и горячая еда.

## Как менять состав

Отредактируй `modlist.txt` (slug проекта на Modrinth) и запушь.
CI добавит новые моды, обновит NeoForge до свежей 1.21.1-версии, закоммитит
закреплённые версии в `mods/` и соберёт новый `.mrpack`.
Если у мода нет версии под NeoForge 1.21.1, он попадёт в список
«Не добавлены» в сводке запуска, а сборка всё равно соберётся.
