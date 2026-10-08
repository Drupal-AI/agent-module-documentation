<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token Entity Render (token_entity_render) — agent index

Registers a family of tokens shaped `[<entity_type>:render:<view_mode>]` (e.g. `[node:render:teaser]`,
`[user:render:full]`) whose replacement value is the **entity rendered in that view mode**, not a
single field value. The whole module is one `.module` file with two hooks: `hook_token_info_alter()`
advertises a `render:<view_mode>` token for every view mode of every entity type, and `hook_tokens()`
performs the substitution by loading the entity's view builder and rendering it. It has no config
page, no route, no service and no plugin of its own — it plugs straight into core's token pipeline and
uses only core services.

The entity that gets rendered is always the one already in the token context (`$data['entity']`); the
token string carries the view-mode name only, never an entity id, so a token cannot pick out an
arbitrary entity. The replacement is a finished HTML string produced with core's renderer in
isolation, so it carries none of the render array's cache metadata back to the caller — attach cache
tags yourself where the surrounding output must invalidate when the entity changes.

- Depends on: nothing beyond Drupal core (info.yml declares no `dependencies:`; it uses core token
  hooks and the core `entity_type.manager` / `renderer` services).
- Core: `^9 || ^10 || ^11`. Package: `Token`. Version `2.0.0`.
- No settings page / `configure` route, no permissions, no drush commands, no config schema, no plugin
  types.
- Hooks implemented: `hook_token_info_alter()`, `hook_tokens()`.

## What you'd do → where

- **Use the render tokens / understand exactly how the substitution works** →
  [api/tokens.md](api/tokens.md)

## Key facts (real machine names)

- Token pattern: `[<entity_type>:render:<view_mode_machine_name>]`. The `render:` prefix is fixed; the
  suffix is the view-mode machine name with the `<entity_type>.` prefix stripped (stored view mode
  `node.teaser` → `[node:render:teaser]`).
- Hooks: `token_entity_render_token_info_alter()` (registration) and `token_entity_render_tokens()`
  (substitution), both in `token_entity_render.module`.
- Core services used (none redefined): `entity_type.manager` — `getStorage('entity_view_mode')` +
  `getViewBuilder()`; `renderer` — `renderPlain()`.
- Render path: `EntityViewBuilder::view($data['entity'], $view_mode)` → `Renderer::renderPlain()`
  (`renderPlain()` is deprecated in core 10.3 and removed in 12.0 — see api/tokens.md).
- A `render:<view_mode>` token is added only for entity types that another module already exposes as a
  token type (`$data['tokens'][<entity_type>]` must already exist).
