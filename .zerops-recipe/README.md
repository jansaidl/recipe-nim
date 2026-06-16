# Nim Hello World — Zerops recipe

This file holds the recipe content Zerops renders on the recipe detail page.
Everything between the `#ZEROPS_EXTRACT_*` markers is what Zerops reads; the rest
is here for humans browsing the repo on GitHub.

<!-- #ZEROPS_EXTRACT_START:name# -->
Nim Hello World
<!-- #ZEROPS_EXTRACT_END:name# -->

<!-- #ZEROPS_EXTRACT_START:shape# -->
app
<!-- #ZEROPS_EXTRACT_END:shape# -->

<!-- #ZEROPS_EXTRACT_START:intro# -->
A minimal Nim HTTP server, compiled to a native binary and deployed on Zerops in
one click — the smallest possible starting point for a Nim web app.
<!-- #ZEROPS_EXTRACT_END:intro# -->

<!-- #ZEROPS_EXTRACT_START:description# -->
Nim Hello World is a bare-bones web server written in [Nim](https://nim-lang.org)
— a statically typed language that compiles to a small, fast native executable.
It serves a single `Hello world from Nim lang` response over HTTP, so there is no
framework, no database, and nothing to learn before you can deploy. Run it to get
a working Nim app on a public URL in minutes, then grow it into whatever you need.

It ships two environments. **Stage** runs a single lightweight container — ideal
for trying the recipe out and iterating on changes. **Production** runs the same
service on autoscaling shared CPU, ready for real traffic. Both build from the
same source and `zerops.yaml`; only the topology differs.
<!-- #ZEROPS_EXTRACT_END:description# -->

<!-- #ZEROPS_EXTRACT_START:features# -->
- **Native compiled binary** — Nim compiles `server.nim` to a small, fast native executable; no interpreter or VM at runtime.
- **Async HTTP server** — built on Nim's standard-library `asynchttpserver` for non-blocking request handling.
- **Self-contained toolchain** — the build installs the Nim compiler automatically via [choosenim](https://nim-lang.org/), so there is nothing to set up by hand.
- **Public URL out of the box** — port `8080` is exposed with HTTP support and a Zerops subdomain enabled.
- **One-click deploy, push to update** — connect your fork and every push rebuilds and redeploys.
- **A clean starting point** — one tiny source file to extend into a real Nim application.
<!-- #ZEROPS_EXTRACT_END:features# -->

<!-- #ZEROPS_EXTRACT_START:takeover-guide# -->
This recipe has **no secrets to configure** — it deploys and runs as-is.

**Make it yours.** The whole app is a single file, `server.nim`. Edit the
`handler` proc to change the response or add routing:

```nim
proc handler(req: Request) {.async.} =
  await req.respond(Http200, "Hello world from Nim lang")
```

Commit and push to your connected repo — Zerops recompiles `server.nim` and
redeploys the new binary automatically. The service listens on port `8080`; if
you change the port, update the `ports` block in `zerops.yaml` to match.
<!-- #ZEROPS_EXTRACT_END:takeover-guide# -->

<!-- #ZEROPS_EXTRACT_START:knowledge-base# -->
### Architecture

A single Zerops service named `app`, built and run on `ubuntu@24.04`. There are
no backing services — the app is stateless and holds no data. Requests hit the
Nim `asynchttpserver` directly on port `8080`, which Zerops exposes over HTTP via
the service subdomain.

### Build pipeline

The build is defined in `zerops.yaml` (`setup: app`):

1. Install `gcc` (Nim compiles to C, then to a native binary).
2. Install the Nim toolchain via [choosenim](https://nim-lang.org/).
3. `nim c server.nim` — compile the source into a native `server` executable.
4. Deploy only the resulting `server` binary (`deployFiles: [server]`).

At runtime Zerops starts `./server`, which listens on port `8080`.

### Configuration

There is no configuration to set — no environment variables and no secrets. The
listening port is hard-coded to `8080` in `server.nim` and mirrored in the
`ports` block of `zerops.yaml`; change both together if you need a different port.

### Troubleshooting

- **Build fails on `nim c`** — confirm the choosenim install step completed and
  that `~/.nimble/bin` was copied onto `PATH` (see the `buildCommands` in
  `zerops.yaml`).
- **No response on the subdomain** — verify the service exposes port `8080` with
  `httpSupport: true` and that `enableSubdomainAccess` is set on the service.
- **Changes not showing up** — make sure your push reached the branch Zerops
  builds from; each push triggers a fresh build and deploy.
<!-- #ZEROPS_EXTRACT_END:knowledge-base# -->
