Adds an "As Class" display formatter to the Field Group module that renders a field group wrapper whose CSS class is taken from the value of one of the entity's own `string`/`list_string` fields.

---

Field Group as Class registers a single `field_group` display formatter plugin, `asclass` (`AsClass`), available in the **view** context on *Manage display*. Instead of drawing visible markup, the formatter wraps the grouped fields in a container and appends a dynamic CSS class read at render time from a chosen field on the entity being displayed. In the group's formatter settings you pick which field supplies the class via the `field_class` setting; only non-base `string` (Text plain) and `list_string` (List text) fields on that bundle are offered. At render, `preRender()` resolves the entity (supporting node, paragraph, taxonomy_term, block_content), reads the selected field's first value with `getFieldClassValue()`, and merges it — together with any static classes from the standard field_group settings and an optional `id` — into the wrapper's attributes through the module's own `field_group_as_class` render element (`AsClassElement`). This lets editors drive layout/state classes (e.g. a "theme", "status", or "variant" select) straight from content, so a stylesheet can react to per-entity values without custom preprocess code. It requires the contrib Field Group module; there is no settings page, permissions, or Drush.

---

- Add a per-entity CSS class to a field group from a content field's value.
- Let an editor pick a "variant" via a List (text) field that becomes a wrapper class.
- Drive a color/theme modifier class on a card from a taxonomy or node field.
- Toggle a state class (e.g. `is-featured`) based on a string field value.
- Apply layout classes to a group of fields without writing a preprocess hook.
- Reuse an existing List (text) field's machine value as a BEM modifier.
- Set both static field_group classes and a dynamic field-derived class together.
- Add an optional `id` attribute to a field group wrapper.
- Group several fields and style them collectively from one control field.
- Expose a "status" select to editors that maps to CSS without deployments.
- Render dynamic classes on nodes, paragraphs, taxonomy terms, or custom blocks.
- Build content-editor-controlled design variations (hero styles, badges).
- Keep class logic in configuration/content instead of Twig conditionals.
- Provide a data-driven wrapper class for JS hooks (`.js-…`) from a field.
- Support A/B-ish presentation flips by changing one field value.
- Feed a print/no-print or visibility class from a boolean-like list field.
- Attach a per-item theme class in a paragraphs-based layout.
- Give a taxonomy term display a class taken from one of its own fields.
- Let a custom block's field decide its own container class.
- Avoid a one-off custom formatter just to inject a class.
