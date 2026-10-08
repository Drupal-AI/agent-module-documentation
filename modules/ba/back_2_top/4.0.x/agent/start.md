<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Back-2-Top (back_2_top) — agent index

**A configurable, dependency-free vanilla-JavaScript back-to-top button attached site-wide via `hook_page_attachments()`.**

- **Version:** 4.0.x · **Core:** `^10 || ^11` · **Package:** User Interface · **Deps:** none.
- **What it is:** one admin settings form + a page-attachments hook. No entities, no plugins, no services, no Drush, no submodules.
- **Config object:** `back_2_top.settings` — keys `enabled`, `position`, `color`, `opacity`, `size`, `image_type`, `custom_image` (managed-file fid), `show_on_admin`. Schema in `config/schema/back_2_top.schema.yml`; defaults in `config/install/back_2_top.settings.yml`.
- **Route:** `back_2_top.settings` → `/admin/config/user-interface/back-2-top` (perm: `administer site configuration`); menu link `back_2_top_settings` under `system.admin_config_ui`.
- **Form:** `Drupal\back_2_top\Form\Back2TopSettingsForm` (extends `ConfigFormBase`) — `src/Form/Back2TopSettingsForm.php`.
- **Hooks:** `back_2_top_page_attachments()` attaches library `back_2_top/back_to_top` and `drupalSettings.back2Top` when `enabled` (skips admin routes unless `show_on_admin`); `back_2_top_help()`; `back_2_top_uninstall()` deletes the custom-image file.
- **Assets:** `js/back_2_top.js` (`Drupal.behaviors.back2Top` builds `<button class="back-2-top">`, scroll show/hide, animated scroll-to-top), `css/back_2_top.css`.

## Solution docs
- Configuration, config keys, route/permission, and how the JS consumes settings: [agent/config/settings.md](config/settings.md)
