<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iconify Icons (iconify_icons) — agent index

An **icon provider for Drupal core's Icon API** (added in Drupal 11.1). It plugs
[Iconify](https://iconify.design/)'s ~200k open-source icons into any consumer of the Icon API
(the contrib **UI Icons** module — `ui_icons_field`, `ui_icons_menu`, `ui_icons_text` — being the
usual front-ends). You pick which Iconify **collections** to expose on a settings page; each
selected collection becomes a UI icon pack whose icons render as `<img>` tags served directly from
the Iconify API.

- Core `>=11.1.0` only (no Drupal 10). No module dependencies declared; core's Icon API is the
  integration point, UI Icons is the recommended (optional) front-end.
- Configure route: `iconify_icons.settings` at `/admin/config/iconify_icons/settings`, gated by the
  core permission `administer site configuration` (no module-specific permission).
- Defines no plugin *type*, no drush commands, no config schema files.

## What you'd do

- **Choose which Iconify collections are offered** → [configure/settings.md](configure/settings.md)
- **Understand the `iconify` extractor and how icon packs are generated/rendered** → [plugins/icon-extractor.md](plugins/icon-extractor.md)
- **Call the Iconify API / icon cache services from your own code** → [api/services.md](api/services.md)
- **Integrator hooks (UI Icons field/text form links, help)** → [hooks/integration.md](hooks/integration.md)

## Key facts

- **Config object:** `iconify_icons.settings`, single key `collections` (array of `collection_id => collection_id`).
- **Services:** `iconify_icons.iconify_api` (`Drupal\iconify_icons\IconifyApi` → `IconifyApiInterface`);
  `iconify_icons.icons_cache` (`Drupal\iconify_icons\IconsCache` → `IconsCacheInterface`).
- **Extractor plugin:** id `iconify` (`src/Plugin/IconExtractor/IconifyExtractor.php`, attribute
  `#[IconExtractor]`), an instance of core's `IconExtractor` plugin type (`plugin.manager.icon_pack`).
- **Icon pack generation:** `hook_icon_pack_alter()` in `iconify_icons.module` turns each configured
  collection into a UI icon pack (pack id = normalized collection id, e.g. `mdi`, `fa_solid`).
- **Rendered icon markup:** `<img class="{{ class }}" src="{{ source }}?{{ params|url_encode }}" />`
  where `source = https://api.iconify.design/{collection}/{icon}.svg` (client-side fetch, not inline).
- **API base:** hardcoded `https://api.iconify.design` endpoints (`/search`, `/collection`,
  `/collections`, `/{c}/{i}.svg`, `/version`) — not admin-configurable.
- **Form id:** `iconify_icons_settings` (`src/Form/Settings.php`, extends `ConfigFormBase`).
- **Libraries:** `iconify_icons/default` (js + css), `iconify_icons/gin` (Gin admin theme css).
- **Menu link:** `iconify_icons.settings` under `system.admin_config_ui`.
