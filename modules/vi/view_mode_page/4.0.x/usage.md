<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View mode page lets you expose an entity at one or more additional paths that render it in a chosen view mode (e.g. show a node's teaser at `/my/page/summary`), driven by configurable path patterns.

---

The module defines a `view_mode_page_pattern` config entity (config prefix `view_mode_page.pattern`). Each pattern has a **path pattern** string that must contain a `%` placeholder standing for the entity's normal canonical URL/alias (e.g. `/%/summary`), an **alias type** (`type`, a plugin id such as `canonical_entities:node`), a target **`view_mode`**, and optional CTools **selection criteria** (bundle/language conditions with `and`/`or` `selection_logic`) plus a `weight` for ordering. An inbound/outbound `path_processor` service (`view_mode_page.path_processor`, priority 250) matches request paths against the patterns and rewrites them to the internal route `/view_mode_page/{view_mode}/{entity_type}/{entity_id}`, whose controller issues a sub-request to render the entity in the requested view mode. Patterns are managed at `/admin/config/search/view-mode-page` (route `entity.view_mode_page_pattern.collection`, permission `administer view_mode_page`). Alias types are a plugin type (`@AliasType`, manager `view_mode_page.manager.alias_type`); the shipped `canonical_entities` plugin is derived per entity type that has a canonical link. It depends on Path, CTools (for the condition plugins) and Token. A `hook_block_build_alter` adds the `url.path` cache context to the main system block so per-path view modes cache correctly.

---

- Show a node's **teaser** at `/{node-alias}/summary` while the full page stays at its canonical URL.
- Publish a "print" view mode of an article at `/{alias}/print` without a separate route.
- Expose a compact **card** view mode of a product at `/{alias}/card` for embedding/preview.
- Provide an `/{alias}/email` path that renders an entity in an email-oriented view mode.
- Create a `/{alias}/rss`-style path mapped to a custom view mode for a feed-friendly rendering.
- Limit a pattern to only the **Article** bundle via selection criteria, leaving other types untouched.
- Restrict a pattern to a single **language** using the language condition.
- Combine bundle + language conditions with `and`/`or` logic on one pattern.
- Order overlapping patterns with `weight` so the most specific one wins.
- Offer a "mobile" view mode of any page at `/{alias}/m` for a lightweight layout.
- Give editors a preview URL that renders the exact teaser used in listings.
- Render a user entity in a "compact profile" view mode at an extra path.
- Add a `/{alias}/full` path forcing the full view mode even where teaser is default.
- Support multiple simultaneous patterns (e.g. `/summary`, `/print`, `/card`) on the same site.
- Map a taxonomy term's alias + `/overview` to a custom term view mode.
- Keep SEO clean: the extra path renders inline (sub-request), not a redirect, so it is its own URL.
- Build a custom **alias type** plugin to support non-canonical or non-entity patterns.
- Reuse an existing path alias structure since patterns are based on the regular entity URL/alias (`%`).
- Provide a distraction-free reading view mode at `/{alias}/read`.
- Drive A/B display experiments by exposing two view modes of the same content at different paths.
- Show a "gallery" view mode of a media-heavy node at `/{alias}/gallery`.
- Let a theme link to `/{alias}/summary` to reuse teaser markup on a standalone page.
- Configure everything as exportable config (the `view_mode_page.pattern.*` entities) for deployment.
- Apply a pattern site-wide (leave bundles/languages empty) to any entity with a canonical URL.
