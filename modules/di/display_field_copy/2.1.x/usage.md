<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Display Field Copy is a Display Suite (DS) extension that lets you render the same entity field more than once on a page, each copy using its own formatter and formatter settings.

---

The module registers a single Display Suite dynamic field plugin, `display_field_copy` (derived per configured copy), plus the DS "Create a copy of a field" admin form. Each copy is stored as a Display Suite dynamic-field **simple config object** named `ds.field.<id>` with `type: display_field_copy` and a `properties.field_id` pointing at the source field (`<entity_type>.<field_name>` for base fields, or `<entity_type>.<bundle>.<field_name>` for configured fields). Because it is a DS field, the copy shows up in *Manage display* alongside the original, where you assign it a formatter and settings independently of the real field. At render time the plugin (`DisplayFieldCopy::build()`) loads the source field's items from the entity and runs them through the chosen formatter, so the copy displays live field data without duplicating storage. A `hook_theme_registry_alter()` preprocess (`display_field_copy_field`) unwraps the nested render array so the copied field markup matches a normal field. There is no settings page, no permission, and no limit on the number of copies. It requires Display Suite (`ds:ds`) and the source entity's view mode to be managed by DS.

---

- Show an entity reference field twice: once as rendered referenced entities, once as a plain list of links.
- Render a taxonomy term field both as linked tags and as a comma-separated label list on the same node.
- Display an image field once as a large "Full" image and again as a thumbnail elsewhere in the layout.
- Output a date field in two formats (e.g. a badge and a long date) within one Display Suite layout.
- Duplicate a body/text field to show a trimmed summary at the top and the full text lower down.
- Present a link field as both a button and a raw URL in different regions of the display.
- Repeat a media field in a sidebar and in the main content area with different image styles.
- Create several copies of one field, each with a different formatter, for a rich product/detail layout.
- Show an author (user reference) both as a rendered author card and as a username link.
- Render a price/number field with different decimal or prefix settings in two spots.
- Copy a base field such as the node title into a DS region with a custom formatter.
- Build a "hero + details" pattern where the same field appears styled two ways.
- Provide a print-friendly plain-text copy of a field next to its normal rendered version.
- Show a field's value and, separately, a boolean/derived rendering of the same field.
- Reuse an existing field in a Display Suite layout without cloning field storage or data.
- Display an address or geofield both as a map formatter and as a text formatter.
- Add a second, differently-configured formatter for a field that core only lets you place once per display.
- Surface the same tags field as a tag cloud in one region and as links in another.
- Present a file/attachment field as a download link and as a rendered preview.
- Export the copy as deployable config (`ds.field.*`) so the duplicated display travels between environments.
- Give editors two views of the same data without writing a custom field formatter plugin.
- Combine copies with Display Suite regions to compose complex, repeated field layouts.
- Render a computed/entity-reference field twice for different audiences (teaser vs. full).
- Show a rating or select-list field both as a widget-style label and as a numeric value.
