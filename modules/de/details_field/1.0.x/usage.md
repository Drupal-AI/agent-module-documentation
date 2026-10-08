Details Field adds a "Details element" field type, widget and formatter that let editors create and display native HTML `<details>`/`<summary>` disclosure (collapsible) widgets with a rich-text summary, rich-text body, and configurable per-item attributes.

---

Details Field extends core's Text (formatted, long, with summary) field so each field item stores a text-format summary, a text-format body, an "open by default" flag, an optional `name` attribute (for grouping mutually-exclusive details, accordion-style), and a serialized bag of extra HTML attributes (`id`, `class`, `aria-label`). The provided widget (`details_field`, extending `TextareaWithSummaryWidget`) exposes the summary as a `text_format` element plus an "Extra Settings" section whose attribute controls are enabled per-field via the widget's "Allowed attributes" setting. The default formatter (`details_field`, extending `TextDefaultFormatter`) renders each item as a `#type => details` render element — summary as the title, body as the content — both passed through `#type => processed_text` so the item's text formats are applied; it can also auto-generate a URL-friendly `id` from the summary. A second formatter (`details_field_summary`) renders only the summary. Attribute options are defined declaratively in `details_field.allowed_attributes.yml` and discovered by the `plugin.manager.details_field` YAML plugin manager, so other modules can add attribute options by shipping their own `MODULE.allowed_attributes.yml`. `hook_field_views_data()` (in `details_field.views.inc`) exposes the value, summary, open, name and attributes columns to Views.

---

- Add a collapsible "Details element" field to a content type, block, paragraph, or any fieldable entity.
- Build FAQ entries where each question is the summary and the answer is the collapsible body.
- Create an accordion by giving several details items the same `name` attribute so only one stays open at a time.
- Show long body/description text collapsed by default to shorten a page.
- Let editors mark specific details items to render open by default via the "Open" checkbox.
- Provide a rich-text summary (headings, emphasis, links) rather than plain-text disclosure titles.
- Apply a distinct text format to the summary independently from the body via the field's "Allowed text formats for Summary" setting.
- Restrict which text formats editors may pick for the summary per field instance.
- Auto-generate anchor-friendly `id` attributes from the summary text so details can be deep-linked.
- Let editors set an explicit `id` per details element when the `id` attribute is allowed.
- Add extra CSS `class` values per details element for theming, when the `class` attribute is enabled.
- Set an `aria-label` per details element for accessibility, when that attribute is enabled.
- Control per field which attributes editors may edit through the widget's "Allowed attributes" checkboxes.
- Use the multi-value field to output a stack of independent disclosure widgets on one entity.
- Render only the summaries (without the collapsible body) on teasers/listings using the "Details summary" formatter.
- Expose details field columns (content, summary, open, name, attributes) as Views fields, filters, sorts and arguments.
- Filter or sort a listing on whether details items are open by default.
- Extend the available attribute options for editors by shipping a custom `MODULE.allowed_attributes.yml`.
- Adjust the number of textarea rows for the body and summary inputs via the widget settings.
- Set placeholder text for the widget inputs via the widget settings.
- Migrate long collapsible content blocks out of hand-authored HTML into a structured, filterable field.
- Reuse the same field across nodes, custom blocks, and paragraphs for consistent disclosure markup.
