# Entity Display JSON — manual setup guide

**Entity Display JSON** (`entity_display_json`) is a **read‑only JSON API for Drupal
entities driven by your existing Manage Display configuration**. Instead of
hand‑writing a field map or rebuilding render arrays, you configure a view display
once and get a stable JSON contract: hidden fields stay hidden, view modes propagate
to referenced entities, and label settings come through. It's aimed at decoupled and
headless front ends — React, Vue, Svelte, native apps, edge renderers — that want
the same field visibility and formatter settings as a configured display mode.

It exposes three endpoints, all gated by a single permission, **"Access Entity
Display JSON endpoints"**:

- `GET /ejson` — site name, slogan, language map, and a homepage pointer.
- `GET /ejson/resolve?path=/about-us` — translates a path or alias into an
  `{entity_type, uuid, id, display_id}` pointer your front end can follow.
- `GET /ejson/{entity_type}/{uuid}/{display_id}` — serializes an entity (or view)
  using the named view display (`display_id` defaults to `default`).

Highlights include one‑call full‑page output (referenced entities, paragraphs, media,
and files are walked recursively using each component's view mode), automatic
cacheability (cache tags and contexts bubble into a cacheable JSON response),
multilingual support via `?lang=xx`, safe recursion that marks cycles/deep nesting
with `_stub` instead of looping, and integrations that are picked up automatically
when present (Views, Field Group, Block Field, Paragraphs). It's also extensible
without forking, via field‑value‑extractor plugins and several alter hooks. It
requires **Drupal 10.2+ or 11**.

**Access model.** The endpoints enforce Drupal's normal view access on top of the
**"Access Entity Display JSON endpoints"** permission: per-entity view access (a denied
entity yields no field data), the view display's own access plugin for view/`views_block:*`
serialization, and per-field view access (fields the current user can't see are omitted).
Grant the permission to the roles or API consumers that should be able to reach the API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant the endpoint permission.

There is **no dedicated settings form** — the JSON output is shaped by your entities'
**Manage Display** configuration (plus optional per‑field third‑party settings and
code‑level extension points), and the endpoints are controlled by a single
permission.

## Where it lives / how to use it

1. Enable the module and grant **"Access Entity Display JSON endpoints"** (under
   **People → Permissions**) to the roles or API consumers that should reach the API.
2. Configure how your content should appear under **Structure → (entity type) →
   Manage display** for the view mode you intend to serve. Whatever you show or hide
   there is what appears in the JSON.
3. Call the endpoints: start with `GET /ejson`, resolve a path with
   `GET /ejson/resolve?path=/your-path`, then fetch the entity with
   `GET /ejson/{entity_type}/{uuid}/{display_id}`. Append `?lang=xx` for a specific
   translation.
