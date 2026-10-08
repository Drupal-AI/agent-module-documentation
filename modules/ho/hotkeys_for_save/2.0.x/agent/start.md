<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hotkeys for Save — agent index

Press **Ctrl+S** (Win/Linux) or **Cmd+S** (Mac) to click a form's Save button and suppress the
browser "Save As" dialog. Pure JS behavior + one permission. No settings form, no configure
route, no config, no Drush, no plugins.

Key facts:
- Library `hotkeys_for_save/hotkeys_for_save` (deps `core/drupal`, `core/once`) is attached in
  `hook_page_attachments()` **only if** the user has permission `use hotkeys for save`.
- The permission is granted to the `administrator` role on install (`hook_install`).
- Button click priority: "save & continue" ids first, then plain "save" ids, then Gin's
  `data-drupal-selector` fallbacks. Also hooks CKEditor keydown.

- **How the behavior works (key handling, button priority, CKEditor)** → [api/behavior.md](api/behavior.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)
