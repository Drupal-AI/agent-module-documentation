# Configure an FAQ field

FAQ Field has **no module settings page, no routes, no permissions**. All configuration is per
field instance on the entity's field-UI screens. Enable with `drush en faqfield -y` (pulls in
core `field` and the `jquery_ui_accordion` module).

## The field type

- Type id: `faqfield`, label "FAQ Field". Default widget `faqfield_default`, default formatter
  `faqfield_accordion`.
- Storage columns per item: `question` (varchar 255), `answer` (text, medium), `answer_format`
  (varchar 255). `mainPropertyName()` is `question`.
- Cardinality is **forced to unlimited** when the field storage is created
  (`hook_field_storage_config_create`), so a field is always a multi-item Q&A list.
- Field-level setting (`field.field_settings.faqfield`):
  - `default_format` (default `plain_text`) — "Default text format" applied to answers that
    don't carry their own format. The select only appears when more than one text format is
    available to the user.

Add via UI at **Manage fields → Add field → FAQ Field**, or in code as a normal field (set the
`default_format` field setting).

## The widget — `faqfield_default` (Manage form display)

Settings (schema `field.widget.settings.faqfield_default`; defaults shown):

| Setting | Default | Meaning |
|---|---|---|
| `answer_widget` | `text_format` | Answer input type: `textarea`, `text_format` (Formattable textarea / WYSIWYG), or `textfield` |
| `question_title` | `Question` | Label of the question input |
| `answer_title` | `Answer` | Label of the answer input |
| `question_field_required` | `false` | Make the question input required |
| `answer_field_required` | `false` | Make the answer input required |
| `advanced.question_length` | `255` | Max question length (1–255) |
| `advanced.question_size` | `100` | Width (size) of the question widget (10–255) |
| `advanced.question_rows` | `0` | 0 = single-line textfield; ≥1 turns the question into a textarea with that many rows |
| `advanced.answer_rows` | `3` | Rows for the answer textarea (hidden when answer widget is a plain textfield) |

When `answer_widget` is `text_format`, each answer element gets a `#format` = the item's saved
`answer_format` or the field's `default_format`. Formattable textarea is required for WYSIWYG
editors.

## The formatters (Manage display)

Pick one of five formatters. Answers always run through `check_markup()` with the item's format
(or the field default); questions are always `strip_tags()`-ed.

| Formatter id | Label | Notable settings |
|---|---|---|
| `faqfield_accordion` | jQuery Accordion (default) | `question_tag` (h2–h6), `active` (index of open panel, blank = none), `heightStyle` (`auto`/`fill`/`content`), `collapsible` (bool), `event` (default `click`), `animate.easing` (`linear`), `animate.duration` (200 ms) |
| `faqfield_definition_list` | HTML definition list | none |
| `faqfield_anchor_list` | HTML anchor list | `anchor_list_type` (`ul`/`ol`), `question_tag` (h2–h6) |
| `faqfield_details` | HTML details | none |
| `faqfield_simple_text` | Simple text | `question_tag` (h2–h6) |

Accordion notes: it attaches the `faqfield/faqfield.accordion` library and passes its settings via
`drupalSettings` keyed by a generated id (`faqfield_<field>_<entitytype>_<id>`). If `active` is
left blank it is coerced to `FALSE` (no panel open). The accordion markup is intentionally **not**
themeable — changing it breaks the jQuery UI behavior.

## Answer text format — precedence

Per item: `answer_format` if the item has one, otherwise the field's `default_format`. So set a
sensible field-wide default, and (with the Formattable textarea widget) let editors override the
format per answer.
