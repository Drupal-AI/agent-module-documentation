<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Selectify enhances Drupal's select, radio and checkbox form controls with modern, keyboard- and ARIA-aware widgets, applied through field widgets, Views exposed filters, plain Form API selects, and (optionally) Webform.

---

Install with `composer require drupal/selectify` and enable it (`drush en selectify -y`); it requires Drupal 10 or 11, PHP 8.1+, and core's Views and Field modules. All global options live at **Configuration → Selectify** (`/admin/config/selectify/settings`, permission **administer selectify settings**), which is organised into independent sections. Radio buttons and checkboxes are styled **site-wide** from there — pick a style (toggle switch or traditional), shape (circle/square), size (small/medium/large), and one of seven accent colors in light or dark mode, configured separately for the front-end and for admin pages. Select elements are enhanced through four separate paths: **field widgets** are chosen per field on *Manage Form Display* (Selectify Dropdown, Taggable, With Search, With Checkbox, or Dual List — for list and single-bundle entity-reference fields); **Views exposed select filters** can be turned off, given one site-wide widget, or set per view/display; **Form API selects** on any other form are enabled with a master switch and then targeted either by CSS-selector rules or per discovered form (Selectify records eligible forms as you visit their pages, and always skips AJAX-dependent admin forms such as Views UI, Layout Builder and Field UI); and **Webform** submission selects (including composites like Select Other and Entity Select) are handled by the separate `selectify_webform` submodule, which needs the Webform contrib module and merges its options into the same settings form. You can suppress Selectify entirely on chosen pages with the "Additional pages to disable" path patterns (wildcards supported) or by disabling it on all admin routes. Developers can steer behaviour with three alter hooks (`hook_selectify_widget_alter`, `hook_selectify_element_alter`, `hook_selectify_is_applicable_alter`) and theme each widget via its `select--selectify-*.html.twig` template or CSS custom properties. The native `<select>` stays in the page for submission, so nothing about form processing changes.

---

- Make a long select list searchable with type-ahead filtering.
- Add a tag-style multi-select that shows chips for chosen values.
- Offer a dual-list (available/selected) picker for bulk multi-select.
- Add explicit checkboxes inside a dropdown for clear selection state.
- Enhance an entity-reference or list field via Manage Form Display.
- Improve a Views exposed select filter's usability.
- Apply one select style site-wide across all Views exposed filters.
- Set different Selectify widgets per view display.
- Enhance a plain Form API `<select>` on a custom form.
- Target specific selects by CSS selector (id, class, name, attribute).
- Enhance select elements on Webform submission forms.
- Style Webform composite selects (Select Other, Entity Select, Likert).
- Restyle all radio buttons as toggle switches site-wide.
- Restyle all checkboxes with circle or square shapes and size variants.
- Use different accent colors on the front-end versus admin pages.
- Switch Selectify between light and dark accent modes.
- Disable Selectify on specific pages using path-pattern wildcards.
- Turn Selectify off on all admin routes to preserve backend UI.
- Deselect a radio button by clicking it again.
- Give long dropdowns a "Clear all" control (hidden for tiny lists).
- Keep keyboard and screen-reader behaviour on enhanced selects (WCAG 2.1 AA claim).
- Support right-to-left as well as left-to-right layouts.
- Override widget look via CSS custom properties or Twig templates.
- Change which widget applies to a form from a custom module (alter hook).
- Skip Selectify for a particular element from code (`#selectify_skip`).
