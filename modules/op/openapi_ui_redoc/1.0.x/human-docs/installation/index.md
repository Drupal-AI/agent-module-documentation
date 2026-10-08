# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **OpenAPI UI** (`drupal/openapi_ui:^1`) — the framework module that defines the
  `openapi_ui` plugin type and render element. This is a hard Composer dependency
  and is pulled in for you.
- To actually have something to display, you will normally also want the **OpenAPI**
  module and a **generator** (for example the JSON:API or REST OpenAPI modules) that
  produces the specs and the admin listing. Install those separately if they are not
  already present.

The ReDoc JavaScript library itself is **not bundled** — the module loads
`redoc.min.js` from a CDN by default. See the note at the end of this page.

## Install with Composer

From the project root:

```bash
composer require drupal/openapi_ui_redoc -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the `openapi_ui` dependency and
updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openapi_ui_redoc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openapi_ui_redoc -y
```

This also enables the `openapi_ui` framework module if it is not already on. There
are **no submodules** and no permissions specific to this module — access to the
docs pages is governed by the OpenAPI module's *Access OpenAPI api docs* permission.

## Verify it worked

Go to **Configuration → Web services → OpenAPI** (`/admin/config/services/openapi`).
With a generator installed (e.g. JSON:API), each API should now show an **"Explore
with ReDoc"** link. Click it — or visit `/admin/config/services/openapi/redoc/jsonapi`
directly — and you should see the spec rendered as a three‑panel ReDoc page.

## Important: the CDN library gotcha

The module declares the ReDoc library pointing at an external CDN URL, but (in this
version) without marking it as an external asset. On a site with core's **Locale**
module enabled, this can make every ReDoc page throw *"Only local files should be
passed to _locale_parse_js_file()"* and return **HTTP 500**. If you hit that, the
fix is to correct or self‑host the library via `hook_library_info_alter()` — the
exact patch is in the [`agent/`](../agent/start.md) theming reference. Self‑hosting
`redoc.min.js` is also the right move for air‑gapped or strict‑CSP sites.
