# RapiDoc Elements Field Formatter — manual setup guide

**RapiDoc Elements Field Formatter** (`rapidoc_elements_field_formatter`) turns an
OpenAPI/Swagger specification stored on a Drupal field into a browsable,
"try-it-out" API reference — rendered by the
[RapiDoc](https://rapidocweb.com/) web component right on your page. Instead of
hosting a separate Swagger UI, an editor attaches a spec and the docs appear
inline.

It provides two field formatters, so you can source the spec either way:

- **RapiDoc Elements UI** for **file** fields — renders a `openapi.yaml` /
  `swagger.json` spec uploaded into a file field. The module resolves the file's
  URL on the server.
- **RapiDoc Elements UI** for **link** fields — renders the spec found at a URL an
  editor types into a link field.

In both cases the formatter drops a `<rapi-doc>` element onto the page and points
it at the spec's URL; the RapiDoc JavaScript then **fetches and renders the spec
client-side, in the visitor's browser**. There is no settings screen — you pick
the formatter on a field's *Manage display*.

> **Two things to know before production.** (1) The RapiDoc JavaScript is loaded
> from the public CDN `https://unpkg.com/rapidoc`. Sites with a strict Content
> Security Policy or an offline requirement should mirror the library locally and
> override the library definition. (2) The visual styling (colors, layout,
> try-it behavior) is hard-coded in the module's Twig template — override that
> template in your theme to change the look.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You set it up on a field's
*Manage display*, as described below.

## How to use it

1. Add either a **file** field or a **link** field to the entity that will hold
   your API spec (for example a "API documentation" content type).
2. For a file field, upload the `openapi.yaml`/`swagger.json` spec; for a link
   field, enter the URL where the spec lives.
3. Go to that entity's **Manage display** screen and set the field's format to
   **RapiDoc Elements UI**.
4. Save, then view the entity — the interactive RapiDoc reference renders inline
   from the spec.
