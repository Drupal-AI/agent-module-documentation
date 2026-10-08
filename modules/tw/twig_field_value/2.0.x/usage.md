Twig Field Value provides Twig filters that let themers print a field's label, its rendered value(s), its raw property values, or the entity a reference field points to — without the surrounding field markup wrappers.

---

In a Drupal Twig template a field like `content.field_foo` renders as a full render array wrapped in label and field HTML. When you only want the bare value — the text, the image, a single raw property, or the referenced entity — extracting it from that render array is awkward. This module adds four Twig filters to do exactly that. `field_label` returns just the field's label string. `field_value` returns the render array of the value(s) stripped of the field wrappers, so it still renders correctly (including cache metadata) but without the `<div class="field ...">` chrome. `field_raw` returns the raw stored property value(s), optionally a single named property. `field_target_entity` returns the referenced entity object(s) of an entity-reference field so you can drill into their fields. The filters accept a field render array (e.g. `content.field_image`) and work on single- or multi-value fields. It requires no configuration and no other modules — you just use the filters in your theme templates.

---

- Print only a field's value without the wrapping `field` div in a node template.
- Output a field's label text on its own, separate from the value.
- Render an image field cleanly inside custom markup you control.
- Print a single delta of a multi-value field, e.g. `content.field_tags.0`.
- Get the raw text of a field with `field_raw` to build a custom string.
- Extract one property of a compound field, e.g. the `uri` of a link field via `field_raw('uri')`.
- Read the raw value of a datetime field to reformat it in Twig.
- Follow an entity-reference field to its target entity with `field_target_entity`.
- Print a referenced media entity's own fields from a host node template.
- Loop over referenced entities returned by `field_target_entity`.
- Access a referenced taxonomy term's fields for custom rendering.
- Build a custom card layout using individual field values.
- Concatenate two field values into one line of markup.
- Conditionally show markup only when `field_raw` is non-empty.
- Render a field value inside an attribute (e.g. a link `href`) using `field_raw`.
- Preserve render caching/attachments while dropping field wrappers via `field_value`.
- Theme a field without creating a dedicated `field--field-name.html.twig`.
- Print the label of a field whose display is otherwise set to hidden.
- Pull the alt text or target id out of an image/reference field for custom output.
- Reformat address or paragraph subfields by reading their raw properties.
- Output a field value inside a `<meta>` tag for custom head markup.
- Reference a paragraph's field value from the parent entity template.
