# ReDoc for OpenAPI UI — manual setup guide

**ReDoc for OpenAPI UI** (`openapi_ui_redoc`) lets Drupal render an OpenAPI /
Swagger specification as a clean, three‑panel, read‑only **API reference page**
using the popular ReDoc JavaScript library. If your site exposes JSON:API or REST
endpoints and you use the OpenAPI tooling to describe them, this module gives you a
browsable, print‑friendly reference at a stable URL — the kind of documentation you
hand to front‑end developers or API consumers.

It is a thin bridge, not a standalone tool. It supplies a single renderer (an
`openapi_ui` plugin with the id `redoc`) and plugs into the **OpenAPI UI** framework
module, which defines the plugin type and the render element. The companion
**OpenAPI** module supplies the admin routes and the "OpenAPI Resources" listing. So
in practice you never configure ReDoc directly — you enable it, and it shows up as an
**"Explore with ReDoc"** option next to each API spec.

The module has **no settings form, no permissions of its own, no configuration
schema and no Drush commands** — it is essentially one small plugin plus a library
definition. Which spec ReDoc shows, and who can see it, is controlled by the OpenAPI
module (its docs live behind the `access openapi api docs` permission). There is one
gotcha worth knowing (a CDN library declaration that can cause a 500 error when
core's Locale module is enabled) and its fix — see the [`agent/`](../agent/start.md)
reference.

This guide is written for a **human** installing the module. If you want the terse,
token‑cheap reference for an AI coding agent — the plugin's render output, how to
embed ReDoc in a custom page, and the library gotcha/fix — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and its OpenAPI UI dependency), and view your API docs.

## Where it lives in the admin menu

ReDoc has no page of its own. Your API documentation is reachable through the
OpenAPI module at **Configuration → Web services → OpenAPI** (`/admin/config/
services/openapi`), which — once this module is enabled — gains an **"Explore with
ReDoc"** link for each generator. A ReDoc page for a given spec lives at a URL like
`/admin/config/services/openapi/redoc/jsonapi` (for the JSON:API spec). Viewing it
requires the *Access OpenAPI api docs* permission (provided by the OpenAPI module).

## How to use it

1. Install and enable this module along with its dependencies (see
   [Installation](installation/index.md)). You'll typically also want a **generator**
   such as the JSON:API or REST OpenAPI module so there is a spec to display.
2. Go to **Configuration → Web services → OpenAPI** (`/admin/config/services/
   openapi`).
3. For the API you want to document, click **Explore with ReDoc**. Drupal renders the
   spec as a three‑panel ReDoc reference page.
4. Bookmark or link to that URL (e.g. `/admin/config/services/openapi/redoc/jsonapi`)
   so your team always has the current API contract for each environment.

If you also enable a Swagger UI renderer (`openapi_ui_swagger`), you can offer both
"try‑it" Swagger UI and read‑only ReDoc side by side. Developers who want to embed a
ReDoc page inside a custom admin route, or point it at an external spec, can use the
`#type => 'openapi_ui'` render element — see the [`agent/`](../agent/start.md)
reference.
