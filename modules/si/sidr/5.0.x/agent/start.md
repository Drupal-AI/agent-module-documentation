# Sidr — agent index

Configurable "trigger" blocks that slide a target element in/out using the jQuery Sidr library —
off-canvas / responsive menus. One block plugin, one global settings form, one theme hook. No
permissions of its own, no Drush, no plugin types. Needs the third-party jQuery Sidr JS lib installed
separately.

- **Global settings + per-block trigger options (every config key)** →
  [configure/settings.md](configure/settings.md)
- **Theme hook `sidr_trigger`, template variables, the `data-sidr-options` attribute** →
  [theming/trigger.md](theming/trigger.md)

Key facts:
- Block plugin id `sidr_trigger` (admin label "Sidr trigger button block"). Placed via Block layout;
  block form has Basic + Advanced groups.
- Global config `sidr.settings` (route `sidr.settings` at `/admin/config/user-interface/sidr`,
  permission `administer site configuration`): `sidr_theme` (bare/light/dark), `close_on_escape`,
  `close_on_blur`. Install defaults: dark + both close flags true.
- Libraries: `sidr/behaviors` (the module's `sidr.js`/`sidr.css`) depends on `sidr/sidr` which loads
  `/libraries/jquery.sidr/dist/jquery.sidr.min.js` (install via Composer Merge Plugin / Asset
  Packagist). Theme libs `sidr/sidr.bare|light|dark`.
- Config schema `sidr.schema.yml` defines `sidr.settings` and the block settings
  (`block.settings.sidr_trigger`).
