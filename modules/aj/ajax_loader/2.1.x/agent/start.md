<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Loader — agent index

Replaces Drupal's core AJAX throbber with a configurable animated spinner. One settings
form, one config object (`ajax_loader.settings`), a `Throbber` plugin type with 12 built-ins.
No dependencies, no Drush commands.

- **Configure the throbber** (settings form, config keys, defaults, `drush cset`, throbber IDs) → [configure/ajax_loader.md](configure/ajax_loader.md)
- **Program against it** (the `ajax_loader.throbber_manager` service, how attachment works, writing a custom `@Throbber` plugin) → [api/ajax_loader.md](api/ajax_loader.md)

Quick facts:
- Config form: `/admin/config/user-interface/ajax-loader` (route `ajax_loader.settings`).
- Permission: `administer ajax loader`.
- Config object: `ajax_loader.settings` (keys: `throbber`, `hide_ajax_message`, `always_fullscreen`, `show_admin_paths`, `throbber_position`).
