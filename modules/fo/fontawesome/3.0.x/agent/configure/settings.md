# Configure Font Awesome loading

![Font Awesome settings form](../../../../../../../screenshots/fontawesome/3.0.x/settings.png)

Settings form `\Drupal\fontawesome\Form\SettingsForm` at `/admin/config/content/fontawesome`
(route `fontawesome.admin_settings`, permission `administer site configuration`). Stored in
`fontawesome.settings` (config schema `fontawesome.settings`).

## Key settings (`fontawesome.settings.yml`)
- `method` — `svg` (SVG-with-JS, default) or `webfonts`.
- `tag` — HTML tag used for icons (default `i`).
- `load_assets` — let the module load the FA assets on every page (default true).
- `use_cdn` — serve from CDN (true) vs a local library install (false).
- `external_svg_location` — CDN JS URL (default `https://use.fontawesome.com/releases/v6.4.2/js/all.js`).
- `external_svg_integrity` — optional SRI hash for the CDN asset.
- `use_shim` / `external_shim_location` — v4 compatibility shim.
- `allow_pseudo_elements` — enable CSS pseudo-element icons (webfonts).
- `use_solid_file`, `use_regular_file`, `use_light_file`, `use_brands_file`,
  `use_duotone_file`, `use_thin_file`, `use_sharpregular_file`, `use_sharplight_file`,
  `use_sharpsolid_file`, `use_custom_file` — toggle which style files load.
- `bypass_validation` — skip icon-name validation (for custom kits).

## Local install
Set `use_cdn: false` and place the library at `libraries/fontawesome` — see
[drush/commands.md](../drush/commands.md) for `drush fa:download`.

Deploy as config: export `fontawesome.settings.yml` and `drush config:import`.
