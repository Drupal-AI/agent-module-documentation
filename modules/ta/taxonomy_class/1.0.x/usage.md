Taxonomy Class adds a "CSS class(es)" base field to every taxonomy term and outputs its first value as a class on the rendered term template, letting editors style individual terms without editing templates or CSS files by hand.

---

The module is intentionally tiny. `taxonomy_class_entity_base_field_info()` defines one string base field, `taxonomy_class` (label "CSS class(es)", `string_textfield` widget, weight 35, display-configurable), on the `taxonomy_term` entity type — so it is present on terms in every vocabulary with no per-bundle field setup. `taxonomy_class_form_taxonomy_term_form_alter()` reparents that field into a collapsed "Taxonomy Class settings" details group in the term form's advanced sidebar, but only for users holding the `administer taxonomy classes` permission; the alter returns early for everyone else, hiding the field. On render, `taxonomy_class_preprocess_taxonomy_term()` reads the field's first value and appends it to `$variables['attributes']['class']`, so the class appears on the term template's wrapper (wherever `{{ attributes }}` is printed). Only the first value is used; a space-separated entry is stored and emitted as a single class token. There is no settings page, no config object or schema, no drush commands, no services, and no dependencies beyond Drupal core. Set the value programmatically with `$term->set('taxonomy_class', 'my-class')->save();`.

---

- Add a per-term CSS class so editors can style individual taxonomy terms.
- Give category terms brand or color classes (e.g. `cat-news`, `cat-sports`) for themed term pages.
- Attach a utility class to a term to trigger theme-specific layout on its term page.
- Let content editors manage term styling without touching templates or CSS files directly.
- Mark selected terms with a class consumed by custom CSS or JS behaviors on the term page.
- Restrict who may set term classes via the `administer taxonomy classes` permission.
- Expose the class field in the term form's advanced sidebar group for a tidy edit UI.
- Style vocabulary terms differently based on an editor-assigned class.
- Add icon-font or badge classes to a term for display on its term page.
- Apply a state/status class such as `is-featured` to specific terms.
- Keep term-level presentation data on the term entity itself, portable with content.
- Hide the class field entirely from editors who lack the permission.
- Provide template-free term theming by relying on the auto-added wrapper class.
- Assign a class used by CSS to color-code taxonomy term landing pages.
- Set a term's class programmatically during a migration or bulk update.
- Read a term's class value in your own preprocess to reuse it on nodes tagged with that term.
- Drive a design-system modifier class (BEM-style) onto term pages from the editor UI.
- Tag terms for campaign or seasonal styling by flipping a single class value.
- Give a landing/overview term a distinctive class for a hero treatment.
- Standardize term-page styling across vocabularies without writing template suggestions.
