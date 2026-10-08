<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object & shipped view

## Settings form

`src/Form/AdInserterSettingsForm.php` (`ConfigFormBase`, form id `ad_inserter_settings`) at route
`entity.ad_inserter.admin_form` → **`/admin/config/services/ad-inserter`** (menu: *Configuration →
Services*), gated by `administer ad inserter`. It edits one config object, `ad_inserter.settings`,
and exposes a single field:

- `mobile_breakpoint` — `#type => number`. The px width at or below which a viewport counts as
  "mobile" for the loader JS. `submitForm()` saves it to `ad_inserter.settings`.

## Config object & schema

- Object: `ad_inserter.settings`. Install default (`config/install/ad_inserter.settings.yml`):
  `mobile_breakpoint: '600'`.
- Schema (`config/schema/ad_inserter.schema.yml`): `type: config_object` with
  `mobile_breakpoint: type: label`. (Typed `label`, though the form writes a number; the value is
  only used for a JS numeric comparison in `js/ad-inserter-loader.js`.)
- The breakpoint reaches the browser via `hook_page_attachments()` →
  `drupalSettings.ad_inserter.mobile_breakpoint` (see [../plugins/blocks.md](../plugins/blocks.md)).

There is no other configuration. The ad content itself lives in the `ad_inserter` **content entity**
(database), not in config, so ad markup is **not** part of `drush cex` config export.

## Shipped Views view

`config/install/views.view.ad_inserter.yml` installs a view named `ad_inserter` over base table
`ad_inserter` (id/base_field `id`). Its config dependencies list modules `ad_inserter` and **`options`**
(and it uses `views`), so those must be present for the view to import. It provides a ready-made listing
you can adapt; the module's own admin list at `/admin/ad-inserter/list` is the `AdInserterListBuilder`,
independent of this view.

## Install / enable

1. `drush en ad_inserter -y` — pulls core `field` (only declared dependency). `views`/`options` are
   needed only for the bundled view to install cleanly.
2. Set the breakpoint at `/admin/config/services/ad-inserter` (default 600).
3. Author ads at `/admin/ad-inserter/add`, then place a block (see the plugins doc).

No update hooks, no services, no Drush commands, no submodules.
