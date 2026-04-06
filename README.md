# n8n Two-Target Docker Setup

This repository now contains:

- A Dev Containers target (`dev`) that keeps `apk` and tooling available for VS Code setup
- A runtime target (`runtime`) to run n8n

## Dev Container (VS Code)

1. Open this folder in VS Code.
2. Run: Reopen in Container.
3. VS Code will build the `dev` target from `Dockerfile`.

## Runtime Container

Build and run with Docker Compose:

```sh
docker compose up -d --build
```

Open n8n at `http://localhost:5678`.

Stop:

```sh
docker compose down
```

## Why this fixes your issue

Your previous image identified as Alpine but had no `apk`, so Dev Containers failed when it tried to run Alpine setup checks.

This setup separates concerns:

- `dev`: VS Code-friendly image for development workflows
- `runtime`: lean image for running n8n
