<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Noindex (node_noindex) — agent index

Adds a per-node checkbox that emits `<meta name="robots" content="noindex">` on that
node's page, so a compliant search engine drops the page from its results. No dependencies
outside core. Declares `php: 8.0`. Version **2.0.1**. Core `^9 || ^10 || ^11`.

## Mechanism (from `node_noindex.module`)

- **Storage is a base field, not config.** `hook_entity_base_field_info()` adds a boolean
  base field `noindex` to **every** node (translatable + revisionable). The per-node value
  lives on the node entity itself.
- **Two-step enablement.** The checkbox does **not** appear until the field is switched on
  for the content type. `hook_form_node_type_form_alter()` adds a *Node Noindex settings*
  tab with two node-type third-party settings: `noindex` (show the field on this type) and
  `noindex_default` (its default value). Stored under
  `node.type.<bundle>.third_party.node_noindex` (schema in `config/schema/`).
- **Per-node checkbox** — `hook_form_node_form_alter()` shows the *Exclude from search
  engines* field inside a *Search engine settings* group, but **only** when the bundle has
  `noindex` enabled **and** the current user holds `mark content as not indexable`.
- **Default value** — `node_noindex_default_noindex()` seeds new nodes from the bundle's
  `noindex_default`.
- **Tag emission** — `hook_preprocess_html()` reads the `node` route parameter; if that
  node's `noindex` value is truthy it appends a static `meta` tag (`name=robots`,
  `content=noindex`) to `#attached['html_head']`, keyed `node_noindex_noindex`. The
  content is a fixed string — no user data is interpolated.

## Permission

- `mark content as not indexable` (`node_noindex.permissions.yml`) — gates the per-node
  checkbox only. Toggling the field *per content type* is part of node-type admin
  (`administer content types`).

## The distinction that matters and is constantly confused

- **`noindex` is not access control.** The page stays **fully readable by anyone with the
  URL**; it only asks search engines not to *list* it, and only compliant ones obey.
  Anything that must not be **read** needs **permissions**, not this module.
- **`noindex` is not `robots.txt`, and combining them backfires.** `robots.txt` asks a
  crawler not to **fetch** the page — so a page blocked in `robots.txt` **cannot be seen to
  carry `noindex`** and can still surface as a bare URL. Use one or the other deliberately.
- Removing a page already in an index takes time — push it through the search engine's own
  removal tools.

## Solution docs

- `agent/configure/setup.md` — the two-step setup, third-party settings, permission, and
  where the tag comes out.
