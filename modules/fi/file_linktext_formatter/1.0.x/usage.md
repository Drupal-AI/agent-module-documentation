File linktext formatter adds a field formatter for core File fields that renders the download link using the value of another `string` field on the same entity as the link text, instead of the file's own filename.

---

The module provides a single field formatter, `file_fieldtext` ("Link text from field"), for `file`-type fields. It extends core's `FileFormatterBase` and behaves like the generic file formatter (it renders each referenced file with the `file_link` theme hook and the file's cache tags), except the link text (`#description`) is taken from a sibling `string` field you pick in the formatter settings. The settings form lists every `string` field defined on the formatter's target entity type/bundle plus a "Disabled" option (value `0`); the chosen field name is stored in the `use_field_as_link_text` setting (schema `field.formatter.settings.file_fieldtext`). At render time `viewElements()` reads `$entity->{$fieldname}->value` and passes it as the file link's description. The formatter is only applicable to single-value file fields (`isApplicable()` requires field cardinality `1`), and when no field is selected it falls back to the default (filename) link text. There is no global config, no permissions, and no dependencies beyond core File.

---

- Show a human-friendly title from a text field as the download link instead of the raw filename.
- Label a PDF download with an editorial "document title" string field rather than `report-final-v3.pdf`.
- Use a "Display name" field as the link text for an attached file on a node.
- Render a file field where the anchor text comes from a separate one-line text field.
- Keep the actual file/filename intact while presenting a curated link label to visitors.
- Replace the core generic file formatter when you need custom link text per entity.
- Configure the link-text source entirely from the *Manage display* tab, no code.
- Point the link text at any `string` field on the same content type/bundle.
- Fall back to the default filename link text by choosing the "Disabled" option.
- Provide accessible, descriptive link text for screen readers from a real title field.
- Localize download link text by sourcing it from a translatable string field.
- Present spec sheets, brochures, or manuals with marketing-friendly link labels.
- Show a "Certificate name" as the link for an uploaded certificate file.
- Use a SKU or product-name string field as the link text for a downloadable asset.
- Give attachments in a media/paragraph entity a titled link via a string subfield.
- Standardize download link labels across a bundle by binding them to one title field.
- Avoid exposing internal or hashed filenames in the visible link text.
- Keep file-field attributes (`_attributes`) working while overriding only the link text.
- Apply per-view-mode: use filename in one display and field-based link text in another.
- Combine with a required title field so every uploaded file has meaningful link text.
