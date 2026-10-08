<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Textfield Counter widgets

There is **no admin settings page**. You configure it per field by choosing one of the
counter widgets on the entity's **Manage form display** and editing the widget (gear icon).
State is stored on the entity-form-display component.

## The five widgets

| Widget id | Field type it replaces | Base core widget |
|---|---|---|
| `string_textfield_with_counter` | `string` (Text, plain) | StringTextfieldWidget |
| `string_textarea_with_counter` | `string_long` (Text, plain, long) | StringTextareaWidget |
| `text_textfield_with_counter` | `text` (Text, formatted) | TextfieldWidget |
| `text_textarea_with_counter` | `text_long` (Text, formatted, long) | TextareaWidget |
| `text_textarea_with_summary_and_counter` | `text_with_summary` (…with summary) | TextareaWithSummaryWidget |

Only the widget matching the field's type appears in the form-display *Widget* dropdown.

## Widget settings (component `settings.*`)

| Key | Type | Default | Notes |
|---|---|---|---|
| `maxlength` | int | `0` | Character limit. **0 disables the counter entirely.** |
| `counter_position` | string | `after` | `before` or `after` the input. |
| `js_prevent_submit` | bool | `TRUE` | Also block submit client-side (JS) when over limit. |
| `count_only_mode` | bool | `FALSE` | Count but **skip validation** — user may submit any length. |
| `count_html_characters` | bool | `TRUE` | Include HTML/markup in the count. **Uncheck for CKEditor fields.** |
| `textcount_status_message` | string | span markup (below) | Message shown; tokens `@maxlength`, `@current_length`, `@remaining_count`. |
| `use_field_maxlength` | bool | `0` | *(textfield widgets only)* use the field storage `max_length` instead of `maxlength`. |
| `enable_summary` / `summary_maxlength` / `show_summary` / `summary_rows` | — | — | *(summary widget only)* separate limit/counter for the summary. |
| `size` / `rows` / `placeholder` | int/str | core defaults | inherited from the core base widget. |

Default `textcount_status_message`:
```
Maxlength: <span class="maxlength_count">@maxlength</span><br />Used: <span class="current_count">@current_length</span><br />Remaining: <span class="remaining_count">@remaining_count</span>
```
For the live counter to update, the tokens must stay wrapped in spans with classes
`maxlength_count`, `current_count`, `remaining_count`.

## Where it is stored / setting via config
```
core.entity_form_display.<entity>.<bundle>.<mode>:
  content.<field>.type: text_textarea_with_counter
  content.<field>.settings.maxlength: 280
  content.<field>.settings.counter_position: after
  content.<field>.settings.count_only_mode: false
```
Programmatically:
```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$fd->setComponent('field_body', [
  'type' => 'text_textarea_with_counter',
  'settings' => ['maxlength' => 280, 'counter_position' => 'after'],
])->save();
```

## Validation behaviour
- Server-side: `validateFieldFormElement()` sets a form error
  ("… cannot be longer than %max characters but is currently %length …") when the submitted
  length exceeds `maxlength`. This is the real enforcement.
- `count_only_mode = TRUE` disables that validation (counter is informational only).
- `js_prevent_submit` adds a client-side guard **in addition** (ignored when `count_only_mode`).
- Length counting: with `count_html_characters` off, tags are stripped and `&nbsp;` normalised
  before counting; newlines are collapsed. With it on, raw characters (minus newline chars) count.
