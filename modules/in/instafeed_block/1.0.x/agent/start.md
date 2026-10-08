<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instafeed Block (instafeed_block) — agent index

A single **block plugin** (`id: instafeed_block`, admin label "Instafeed Block") that renders an
Instagram feed **entirely client-side** using the external **instafeed.js** library. Version
**1.0.12**, core `^9 || ^10 || ^11`, package Media. Maintainer: Andreas Kleve. No dependent
modules; the only hard requirement is the JS library on disk.

## What it actually does (confirmed from source)

- The block outputs one empty container `<div id="instafeed"></div>` and **attaches**
  `drupalSettings.instafeed_block` = `{ accessToken, template, limit, filters }` plus the
  instafeed.js library and (unless disabled) the module CSS. See
  `src/Plugin/Block/InstafeedBlock.php` `build()`.
- `js/instafeed-block.js` reads those settings and runs `new Instafeed({...}).run()`. **The
  visitor's browser** — not Drupal — calls the Instagram Graph API with the access token and
  renders the returned posts into the container. Drupal never fetches feed content server-side.
- The **Instagram access token is stored in Drupal's State API** (`instafeed_block.access_token`),
  NOT in config. It is entered on a settings form and then emitted into `drupalSettings` in the
  page HTML for instafeed.js (which runs in the visitor's browser) to call the Instagram Graph API.

## Files / structure

- `src/Plugin/Block/InstafeedBlock.php` — the block plugin + its block-instance config form
  (`blockForm`/`blockSubmit`). Config keys: `template`, `limit`, `filters`, `layout`,
  `disable_css`, `classes`. Injects the `state` service.
- `src/Form/InstafeedBlockSettingsForm.php` — global settings form (route
  `instafeed_block.settings_form`, path `/admin/config/media/instafeed-block`, permission
  `administer site configuration`). One field: the Instagram Access Token; saved to State,
  then `drupal_flush_all_caches()`.
- `instafeed_block.module` — `hook_help`, and a **cron token-refresh** path
  (`instafeed_block_cron` → `instafeed_block_update_token` → `instafeed_block_fetch_new_token`)
  that cURLs `https://graph.instagram.com/refresh_access_token`. Guarded by the
  `production_url` setting matching the current host (see below). TLS verification is left at
  cURL defaults (enabled).
- `instafeed_block.install` — `hook_requirements`/`hook_install` warn if
  `/libraries/instafeed.js/dist/instafeed.min.js` is missing; `hook_uninstall` deletes the three
  State keys.
- `instafeed_block.libraries.yml` — declares `instafeed.js` (the external lib), the module JS, base
  CSS, and three grid layout CSS files (`instafeed-block-layout-2|3|4`).
- No config schema, no permissions of its own, no Drush commands, no submodules, no services.yml.

## Key facts an agent needs

- **Requires a manually-installed JS library.** `stevenschobert/instafeed.js` v2.0.0 must land at
  `/libraries/instafeed.js/dist/instafeed.min.js`. `hook_requirements` flags it on the status
  report if absent; the block renders nothing without it.
- **Instagram credential reality.** Needs a Facebook app, a Business/Creator Instagram account, and
  an access token (display-only scope). Tokens expire (~60 days) and must be refreshed.
- **Automatic refresh is production-gated.** `instafeed_block_cron` only refreshes the token when
  `$settings['production_url']` is set in settings.php AND equals the current request host; set it
  on exactly one environment or a refresh on staging will invalidate the live token. The
  "expiration date" shown on the settings form is only an estimate from when you pasted the token.
- **Block config knobs:** `limit` (1–50, fetches +20 then filters client-side), `filters`
  (image/video/album — album shows only the first item), `template` (raw single-line HTML markup
  interpolated by instafeed.js, e.g. `{{link}}`, `{{image}}`, `{{caption}}`, `{{model.media_url}}`),
  `layout` (1–4 posts/row via a grid CSS file), `disable_css`, `classes` (extra classes on the div).
- **Failure mode is silence.** If the token expires or the API is unreachable, the block renders
  empty with no error surfaced to editors.

## Subdocs

- `agent/blocks/instafeed-block.md` — the block plugin, its settings, and the client-side render path.
- `agent/config/settings-and-token.md` — the global settings form, State storage, and cron refresh.
