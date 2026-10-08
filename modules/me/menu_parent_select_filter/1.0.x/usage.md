<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a live filter textbox to the 'Parent link' select on menu link forms, making huge parent-menu lists usable.

---

`hook_form_alter()` (`menu_parent_select_filter.module`) detects the `menu][link][menu_parent` select on menu link forms, changes its `#type` to the custom `select_filter` form element and attaches the `menu_parent_select_filter/script` JS library. The element plugin `SelectFilter` (`src/Element/SelectFilter.php`, `@FormElement("select_filter")`) extends core `Select` and, in a process callback, wraps the original select and injects a sibling `menu_filter` textfield (name `menu[menu_filter]`, class `menu-parent-filter`); the JS filters the option list as the user types. A `hook_module_implements_alter()` moves this module's `form_alter` to the end so it runs after other alters. No config, permissions, routes or services - purely a client-side usability enhancement of an existing form element.

---

- Filter a very long 'Parent link' menu dropdown by typing part of the label.
- Speed up placing new menu links on sites with hundreds of menu items.
- Reduce scrolling through deeply nested menu trees when choosing a parent.
- Improve editor UX on large navigation menus without changing data.
- Apply automatically to any menu link form (no configuration needed).
- Keep the original select's value/behaviour while adding a filter box.
- Run the alter last so it composes cleanly with other menu form alterations.
- Provide a reusable `select_filter` form element for the parent-menu widget.
- Avoid custom autocomplete backends - filtering is purely client-side.
- Help content teams manage complex information architectures.
- Work on Drupal 8/9/10 with no dependencies beyond core.
- Cut mis-selection errors by narrowing visible options.
- Enhance accessibility of large select lists with a search field.
- Style the filter box via the `menu-parent-filter` class.
- Require no permission changes; it rides the existing menu form access.
- Complement modules that generate many menu links programmatically.
