<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Protection (facets_protection) — agent index

Anti-crawler add-on for the **Facets** module. It appends a rotating, time-limited token (`_fp`) to
facet links and blocks any request that carries a facet query parameter (`f`) without a valid token,
returning a minimal page with **HTTP 410 ("Gone")** instead of running the facet query. Package
`Search`. License GPL-2.0-or-later. Version 1.0.2 (dir `1.0.x`). Core `^10.3 || ^11`.

Scope (per README): effective only against bots that replay **previously cached** URLs; it does **not**
stop real-time crawlers. Intended as interim protection until facets migrate to Facets 3 exposed filters.

## Dependencies

- `facets:facets` — Composer `drupal/facets:~2.0.0`. The module protects facet blocks/links this
  provides and cannot function without it.
- No third-party PHP libraries. Front-end JS depends on `core/jquery`, `core/drupal`, `core/once`.

## What it provides (from source)

- **One event subscriber**: `Drupal\facets_protection\EventSubscriber\FacetsProtectionRequestSubscriber`
  (service `facets_protection.request_subscriber`), tagged `event_subscriber`, on `KernelEvents::REQUEST`.
  Decides whether to block and renders the blocking page. → [behavior/request-flow.md](behavior/request-flow.md)
- **One helper service**: `Drupal\facets_protection\FacetsProtectionHelper` (service
  `facets_protection.helper`) — creates/rotates/validates the token, stored in `State` key
  `facets_protection_data`. → [behavior/request-flow.md](behavior/request-flow.md)
- **One settings form**: `Drupal\facets_protection\Form\SettingsForm` (`ConfigFormBase`), route
  `facets_protection.settings` at `/admin/config/search/facets/facets_protection`, permission
  `administer facets_protection settings`, config `facets_protection.settings`.
  → [config/settings.md](config/settings.md)
- **Two theme hooks / templates**: `facets_protection_blocking_site` ("URL changed") and
  `facets_protection_blocking_human_site` ("Are you human?"), each with one variable `url`.
  → [theming/blocking-pages.md](theming/blocking-pages.md)
- **One JS library** `facets_protection/facets_protection` (`js/facets_protection.js`) that rewrites
  facet-widget links to carry the current `_fp` token. → [behavior/request-flow.md](behavior/request-flow.md)
- **Hooks** in `facets_protection.module`: `hook_help`, `hook_preprocess_block` (attaches the library +
  `drupalSettings.facets_protection.token` + cache context to facet blocks), `hook_theme`.
- **Config schema** `facets_protection.settings` (keys `enabled`, `ttl`, `template`). One permission,
  `restrict access: true`. `hook_uninstall` deletes the state token and invalidates the
  `facets_protection` cache tag.

## What it does NOT provide

No entities, no controllers of its own, no plugin types, no Drush commands, no REST resources. The only
route is the admin settings form.

## Install / operate

1. `composer require drupal/facets_protection` (pulls `drupal/facets`).
2. `drush en facets_protection -y`.
3. Grant `administer facets_protection settings` to trusted admins only (`restrict access`).
4. At `/admin/config/search/facets/facets_protection` set the enable toggle, token TTL, and template
   variant. Clear caches after changing settings so facet blocks re-attach the token.
