# Rabbit Hole — manual setup guide

**Rabbit Hole** (`rabbit_hole`) controls what happens when someone views a
content entity at its own canonical page. Many entities in Drupal exist only to
be *referenced* — a taxonomy term used for filtering, a media item embedded in
an article, a "component" node — yet Drupal still gives each one a full‑page URL
that visitors and crawlers can land on. Rabbit Hole intercepts those requests
and applies a configurable **behavior** instead.

For any entity type, bundle, or individual entity you can choose to: **display
the page** as normal, return **Access denied** (403), return **Page not found**
(404), or issue an **HTTP redirect** (301/302/303/304/305/307) to any path or
URL. Redirect targets support **tokens** (for example `[node:field_external_url]`)
via the Token module, so the destination can be pulled from the entity's own
fields. This makes Rabbit Hole a standard tool for hiding utility entities,
consolidating SEO by 301‑redirecting thin pages, and building headless or
component‑driven sites where most entities should never render standalone.

The base `rabbit_hole` module is a **framework** — it provides the shared
plumbing (two plugin types, the settings config entity, the request subscriber
that performs the action, and per‑entity‑type permissions) but does not act on
any entity type by itself. You make it act on a given entity type by enabling
one of its thin **submodules**: **Node** (`rh_node`), **Media** (`rh_media`),
**Taxonomy** (`rh_taxonomy`), **User** (`rh_user`), **File** (`rh_file`),
**Group** (`rh_group`), **Commerce** (`rh_commerce`), or **Paragraphs library**
(`rh_paragraphs_library`). Enable only the ones you need.

There is **no central admin settings page**. Instead, Rabbit Hole injects a
**"Rabbit Hole settings"** vertical tab into the relevant entity‑type/bundle
edit forms (and, optionally, individual entity edit forms). Access is gated by
per‑entity‑type permissions that the module generates dynamically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with
   Composer, then enable the submodule for each entity type you want to control.
2. [Configuration](configuration/index.md) — the "Rabbit Hole settings" tab,
   field by field, plus the per‑entity‑type permissions.

## Where it lives in the admin menu

Rabbit Hole has **no standalone configuration route** (`configure` is `null`).
Its settings live on entity edit forms, appearing only for entity types whose
submodule you have enabled:

- **Bundle level** — open a content type, vocabulary, media type, etc. (for
  example **Structure → Content types → *Article* → Edit**) and look for the
  **Rabbit Hole settings** vertical tab. The action you choose here is the
  default for every entity of that bundle.
- **Entity level** — if the bundle allows overrides, each individual entity's
  edit form also shows the tab, so a single node can differ from its bundle's
  default.

See [Configuration](configuration/index.md) for what each field does.
