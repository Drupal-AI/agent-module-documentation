Field Formatter provides three generic field formatters: two that render a single chosen field of a referenced entity (with either inline formatter settings or a referenced view mode), and one "Field linker" that wraps any field's output in a link to the parent entity.

---

The module adds three `@FieldFormatter` plugins and no configuration UI of its own. `field_formatter_with_inline_settings` ("Field formatter with inline settings", for `entity_reference` / `entity_reference_revisions` fields) lets you pick one field from the referenced entity and configure that inner field's formatter and settings inline on the Manage display form via AJAX. `field_formatter_from_view_display` ("Field formatter from view display", same field types) instead renders one chosen field using the formatter already configured in a selected view mode of the referenced entity — it clones the target view display and strips every component except the chosen field. Both extend `FieldFormatterBase` (which itself extends core `EntityReferenceFormatterBase`) and share a `link_to_entity` option that links the output to the parent entity. The third plugin, `field_link` ("Field linker"), extends `FieldWrapperBase`/`FormatterBase` and applies to **all** field types (enabled via `hook_field_formatter_info_alter()`); it renders the field with any other applicable formatter and wraps each item in a link pointing to the host entity's canonical URL. Settings are stored in the entity view display config and validated by schemas in `config/schema/field_formatter.schema.yml`. The base classes are also reusable for building your own single-field or wrapping formatters.

---

- On an Article that references an Author entity, show only the author's photo field, not the whole rendered author.
- Display a single field (e.g. a price or a date) from a referenced product without rendering the entire product teaser.
- Render a referenced entity's field using an existing view mode's formatter, keeping display config in one place.
- Pull a specific paragraph field up into the host entity's display via `entity_reference_revisions`.
- Configure the inner field's formatter (image style, date format, etc.) inline on the parent's Manage display page.
- Wrap a plain text or image field in a link to the current entity using the "Field linker" formatter.
- Make a teaser image link to its own node without adding a separate link field.
- Show a referenced taxonomy term's description field only, formatted as trimmed text.
- Surface one field of a referenced media entity (e.g. the caption) inside a node display.
- Avoid building a custom formatter plugin just to display a single field of a related entity.
- Link an arbitrary field (rating, SKU, label) to the parent entity for click-through in listings.
- Reuse a bundle's "teaser" view-mode formatting for just one field embedded elsewhere.
- Display the same referenced field with different formatters per view mode by configuring inline settings.
- Optionally link the extracted referenced field back to the parent entity via the `link_to_entity` checkbox.
- Present a referenced author's name field as a link to the article it appears on.
- Build compact card layouts that show one selected field from each referenced entity.
- Combine with Layout Builder to place a single referenced-entity field into a region.
- Extend `FieldFormatterBase` to build your own formatter that displays one field of a referenced entity.
- Extend `FieldWrapperBase`/`FieldLink` to build a custom wrapper formatter around any field's output.
- Keep referenced-entity display DRY by delegating to a shared view mode rather than duplicating settings.
- Show a referenced event's start-date field, formatted by the date module, without the rest of the event.
- Render a single field from each item of a multi-value entity reference.
