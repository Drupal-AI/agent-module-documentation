<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ad Inserter – Ad Manager (ad_inserter) — agent index

An ad manager built on **one content entity type** (`ad_inserter`). Each entity stores an ad
**name**, an optional **machine_name**, a **body** (raw HTML / ad-network JS), a **screen** target
(`all`/`mobile`/`desktop`) and a **status** flag. Ads are placed via **two block plugins**; a small
JS loader hides/shows blocks per a configurable mobile breakpoint. Depends only on core **`field`**.
Core requirement `^9 || ^10 || ^11`, PHP `^8.1`. License GPL-2.0-or-later. Version `1.0.0-rc8`.

- **The entity, its base fields, storage, access handler, list builder, routes & permission** →
  [entity/ad_inserter.md](entity/ad_inserter.md)
- **The two block plugins, the loader library, screen targeting & the `hook_ad_inserter_alter_status` hook** →
  [plugins/blocks.md](plugins/blocks.md)
- **The settings form, config object/schema, and the shipped Views view** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Content entity** `ad_inserter` (`src/Entity/AdInserter.php`, `@ContentEntityType`): base table
  `ad_inserter` + data table `ad_inserter_field_data`, `admin_permission = "administer ad inserter"`,
  owner (`uid`) via `EntityOwnerTrait`, published via `EntityPublishedTrait`. Base fields:
  `name` (label), `machine_name`, `body` (`string_long`), `screen` (`list_string`: all/mobile/desktop),
  `status` (boolean), `created`, `changed`, `data` (map).
- **Handlers:** access `AdInserterAccessControlHandler`, storage `AdInserterStorage`
  (adds `loadByMachineName()`), list builder `AdInserterListBuilder`, forms
  `AdInserterForm`/`AdInserterDeleteForm`, settings form `AdInserterSettingsForm`.
- **Blocks:** `ad_inserter` (`AdInserterBlock`, select by entity ref) and `ad_inserter_machine_name`
  (`AdInserterMachineNameBlock`, reference by machine name), both extending `AdInserterBaseBlock`.
- **Routes** (`ad_inserter.routing.yml`): collection/add/edit/delete/admin_form all require
  `administer ad inserter`; canonical view requires only `access content`.
- **Permission** (`ad_inserter.permissions.yml`): a single `administer ad inserter`.
- **Theme/hooks** (`ad_inserter.module`): `hook_theme` (`ad_inserter` → `templates/ad_inserter.html.twig`),
  `template_preprocess_ad_inserter()`, `hook_theme_suggestions_ad_inserter()` (`ad_inserter__<id>`),
  `hook_page_attachments()` (exposes `mobile_breakpoint` to `drupalSettings`).
- **Config:** object `ad_inserter.settings` (`mobile_breakpoint`), schema in `config/schema/`,
  a shipped Views view `views.view.ad_inserter` (needs `views` + `options`).
- **Library:** `ad_inserter/loader` → `js/ad-inserter-loader.js` (jQuery + once + drupalSettings).
- No Drush, no services.yml, no submodules, no plugin *types*, no outbound HTTP.

## Operate it

1. Enable: `drush en ad_inserter -y` (pulls core `field`).
2. Create ads at `/admin/ad-inserter/add`; manage at `/admin/ad-inserter/list`.
3. Set the mobile breakpoint at `/admin/config/services/ad-inserter`.
4. Place an "Ad Inserter" (or "…by machine name") block in a region and choose the ad.
