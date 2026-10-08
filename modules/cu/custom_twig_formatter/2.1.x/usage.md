Custom Twig Formatter adds a field formatter that renders a field by evaluating Twig code you write in the Manage-display UI, exposing every field on the entity as a Twig variable.

---

The module ships a single field formatter plugin, `custom_twig_markup` ("Custom Twig markup"), that applies to a broad set of core field types (boolean, string/text, integer/decimal/float, list_*, datetime/daterange, timestamp/created/changed, email, telephone, uri, link, file, image, entity_reference, language, comment). When you select it on a field in *Manage display*, a **Twig code** textarea appears in the formatter settings. At view time the formatter builds a render context in which each of the entity's field items is available as a variable named after the field's machine name, plus a `label` variable (the current field's label, honoring `field_display_label` when that module is installed), then compiles and renders your stored Twig string against that context and outputs the result as `#markup`. Because the template can read any field on the entity, one field's display can combine or reformat values from several fields. The Twig snippet is part of the view-display configuration entity, so setting it requires the entity type's "administer display" permission and it travels with configuration export/import. There are no routes, permissions, services, Drush commands, or submodules of the module's own; the only dependency is core `field`.

---

- Render a field's output from a custom Twig template written directly in *Manage display*, no theme or preprocess code needed.
- Combine several fields of one entity into a single field's markup (e.g. show `field_first_name` and `field_last_name` together).
- Reformat a date field with Twig's `date` filter into a project-specific format.
- Wrap a value in custom HTML/CSS classes without adding a template file to the theme.
- Conditionally show or hide output with `{% if %}` based on another field's value.
- Concatenate a link's URL and title into a bespoke anchor layout.
- Compute a derived string (e.g. a full name, a formatted price, a status badge) from multiple fields.
- Display the field's label inline using the `label` variable, respecting `field_display_label` overrides.
- Build a small summary line from an entity_reference field's referenced values.
- Format numbers with Twig filters (`number_format`, `round`) for currency or measurements.
- Apply Twig `default` / `trim` / `upper` / `lower` filters to normalize text output.
- Emit different markup per bundle by selecting the formatter only on specific view displays.
- Produce microdata / schema.org attributes around a field value via inline Twig.
- Show a fallback message when a field is empty using `{{ field_x|default('—') }}`.
- Turn a boolean or list value into a human-readable badge or icon.
- Build a `tel:` or `mailto:` link from a telephone or email field with custom text.
- Assemble an image field's URI into a custom `<img>` or `<picture>` snippet.
- Add a computed CSS class to a field wrapper based on another field's value.
- Reuse the same Twig display logic across environments by exporting the view-display config.
- Prototype display formatting quickly in the UI before moving stable logic into a theme template.
- Localize or pluralize output with Twig's translation and `format` helpers.
- Render a compact one-line representation of a complex multi-value field.
