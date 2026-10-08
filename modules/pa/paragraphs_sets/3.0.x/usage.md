Paragraphs Sets lets editors insert a whole pre-configured group of paragraphs into a Paragraphs field in one click, instead of adding each paragraph one by one — ideal for repeatable page patterns (a hero + two columns + CTA, an FAQ block, etc.). Sets are defined as config entities and offered on the Paragraphs (stable) widget.

---

The module adds a `paragraphs_set` config entity (config prefix `paragraphs_sets.set.*`, exported keys `id`, `label`, `description`, `icon_uuid`, `paragraphs`) that describes an ordered list of paragraphs — each an entry of `{bundle: <paragraph_type>, data: {field: default value, …}}`. It exposes settings on the **Paragraphs** field widget (the stable `paragraphs` widget, `ParagraphsWidget`) via `hook_field_widget_third_party_settings_form()`: **Enable Paragraphs Sets** (`use_paragraphs_sets`), **Limit sets to** (`sets_allowed`), and **Default set** (`default_set`) — stored under `third_party_settings.paragraphs_sets` on that field's component in the `entity_form_display`. When enabled, a set selector appears atop the widget; picking a set appends its paragraphs (pre-filled with the set's default field data). Sets can also seed a field's default value (via **Default set**, which requires the widget's "Default paragraph type" to be "- None -"). A management UI lives at `/admin/structure/paragraphs_set` (route `entity.paragraphs_set.collection`, add form `paragraphs_sets.set_add`), gated by the `administer paragraphs sets` permission. Default values for primitive fields work out of the box; complex field values are supplied by implementing the alter hooks (`hook_paragraphs_set_data_alter()`, `hook_paragraphs_set_SET_data_alter()`, `hook_paragraphs_set_SET_FIELD_NAME_data_alter()`), and the set icon can be altered via `hook_paragraphs_sets_set_static_icon_uri_alter()`. Runtime helpers live in the static `ParagraphsSets` service class (`getSets()`, `getSetsOptions()`, …). It ships config schema, CSS, templates and a modal dialog, and no Drush commands.

---

- Insert a standard "landing section" (hero + columns + CTA) as one reusable set.
- Give editors a one-click FAQ block: several pre-added Q&A paragraphs.
- Pre-fill default text/values in a set's paragraphs so editors start from a template.
- Offer a curated list of page patterns per field by limiting which sets are allowed.
- Seed a Paragraphs field's default value with a set (via the widget's Default set option).
- Speed up authoring of repetitive multi-paragraph layouts.
- Restrict available sets on one field while allowing all sets on another.
- Provide a "two column with image" starter set for marketing pages.
- Standardise content structure across a team by shipping approved sets.
- Add a set icon to help editors visually choose a pattern.
- Build a component library of paragraph combinations without custom code.
- Manage sets centrally at /admin/structure/paragraphs_set.
- Supply complex/default field values programmatically via hook_paragraphs_set_data_alter().
- Customise defaults for a single set with hook_paragraphs_set_SET_data_alter().
- Customise a specific field's default within a set with hook_paragraphs_set_SET_FIELD_NAME_data_alter().
- Override a set's icon URI with hook_paragraphs_sets_set_static_icon_uri_alter().
- Let editors add a whole prepared section, then tweak the pre-filled content.
- Reduce clicks when building long structured pages with Paragraphs.
- Export/deploy content patterns as config (paragraphs_sets.set.* config entities).
- Enable sets only on the stable Paragraphs widget where it makes sense.
- Combine multiple sets on a page to assemble complex layouts quickly.
- Enforce a starting layout by making a set the field's default value.
