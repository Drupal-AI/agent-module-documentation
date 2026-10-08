<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Childfocus (notfound.org) (childfocus_notfound) — agent index

Turns the 404 page into a **notfound.org** missing-child appeal (a Child Focus / Belgian
initiative). Ships one **block plugin** (`childfocus_notfound`) that renders an `<iframe>` to
`https://notfound-static.fwebservices.be/<lang>/404?key=<key>`, one **block-visibility condition**
(`childfocus_notfound`, "Show in page not found") that is TRUE on 404 responses, and a settings
form for the site's notfound.org `key` and a language fallback. On install it auto-places the
block in the `content` region of the default theme, gated by that condition.

- Depends on core `block`. `core_version_requirement: ^11` — Drupal 11 only.
- Configure route: `childfocus_notfound.admin_settings` → `/admin/config/childfocus_notfound`
  (permission `administer site configuration`; menu under `system.admin_config_system`).
- No custom permissions, no drush commands, defines no plugin types. Provides config schema.

Solution docs:
- **Set the notfound.org key / language fallback** → [configure/settings.md](configure/settings.md)
- **Understand the 404 block, the auto-placed block, and the "page not found" visibility
  condition** → [blocks/childfocus_notfound.md](blocks/childfocus_notfound.md)

Key facts:
- Config object `childfocus_notfound.settings`, keys: `key` (string), `fallback_langcode`
  (`en`/`nl`/`fr`, default `en`), `langcode` (from `config/install`).
- Block plugin id `childfocus_notfound` — class `Plugin\Block\ChildfocusNotfound`.
- Condition plugin id `childfocus_notfound` — class `Plugin\Condition\ChildfocusPageNotFound`,
  config key `show_on_page_not_found`; adds cache context `url.path`.
- Install hook `childfocus_notfound_install()` creates a `block` entity id `childfocus_notfound`.
- Iframe locale map: current UI langcode `en/fr/nl` → `en-BE/fr-BE/nl-BE`, else the fallback.
