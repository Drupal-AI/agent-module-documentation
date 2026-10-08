# Redoc Field Formatter — manual setup guide

**Redoc Field Formatter** (`redoc_field_formatter`) renders an **OpenAPI /
Swagger specification** as polished, interactive API documentation using the
[Redoc](https://github.com/Redocly/redoc) library. You give it a spec — either
uploaded into a **file** field (JSON or YAML) or referenced by a **link** field —
and choose the **Redoc UI** formatter on the field's display. Drupal then renders
that spec as full API docs on the page.

It's handy whenever you want to publish API documentation inside a Drupal site:
attach an OpenAPI file to a node, term, or any fieldable entity, set the formatter,
and the endpoint reference turns into browsable documentation.

> **Important — the Redoc library loads from a third‑party CDN.** This release
> declares the Redoc JavaScript as an *external* asset from
> `https://cdn.jsdelivr.net/npm/redoc@2.0.0/…`. Three consequences follow, and you
> should decide about them before launch:
>
> 1. **Availability** — the docs only render when jsDelivr is reachable; they fail
>    in restricted or air‑gapped networks.
> 2. **Content Security Policy** — a strict `script-src` must allow that host, or
>    the documentation silently fails to render with no visible error.
> 3. **No Subresource Integrity hash** — the site executes whatever that URL
>    returns.
>
> Sites with a strict CSP or a privacy requirement normally **vendor the library
> locally** and override the library definition in a custom theme or module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set it up entirely on a field's *Manage display*, described under "How to use it".

## Where it lives in the admin menu

Redoc Field Formatter adds no admin page. You use it from **Structure → *(entity
type)* → Manage display**, on a file or link field.

## How to use it

1. Install and enable the module — and **clear all caches first**, which the
   maintainer flags as important right after installation.
2. Add a **file** field (or a **link** field) to the entity type that will hold
   your OpenAPI spec.
   - For a **file** field, make sure the **Allowed file extensions** include
     `json` and `yml` so editors can upload a spec.
3. Go to that entity type's **Manage display** tab.
4. For the file or link field, choose the **Redoc UI** formatter.
5. Save. Upload (or link to) an OpenAPI/Swagger spec in that field, and Drupal
   renders it as Redoc API documentation on the entity's page.
