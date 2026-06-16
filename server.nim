import asynchttpserver, asyncdispatch

proc main() {.async.} =
  let server = newAsyncHttpServer()

  proc handler(req: Request) {.async.} =
    await req.respond(Http200, "Hello world")

  server.listen(Port(8080))
  echo "Server running on http://localhost:8080"

  while true:
    if server.shouldAcceptRequest():
      await server.acceptRequest(handler)
    else:
      await sleepAsync(500)

waitFor main()
