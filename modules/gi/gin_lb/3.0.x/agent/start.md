<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Layout Builder — agent index

Re-skins Layout Builder (plus its off-canvas dialogs and Media Library) with Gin styling while
the site is still in its front-end theme. No plugins, no permissions, no Drush, no entities.

- **Settings form, config object `gin_lb.settings` and every key** →
  [configure/settings.md](configure/settings.md)
- **The two alter hooks it invites (`hook_gin_lb_*_alter`)** →
  [hooks/alter-hooks.md](hooks/alter-hooks.md)
- **How the re-skin works: context validator, `#gin_lb_form`, `__gin_lb` suggestions,
  `glb-` prefix, `glb_classes()`** →
  [theming/mechanism.md](theming/mechanism.md)
- **Services you can call (`gin_lb.context_validator`, Twig extension, utility)** →
  [api/services.md](api/services.md)

Key facts:

- `configure: gin_lb.gin_lb_settings_form` → path `/admin/config/gin_lb/settings`,
  permission `administer site configuration`.
- Config object: **`gin_lb.settings`**, keys `toastify_loading`, `enable_preview_regions`,
  `hide_discard_button`, `hide_revert_button`, `save_behavior`.
- Hard dependencies: `layout_builder` (core) + `gin_toolbar`; Composer also pulls `drupal/gin`.
  **Conflicts with `drupal/lb_claro`.**
- It intentionally **does nothing** when the active theme is Gin or a Gin sub-theme
  (`ContextValidator::isValidTheme()` returns FALSE).
- Submodule: `gin_lb_plus` (docs under `modules/gin_lb/modules/gin_lb_plus/3.0.x/`).
