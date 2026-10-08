# Swagger-PHP OpenAPI 3 documentation generator — manual setup guide

**Swagger-PHP OpenAPI 3 documentation generator** (`swagger_php`) lets you
document your Drupal code with PHP attributes and turns those attributes into a
live OpenAPI 3 specification and an interactive Swagger UI documentation page. It
wraps the well‑known `zircote/swagger-php` library: it scans a folder of your code
for `#[OA\...]` attributes, builds the OpenAPI document, serves it as JSON at
`/api/spec`, and renders it interactively via Swagger UI at `/api/docs`.

The problem it solves is keeping API documentation next to the code it describes.
Instead of maintaining a separate spec file by hand, you annotate your controllers
and REST resources — for example a custom `RestResource` plugin — with OpenAPI
attributes, and the module regenerates the spec on every request. Front‑end
developers and API consumers always see documentation that matches the current
code.

It needs a little setup before it does anything: you install the
`zircote/swagger-php` library and the Swagger UI dist assets, tell the module which
folder to scan on its settings form (default `modules/custom`), and grant the
spec/docs permissions to the right roles. It has no module dependencies, provides
its own permissions, and ships no submodules. Supports Drupal 10.2/11.1 and newer.

On security: importantly, the scanner only **parses** attributes — it does **not**
execute the code it scans. All three routes are permission‑gated, so the spec and
docs are **not** public by default. Exposing them to anonymous users only happens
if an administrator deliberately grants those permissions to the anonymous role —
treat that as a conscious choice, since an OpenAPI document can reveal your
internal endpoints and their parameters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the two
   libraries it needs, then enable it.
2. [Configuration](configuration/index.md) — choose the folder to scan, grant the
   spec/docs permissions, and annotate your code.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → Swagger-PHP**
(`/admin/config/services/swagger_php`), gated by the *administer swagger_php
settings* permission. The generated documentation lives at `/api/docs` (Swagger
UI) and the raw JSON spec at `/api/spec`.
