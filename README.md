# 📂 Portfolio Hosting Setup (Git & Docker)

Dokumentation für das Hosting von `fastfertig.pro` mittels Git für das Deployment und Docker für den Betrieb.

---

### 🚀 Workflow: Webseite aktualisieren

Der Update-Prozess ist Git-basiert.

1.  **Lokal:** Änderungen entwickeln, committen und pushen.
    ```bash
    git add .
    git commit -m "Deine Änderungen"
    git push origin main
    ```
2.  **Server:** Einloggen, Änderungen holen und Container neu bauen.
    ```bash
    # 1. Neueste Änderungen von GitHub holen
    git pull origin main

    # 2. Docker-Image neu bauen und Container starten
    docker compose up -d --build
    ```
---