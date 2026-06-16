# Zerops + Nim

A minimal Nim "Hello world" HTTP server running on Zerops.

The server listens on port `8080` and responds with `Hello world from Nim lang` to every request.

## Deploy on Zerops

Import the project to Zerops using the [`zerops-import.yaml`](./zerops-import.yaml):

```yaml
project:
  name: "Nim Hello world"

services:
  - hostname: app
    type: ubuntu@24.04
    enableSubdomainAccess: true
    buildFromGit: https://github.com/jansaidl/recipe-nim
```

## How it works

The [`zerops.yaml`](./zerops.yaml) defines a single `app` service built on `ubuntu@24.04`:

- **Build**: installs `gcc` and the Nim toolchain via [choosenim](https://nim-lang.org/), then compiles `server.nim` into a native `server` binary.
- **Run**: starts `./server` and exposes port `8080` with HTTP support.

## Files

- `server.nim` — the Nim source for the async HTTP server
- `zerops.yaml` — build & runtime configuration for the Zerops service
- `zerops-import.yaml` — project & service definition for importing into Zerops