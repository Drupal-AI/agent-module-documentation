# Enabling the counter on a textarea widget

The counter is opt-in per field-widget, configured through third-party settings on the
entity's **Manage form display** page (Field UI). It only appears for two widget plugin ids:
`string_textarea` (plain text, long) and `text_textarea` (formatted text, long). Other
widgets get nothing.

Implemented by `hook_field_widget_third_party_settings_form()` in `textarea_limit.module`.

## Third-party settings (namespace `textarea_limit`)

Constants live in `\Drupal\textarea_limit\TextareaLimitConstants`.

| Key (constant) | UI element | Meaning |
|----------------|-----------|---------|
| `textarea_limit_char_limit` (`TL_CHAR_LIMIT_ID`) | textfield, size 6 | Fixed per-widget limit. Leave blank to disable. |
| `textarea_limit_use_global_limit` (`TL_USE_GLOBAL_LIMIT_ID`) | checkbox | Use the shared `global_limit` from `textarea_limit.settings` instead. |

The **Manage form display** settings summary shows "Limited to global character limit" or
"Limited to @chars characters" via `hook_field_widget_settings_summary_alter()`.

If both are set, the per-widget `char_limit` is applied first, then the global block runs and
overwrites `data-textarea-limit` with `global_limit` — so an enabled "use global" wins when
`global_limit` is non-empty.

## Set it in code

Third-party settings live on the `entity_form_display` config entity, keyed by the field's
widget. Example: a `body` field (widget `text_textarea`) on `node.article`:

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$component = $display->getComponent('body');
// Fixed 280-char limit:
$component['third_party_settings']['textarea_limit']['textarea_limit_char_limit'] = '280';
$component['third_party_settings']['textarea_limit']['textarea_limit_use_global_limit'] = 0;
$display->setComponent('body', $component)->save();
```

Set `textarea_limit_use_global_limit` to `1` (and leave `textarea_limit_char_limit` blank) to
follow the global limit instead. In exported `core.entity_form_display.*.yml` the same lives
under `content.<field>.third_party_settings.textarea_limit`.

## What happens at runtime

1. `hook_field_widget_form_alter()` reads the two third-party settings. If `char_limit` is
   non-empty it sets `$element['#textarea_limit'] = TRUE`, adds class `textarea-limit`, and
   sets attribute `data-textarea-limit` to the limit on the inner `value` element. If
   `use_global_limit` is on it does the same using `global_limit` (only when that is non-empty).
2. `hook_element_info_alter()` registered `TextareaLimitCallbacks::limitPreRender` as a
   `#pre_render` on the `textfield` and `textarea` element types.
3. `limitPreRender()` (a trusted callback) fires when `#textarea_limit === TRUE` and
   `data-textarea-limit > 0`: it renders the `textarea_limit_remaining` theme (a "N of M
   characters remaining" `<div>` with id `<element-id>-counter`) into `#suffix`, ensures the
   `textarea-limit` class, and attaches library `textarea_limit/textarea_limit`.
4. `js/textarea_limit.js` (behavior `Drupal.behaviors.textarea_limit`) finds each
   `.textarea-limit` element, reads `data-textarea-limit`, and calls the jQuery `.limit()`
   plugin bound to the `#...-counter` span, then marks it `textarea-limit-processed`.

## Enforcement is client-side only

There is no `#element_validate`, no field constraint, and no `#maxlength` set on the textarea.
The limit is a JavaScript counter (the external `jquery.limit` plugin) plus a `data-` attribute.
Programmatic saves, migrations/imports, and REST/JSON:API writes bypass it entirely. If the
limit must be authoritative, add a server-side length constraint to the field as well.
