<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ephoto DAM (ephoto_dam) — agent index

CKEditor 5 connector for the **Ephoto Dam** SaaS digital-asset-management platform. A toolbar
button opens the Ephoto asset chooser (served by your Ephoto server) and inserts placeholder
`<img>` markup; a text-format **filter** rewrites that markup into final `<img>`/`<iframe>` embeds
on render. Package "Ephoto Dam". Depends on core `ckeditor5` and `system`. Core `^10 || ^11`.
License GPL-2.0-or-later. Installed release 8.x-5.3.

- **Config form, CKEditor plugin settings, config object/schema** → [config/settings.md](config/settings.md)
- **CKEditor 5 plugin, JS chooser flow, and the render filter** → [plugins/ckeditor5-filter.md](plugins/ckeditor5-filter.md)
- Submodule **Ephoto DAM Field** (asset field type) is documented in its own tree at
  `modules/ephoto_dam_field/8.x-5.x/`.

## What it actually is

- One admin form: `Form\ConfigurationForm` at route `ephoto_dam.admin_settings`
  (`/admin/config/ephoto_dam`), permission **`administer site configuration`**. It saves a single
  value — `server_url` — into config object **`ephoto_dam.settings`**. There is **no API key** in
  Drupal config; Ephoto auth is obtained at runtime in the browser.
- One CKEditor 5 plugin: `Plugin\CKEditor5Plugin\EphotoDam` (id **`ephoto_dam_simplebox`**,
  toolbar item `simpleBox`), configurable per text format (captions, caption format, zoom, and
  image/video/document display sizes). Defined in `ephoto_dam.ckeditor5.yml`.
- One text-format filter: `Plugin\Filter\EphotoDam` (id **`ephoto_dam_2`**, title "Ephoto Dam",
  `TYPE_TRANSFORM_IRREVERSIBLE`). Rewrites the editor's placeholder markup into the final embed.
- JS: bundled `js/build/plugin.js` (compiled from `js/ckeditor5_plugins/plugin/src/*`) plus
  `js/ephoto_dam.js` (front-end zoom). Loads `<server_url>api/apiJS.js` from the Ephoto server at
  runtime to render the chooser.
- **No routes besides the settings form. No permissions declared. No services, no entities, no
  Drush.**

## Dependencies

- Core `ckeditor5`, core `system` (from `ephoto_dam.info.yml`). No Composer `require`, no PHP
  library declared. Ephoto's own JS is fetched from the configured `server_url` at runtime.

## Key files

- `ephoto_dam.info.yml`, `ephoto_dam.routing.yml`, `ephoto_dam.links.menu.yml`,
  `ephoto_dam.libraries.yml`, `ephoto_dam.ckeditor5.yml`, `ephoto_dam.module`
- `config/schema/ephoto_dam.schema.yml`
- `src/Form/ConfigurationForm.php`, `src/Plugin/CKEditor5Plugin/EphotoDam.php`,
  `src/Plugin/Filter/EphotoDam.php`
- `js/ckeditor5_plugins/plugin/src/ephotodampress.js` (chooser + Ephoto API calls),
  `ephotoDamUI.js` (button + caption fetch), `ephotodamadd.js` (command/schema)
