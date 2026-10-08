<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activity Stream (actstream) — agent index

**Aggregates external web activity into Drupal `actstream_item` content entities, shown as *Actor VERB Object* statements.**

- **Version:** 2.1.x
- **Core:** ^10.3 || ^11 || ^12
- **Routes:** `/actstream` (site-wide), `/user/{user}/actstream` (per-user), `/actstream/{actstream_item}` (canonical), `/user/{user}/edit/actstream` (accounts form) — all gated by `access content`.
- **Permissions:** `administer actstream types`, `administer actstream` (both restrict access).
- **Services:** `actstream.*` connector helpers; sub-modules add service integrations via hooks.
- **API:** `hook_actstream_services()`, `hook_form_actstream_accounts_form_alter()`, `hook_actstream_SERVICE_items_fetch()`, `hook_actstream_SERVICE_items_alter()`, `hook_preprocess_actstream_item()` (see `actstream.api.php`). Fetch via cron or the `actstream:fetch` Drush command.
- **Security:** Listing pages load only published items with `accessCheck(TRUE)` (public feeds, no cross-user leak).

See [extend/services.md](extend/services.md).
