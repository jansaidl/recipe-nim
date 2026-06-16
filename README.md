# Zerops × Nim — Hello World

A minimal Nim "Hello world" HTTP server, compiled to a native binary and deployed
on Zerops. The server listens on port `8080` and responds with
`Hello world from Nim lang` to every request.

This repo is a [Zerops recipe](https://app.zerops.io/recipes). The recipe content
Zerops renders lives in [`.zerops-recipe/`](./.zerops-recipe); the app source
(`server.nim`) and its build config (`zerops.yaml`) live at the repo root.

## Deploy on Zerops

Open the recipe and deploy in one click:

- **Production** — https://app.zerops.io/recipes/detail?github=https://github.com/jansaidl/recipe-nim&yaml=production
- **Stage** — https://app.zerops.io/recipes/detail?github=https://github.com/jansaidl/recipe-nim&yaml=stage

## How it works

[`zerops.yaml`](./zerops.yaml) defines a single `app` service built on `ubuntu@24.04`:

- **Build**: installs `gcc` and the Nim toolchain via [choosenim](https://nim-lang.org/), then compiles `server.nim` into a native `server` binary.
- **Run**: starts `./server` and exposes port `8080` with HTTP support.

## Files

- `server.nim` — the Nim source for the async HTTP server
- `zerops.yaml` — build & runtime configuration for the Zerops service
- `.zerops-recipe/` — the recipe definition Zerops reads (env imports + detail-page content)

The standalone `zerops-import.yaml` at the repo root is kept for direct
`zcli`/manual imports; the recipe itself imports from the per-environment
`import.yaml` files under `.zerops-recipe/`.
