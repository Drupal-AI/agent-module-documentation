<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Parent Form UI turns the single long "parent menu item" dropdown into a series of cascading select boxes on the node edit form and the menu-link content form.

---

Menu Parent Form UI is a client-side (JavaScript) enhancement for choosing a parent menu item. Core renders the parent selector as one `<select>` that flattens the entire menu tree into a single indented list, which becomes unusable on large or deep menus. This module reads that list, extracts the hierarchy from the leading-dash indentation Drupal adds to each option, hides the original select, and builds cascading dropdowns (choose the menu, then the parent, then the sub-parent, one level at a time) while keeping the original select synced so the form submits normally. It alters two forms: `node` forms (the "Menu settings" section) and `menu_link_content` add/edit forms. Version 1.1.0 adds configurable CSS selectors so the injected dropdowns can be placed correctly even when the form is not themed with Claro. It depends only on core Menu UI and is configured at `menu_parent_form_ui.settings` (route `/admin/config/user-interface/menu-parent-form-ui`, permission "administer site configuration").

Use it on any site whose editors struggle with the giant flat parent-menu dropdown. It is purely a content-editing/form-UI convenience; it does not change menus, routing, or access, and adds no permissions of its own.

---

- Replace the single combined parent-menu dropdown with cascading select boxes.
- Make choosing a parent item usable on very large menus.
- Make choosing a parent item usable on deeply nested menus.
- Improve the "Menu settings" parent selector on node edit forms.
- Improve the parent selector on the menu link add form (Structure > Menus > Add link).
- Improve the parent selector on the menu link edit form.
- Let editors pick the menu, then the parent, then the sub-parent step by step.
- Pre-select the current parent's trail so editing an existing link starts in context.
- Show a "Currently Selected Parent" label so editors keep their bearings.
- Avoid scrolling through hundreds of indented options in one list.
- Reduce mis-selection of the wrong parent in similarly named branches.
- Speed up bulk menu-link creation under a known parent branch.
- Keep the original form submission behavior (the hidden native select stays in sync).
- Work without server round-trips (all cascade logic is client-side).
- Configure the CSS selector where the new selects are injected on the menu link form.
- Configure the CSS selector where the new selects are injected on the node form.
- Adapt the widget placement to non-Claro admin themes via the settings form.
- Enable a better menu-editing experience with no per-content-type configuration.
- Apply automatically to all node types that expose menu settings.
- Depend only on core Menu UI (no external libraries).
- Leave menu structure and access control unchanged.
