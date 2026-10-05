#!/usr/bin/env python3
"""Скачивает все файлы из .mrpack и складывает их в zip с готовыми папками
mods/ и shaderpacks/ — для ручной установки без лаунчера с поддержкой .mrpack."""
import hashlib, json, pathlib, sys, urllib.request, zipfile

mrpack = pathlib.Path(sys.argv[1])
out = pathlib.Path(sys.argv[2])

with zipfile.ZipFile(mrpack) as src:
    index = json.loads(src.read("modrinth.index.json"))

with zipfile.ZipFile(out, "w", zipfile.ZIP_STORED) as dst:
    for f in index["files"]:
        data = urllib.request.urlopen(f["downloads"][0]).read()
        if hashlib.sha512(data).hexdigest() != f["hashes"]["sha512"]:
            sys.exit(f"Хеш не совпал: {f['path']}")
        dst.writestr(f["path"], data)
        print(f"+ {f['path']}")
    deps = index["dependencies"]
    dst.writestr("README.txt",
        f"Minecraft {deps['minecraft']}, NeoForge {deps['neoforge']}\n"
        "Скопируй папки mods/ и shaderpacks/ в папку игры (.minecraft или папку профиля).\n"
        "NeoForge ставится отдельно: https://neoforged.net\n")
