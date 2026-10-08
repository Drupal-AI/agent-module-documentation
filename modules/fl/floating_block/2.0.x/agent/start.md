# Floating Block — agent index

Pins page regions (chosen by jQuery/CSS selector) in a fixed position while scrolling, like
core sticky table headers. Depends on core `block`. Config schema provided; no permissions of
its own, no Drush, no plugin types.

- **Admin form, the `selector|key=value` syntax, config keys, the helper service, front-end wiring** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Configure route: `floating_block.admin_settings` → `/admin/config/user-interface/floating-block`
  (permission `administer site configuration`).
- Config object `floating_block.settings`: `blocks` (sequence of per-block string maps) and
  `min_width` (int; viewport width below which floating is off, 0 = always on).
- `hook_page_attachments()` attaches `floating_block/floating_block` (jQuery + drupalSettings) and
  `drupalSettings.floatingBlock.{blocks,min_width}` ONLY when ≥1 block is configured; the config
  object is added as a cacheable dependency.
- Service `floating_block` (`Drupal\floating_block\Helper` implements `HelperInterface`):
  `convertTextToArray(string)` / `convertArrayToText(array)` translate the textarea format ↔ stored array.
