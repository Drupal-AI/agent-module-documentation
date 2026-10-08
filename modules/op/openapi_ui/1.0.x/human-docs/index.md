# OpenAPI UI — manual setup guide

**OpenAPI UI** (`openapi_ui`) is a **framework** module for embedding an
interactive OpenAPI/Swagger API explorer inside a Drupal site. It defines a
plugin system and a render element that other modules build on, so you can drop a
live "try it out" API console into a node, block, or custom page.

The important thing to understand up front: OpenAPI UI **ships no user interface
of its own**. Enabling it alone renders nothing. The actual renderers live in
separate projects — **OpenAPI UI Swagger** (`openapi_ui_swagger`) for Swagger UI
and **OpenAPI UI ReDoc** (`openapi_ui_redoc`) for ReDoc — each of which
implements this module's plugin type. You typically also install the
[`openapi`](https://www.drupal.org/project/openapi) project to generate the
OpenAPI spec that feeds the display.

For developers, the module provides three building blocks: an `openapi_ui` plugin
type (so a module can teach Drupal to render a spec with a specific JavaScript
library), an `openapi_ui` render element that wraps a chosen renderer plugin plus
a spec source, and a route parameter converter that turns a route argument into a
live renderer plugin. It deliberately decouples the *spec source* from the
*display library*, so you can swap Swagger UI for ReDoc without touching the code
that produces your schema.

It has **no admin UI, no configuration form, no permissions, and no Drush
commands** — it is purely an integration/API layer for other modules to build on.

This guide is written for a **human** (site builder or developer). If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add a renderer.

## Where it lives in the admin menu

Nowhere — OpenAPI UI adds no admin page or settings. Any configuration (such as
Swagger UI or ReDoc options) comes from the renderer modules you install
alongside it.

## How to use it

Because this is a framework, "using it" means one of two things:

- **Site builders:** install OpenAPI UI plus a renderer (`openapi_ui_swagger`
  and/or `openapi_ui_redoc`) and, typically, the `openapi` module to generate the
  spec. Those modules provide the actual pages and settings — OpenAPI UI just
  supplies the plumbing they share.
- **Developers:** embed API docs with the `openapi_ui` render element, giving it a
  renderer plugin (`#openapi_ui_plugin`) and a spec (`#openapi_schema`, which can
  be a PHP array, a URL/URI string, a `Url` object, a managed file entity, or a
  callback). You can also write your own renderer plugin implementing
  `OpenApiUiInterface::build()`, register a route whose parameter is typed
  `openapi_ui`, or alter third‑party renderer definitions with
  `hook_openapi_ui_alter()`.

Note that until a renderer plugin is present, the module's plugin list is empty —
so install Swagger or ReDoc (or write your own plugin) to get anything on screen.
