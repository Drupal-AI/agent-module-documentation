<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trufil (trufil) — agent index
**jQuery-free Views exposed-filter/sort/pager widgets (autocomplete, links, date picker, single checkbox, lists) — a Better Exposed Filters alternative.**

- **Version:** 1.0.x (release 1.0.1)
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** views
- **Plugin:** Views exposed_form plugin `trufil` (`src/Plugin/views/exposed_form/Trufil.php`, extends `InputRequired`).
- **Plugin types:** `TrufilFilterWidget`, `TrufilSortWidget`, `TrufilPagerWidget` (managers `plugin.manager.trufil_{filter,pager,sort}_widget`); widgets under `src/Plugin/trufil/{filter,sort,pager}/`.
- **Alter hook:** `hook_trufil_options_alter($options, $view, $display)`.
- **Security:** no routes, no permissions, no services beyond plugin managers, no network/DB mutation. Configured entirely in the Views UI under Views' `administer views` permission; purely a front-end rendering layer.

See [plugins/widgets.md](plugins/widgets.md)
