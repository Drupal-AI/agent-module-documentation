<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Active menu item by path — agent orientation

Presentational module: flags menu links as active-trail by path substring match.

Key file: `active_menu_item_by_path.module`
- `active_menu_item_by_path_preprocess_menu()` — for menus in `allowed_types`, adds `url.path` cache context and recursively sets `in_active_trail` when `str_contains($current_alias, $url)`; de-highlights `<front>` unless path is `/node/1`.
- `src/Form/ActiveMenuItemByPathSettingsForm.php` — checkboxes of menus to enable.

Security posture: none relevant (no routes with data, admin form gated by `access active menu settings`, no user input reflected). Caveat to note: substring matching can over-highlight.
