<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons (cookies_addons) — agent index

Add-on bundle for the **COOKiES** consent framework. The top-level `cookies_addons` module ships
**no code** — `cookies_addons.info.yml` only declares `package: COOKiES`, `core_version_requirement:
^9 || ^10 || ^11`, and `dependencies: cookies:cookies`. All behavior lives in six submodules.
Version **1.3.3**. License GPL-2.0-or-later. No permissions, services, Drush, plugins or routes at
the top level.

## What it is

A meta/container project. Enabling `cookies_addons` alone does nothing observable; you enable the
submodule(s) for the content type you want to gate. Each submodule reuses COOKiES `cookies_service`
config entities as the consent gate and the COOKiES JS API (`cookiesjsrUserConsent` event,
`cookiesOverlay`).

## Submodules (each documented in its own nested tree under `modules/<name>/1.3.x/`)

- **cookies_addons_blocks** — gate placed Drupal blocks by block ID. Textarea settings
  (`block_id|service`) at `/admin/config/system/cookies-addons-blocks`; `preprocess_block` swaps the
  block for a placeholder; POST route `cookies_addons_blocks.get_block` re-renders on consent.
  → [../modules/cookies_addons_blocks/1.3.x/agent/start.md](../modules/cookies_addons_blocks/1.3.x/agent/start.md)
- **cookies_addons_paragraphs** — gate Paragraphs by paragraph ID (`paragraph_id|service`) at
  `/admin/config/system/cookies-addons-paragraphs`; depends on `paragraphs`.
  → [../modules/cookies_addons_paragraphs/1.3.x/agent/start.md](../modules/cookies_addons_paragraphs/1.3.x/agent/start.md)
- **cookies_addons_views** — gate a view display (`view|display|service`) at
  `/admin/config/system/cookies-addons-views`; depends on `views`; reads the `cookiesjsr` cookie
  server-side to decide gating.
  → [../modules/cookies_addons_views/1.3.x/agent/start.md](../modules/cookies_addons_views/1.3.x/agent/start.md)
- **cookies_addons_fields** — gate any entity field via a per-formatter third-party setting on
  Manage display; depends on `cookies_addons`. The AJAX render route does full entity + field access
  checks.
  → [../modules/cookies_addons_fields/1.3.x/agent/start.md](../modules/cookies_addons_fields/1.3.x/agent/start.md)
- **cookies_addons_embed_iframe** — text-format filter "Block iframes" that rewrites non-YouTube
  `<iframe src>` to `data-src`; installs the built-in `iframe` cookies service + `iframes` group.
  → [../modules/cookies_addons_embed_iframe/1.3.x/agent/start.md](../modules/cookies_addons_embed_iframe/1.3.x/agent/start.md)
- **cookies_addons_embed_video** — text-format filter "Block YouTube videos"; defers to the COOKiES
  Video (`cookies_video`) placeholder library. Depends on `cookies:cookies_video`.
  → [../modules/cookies_addons_embed_video/1.3.x/agent/start.md](../modules/cookies_addons_embed_video/1.3.x/agent/start.md)

## Mechanism (shared pattern)

- Placeholder submodules (blocks/paragraphs/views/fields): a `preprocess_*` hook replaces the
  element with a `<div class="cookies-addons-*-placeholder" data-cookies-service=… data-*-id=…>` and
  attaches the submodule's JS library. The JS `Drupal.behaviors.*` listens for
  `cookiesjsrUserConsent`; on accept it POSTs the submodule route to fetch the real render array and
  `ReplaceCommand`s the placeholder, on deny it calls `cookiesOverlay(service)`.
- Filter submodules (embed_iframe/embed_video): a `@Filter` plugin (`process()`) uses `Html::load()`
  to find `<iframe>`s whose `src` matches a regex helper (`_cookies_addons_embed_*_is_*`), moves
  `src`→`data-src`, adds a marker class, and attaches a JS library that restores `src` after the
  `iframe`/video service is consented.
- Gating config is plain textarea text parsed with `preg_split('/\r\n|\r|\n/', …)` + `explode('|')`;
  requests with method `POST` are treated as already-loading and skip gating.

Privacy/consent tool (GDPR/ePrivacy) — its job is to withhold third-party content and trackers until
consent. It is **not** an access-control system.
