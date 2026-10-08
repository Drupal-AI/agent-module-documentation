Description List Field adds a single multi-value field type, `description_list_field`, that stores term/description pairs and renders them as a semantic HTML `<dl>` (description/definition list), with a default widget and formatter.

---

The module (from the OpenEuropa project) defines the `description_list_field` field type whose each delta stores three columns: `term` (plain text, big text column), `description` (big text column) and `format` (a `filter_format` id). The default `description_list_widget` renders a plain textfield for the term plus a `text_format` element for the description, so each pair carries its own text format; `massageFormValues()` splits the composite `text_format` value back into `description` + `format` on save. The default `description_list_formatter` builds a `#theme => 'description_list'` render array where each term is emitted with `#plain_text` and each description as a `#type => 'processed_text'` element (so the chosen text format and its cache metadata are applied at render time). The `description-list.html.twig` template wraps the pairs in `<dl>`/`<dt>`/`<dd>`, skipping empties. A computed `description_processed` property exposes the format-applied description for code/REST. When TMGMT is installed, `hook_field_info_alter` swaps in `TmgmtDescriptionListFieldProcessor` so the term column is treated as untranslatable-format plain text during translation extraction. There is no admin settings page (`configure` is null), no permissions, and no Drush commands — it is a pure field-type module configured entirely through Field UI.

---

- Add a glossary-style field where each entry is a term plus a rich-text definition.
- Build a "Key facts" or specifications block on a content type as term/value pairs.
- Render an FAQ-like list of question/answer pairs as a semantic `<dl>`.
- Capture product attributes (material, dimensions, weight) as labelled descriptions.
- Store metadata pairs (e.g. "Published by", "Contact") that render as a definition list.
- Give editors a repeatable term/description widget instead of a free-form table.
- Let each description use its own text format (Basic/Full HTML) per row.
- Output accessible `<dl>`/`<dt>`/`<dd>` markup for screen readers and SEO.
- Override `description-list.html.twig` in a theme to customise the list markup.
- Expose the processed description via the computed `description_processed` property in code or REST.
- Provide a translatable term/description field that integrates cleanly with TMGMT.
- Replace a paragraphs bundle used only for simple label/value pairs with one lighter field.
- Add contextual "definitions" to an article body as a structured field rather than inline markup.
- Collect step name + explanation pairs for a how-to node.
- Present contact details (role → person) as a description list in a footer view.
- Store rich descriptions alongside short terms without splitting into two separate fields.
- Use the default widget's per-row required handling to enforce completed pairs.
- Keep term text safe by rendering it as `#plain_text` (no markup injection from the term column).
- Migrate legacy "definition list" content into a single structured Drupal field.
- Render the field in view modes with the default formatter, no extra configuration needed.
