<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Select2 (machine name `select2_all`) automatically applies the Select2 JavaScript library to select (dropdown) form elements — chiefly on admin routes — giving them search, tagging, and nicer styling without configuring anything per field.

---

The module works entirely through the render pipeline. `hook_element_info_alter()` adds a `#pre_render` callback (`Select2::preRenderSelect`) to the `select` element type and to any element type whose id starts with `select_` or ends with `_select`. At render time `preRenderSelect()` decides whether to attach the library: it always attaches for elements that opt in, and by default targets admin context (an admin route, or the active theme being the admin theme). Opt-in/opt-out is controlled by the `#select2` FAPI property (TRUE/FALSE) or the CSS classes `select2-enable` / `select2-disable` on the element — a disabled element returns early and gets no library. When it does apply, it attaches the `select2_all/drupal.select2` library (which depends on the `select2` library) and, for multi-value entity-reference selects, adds a `data-cardinality` attribute and strips the `_none` option. `hook_field_widget_form_alter()` tags field widgets with their entity type/bundle/cardinality so the JS can honor selection limits. The bundled `select2` library loads from a CDN by default, but `hook_library_info_alter()` swaps it for a local copy if `libraries/select2/dist` exists under the Drupal root. There is **no settings form, no config, no schema, no permissions, and no Drush** — most of the historical configuration options are present only as commented-out code. The class `Select2` is a `TrustedCallbackInterface` exposing `preRenderSelect`, `preRenderDateCombo`, and `preRenderSelectOrOther`.

---

- Turn ordinary admin select dropdowns into searchable Select2 widgets automatically.
- Add type-ahead filtering to long option lists (e.g. taxonomy term or node reference selects).
- Improve multi-value entity-reference select widgets with Select2, honoring field cardinality.
- Give editors a nicer, searchable UI for content-type/field configuration selects.
- Opt a specific select element **out** of Select2 by adding the `select2-disable` class or `#select2 => FALSE`.
- Opt a specific select element **in** (outside admin) with the `select2-enable` class or `#select2 => TRUE`.
- Enhance select widgets on node edit forms in the admin theme without per-field setup.
- Provide searchable dropdowns on views configuration and other admin forms.
- Reduce scrolling through huge `<select>` lists by enabling search.
- Serve the Select2 library locally (offline / CSP-friendly) by placing it in `libraries/select2/dist`.
- Keep the front-end theme untouched while enhancing only admin selects.
- Apply Select2 to custom form elements whose type ends in `_select` or starts with `select_`.
- Strip the empty `_none` option from multi-select entity-reference widgets.
- Expose `data-cardinality` so client JS can cap the number of selected items.
- Support RTL languages (the JS sets `dir: rtl` when the current language is right-to-left).
- Standardize the look and feel of dropdowns across the admin UI.
- Avoid writing custom JS to make selects searchable.
- Use the `Select2::preRenderSelect` trusted callback programmatically on a render element.
- Improve UX of module settings forms that use large select lists.
- Enhance select elements added by other modules on admin pages with no extra configuration.
- Provide a consistent tagging/search dropdown experience for site administrators.
