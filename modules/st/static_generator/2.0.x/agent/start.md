<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Generator (static_generator) — agent index

**Generates a static HTML copy of a Drupal site with ESI fragments and rsync deployment.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11 — deps include node, workflows, content_moderation, field_ui
- **Configure:** `/admin/config/static_generator` (route `static_generator.settings`)
- **Service:** `static_generator` (`src/StaticGenerator.php`) — render (Guzzle/Core) → write HTML → rsync assets/code; queue worker `PageGenerator` on moderation transitions.
- **Routes** (all `_permission: administer static generator`): `/node/{nid}/gen`, `/media/{mid}/gen`, `/node/{node}/sg`, `/media/{media}/sg`, settings, per-type config. **No delete route** (Drush only).
- **Permissions:** `administer static generator`, `generate static pages` (both restrict access).
- **Drush:** `sg`, `sgp`, `sgpt`, `sgb`, `sgf`, `sgr`, `sgd`. **Events:** `static_generator.modify_markup`, `.modify_esi_markup`.

**Security:** No anonymous/low-priv surface — every web route requires `administer static generator`; node/media ids reach only page rendering, never a shell. All `exec()` (rsync/mkdir/rm) are admin-config build tooling — by design. Admin-trust caveats only: unquoted shell strings from config, and `eval()` of the admin `guzzle_options` config (`StaticGenerator.php:1686`, can set `verify=>false`). Not request-reachable.

See [drush/commands.md](drush/commands.md)
