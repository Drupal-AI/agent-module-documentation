<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Parent Select Filter - agent index

Adds a client-side filter textbox above the 'Parent link' select on menu link forms. No deps beyond
core, no config/routes/permissions.

Key facts:
- `hook_form_alter()` swaps the `menu][link][menu_parent` select `#type` to `select_filter` and attaches
  `menu_parent_select_filter/script`.
- `src/Element/SelectFilter.php` (`@FormElement("select_filter")`) extends core `Select`; process callback
  wraps the select and injects a `menu_filter` textfield; JS filters options as you type.
- `hook_module_implements_alter()` runs this module's form_alter last. Version dir `1.0.x`.
