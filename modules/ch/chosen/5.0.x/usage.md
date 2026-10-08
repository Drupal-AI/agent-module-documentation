Chosen turns long, unwieldy HTML `<select>` elements into searchable, user-friendly dropdowns by applying the Chosen JavaScript library across Drupal forms.

---

Chosen attaches the Chosen jQuery/JS plugin to select boxes so users can type-to-search, see placeholder text, and (on multi-selects) pick several values as removable tags instead of scrolling a native list. It works site-wide by altering the render system (`hook_element_info_alter`) and field widgets, applying to any `select` element that matches a configurable jQuery selector once it exceeds a minimum option count. A single settings form at Admin → Configuration → User interface → Chosen controls all behavior: minimum option thresholds for single and multiple selects, search threshold, widget width, placeholder and "no results" text, mobile support, and whether Chosen runs on admin pages, the front end, or both. The actual Chosen assets are supplied by the required `chosen_lib` submodule, which also ships a Drush command to download the third-party library. An optional `chosen_field` submodule adds a dedicated field widget so editors can opt individual reference/list fields into Chosen. Settings are exportable config and there is a migration path from the Drupal 7 version. Themes such as Claro and Gin get matching styling, and specific admin themes can be excluded.

---

- Make a taxonomy term reference select searchable when there are hundreds of terms.
- Turn a country/language dropdown into a type-ahead select.
- Convert multi-value entity reference selects into tag-style pickers.
- Add placeholder text like "Choose an option" to bare selects.
- Show a search box only when a select exceeds a chosen number of options.
- Hide the search box for short selects using the search threshold.
- Apply Chosen only to admin pages, only to the front end, or both.
- Exclude a specific admin theme (e.g. Claro) from Chosen styling.
- Limit results shown to the first N matches for very large option lists.
- Search in the middle of words, not just from the start.
- Allow deselecting the value on single selects.
- Add "select all" / "select none" helper buttons on multi-selects.
- Enable Chosen on mobile devices where it is off by default.
- Set widget width in pixels or as a relative percentage.
- Target only certain selects with a custom jQuery selector.
- Improve the UX of Views exposed filters that use select widgets.
- Make Better Exposed Filters selects use Chosen (dedicated library).
- Opt a single field into Chosen with the chosen_field widget.
- Provide a friendlier role/permission multi-select on admin forms.
- Localize the placeholder and "no results" text.
- Deploy consistent select behavior across environments via exported config.
- Download the Chosen JS library on a server with `drush chosen:plugin`.
- Migrate Chosen settings from a Drupal 7 site.
- Reduce editor errors on large single-select fields with search.
- Style Chosen to match the Gin admin theme.
