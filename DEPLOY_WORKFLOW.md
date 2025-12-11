# Workflow für Updates

Dieses Dokument beschreibt den Prozess, um Änderungen an der Website vorzunehmen und sie live zu stellen.

## 1. Lokale Änderungen entwickeln

Arbeite lokal an den Dateien (HTML, CSS, etc.).

## 2. Änderungen auf GitHub hochladen

Wenn du mit deinen Änderungen zufrieden bist, lade sie in das Git-Repository hoch.

```bash
# 1. Alle Änderungen zum Commit hinzufügen
git add .

# 2. Einen Commit mit einer aussagekräftigen Nachricht erstellen
git commit -m "Beschreibe hier deine Änderungen, z.B. 'Neuen Blog-Post hinzugefügt'"

# 3. Die Änderungen auf GitHub hochladen
git push origin main
```

## 3. Auf dem Server deployen

Verbinde dich mit deinem Server (z.B. per SSH) und führe die folgenden Befehle im Projektverzeichnis aus.

```bash
# 1. Navigiere zum Projektverzeichnis
cd /home/lexmellow/docker/portfolio

# 2. Hole die neuesten Änderungen von GitHub
git pull origin main

# 3. Baue das Docker-Image neu und starte den Container
#    Dieser Schritt kopiert die neuen Dateien in den Webserver.
docker compose up -d --build
```

Danach sollten deine Änderungen auf `https://fastfertig.pro` live sein.
