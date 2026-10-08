# Swagger UI Info — manual setup guide

**Swagger UI Info** (`swagger_ui_info`) displays API information on your Drupal
site by rendering an OpenAPI/Swagger specification in the interactive **Swagger
UI**. You upload a Swagger spec file (or use the bundled example), and the module
publishes a browsable, "try it out" API explorer at `/swagger_info`.

The problem it solves is giving developers a friendly, interactive view of an
API's endpoints and parameters without building a docs page yourself. It is a
straightforward developer/API‑documentation tool: point it at a spec and it does
the rendering.

It needs a small amount of configuration — you supply the Swagger file on the
settings page and decide who can see the explorer through the permission it
provides. It has no module dependencies and ships no submodules. Supports Drupal
9.4, 10, and 11.

A security note worth taking seriously: an API‑explorer UI **reveals your API
surface** — the endpoints and their parameters — and its "try it" feature lets
viewers make real calls (which run with the caller's own authentication). Gate the
`/swagger_info` route to the audience you intend using the module's permission,
and don't publish documentation for internal or undocumented endpoints you would
rather keep private. Note also that this project is **not covered by Drupal's
security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — upload your Swagger spec and control
   who can view the explorer.

## Where it lives in the admin menu

Once enabled, the Swagger UI documentation is served at **`/swagger_info`**. You
manage the spec file from the module's settings page and control access through
the permission it provides on the **People → Permissions** screen.
