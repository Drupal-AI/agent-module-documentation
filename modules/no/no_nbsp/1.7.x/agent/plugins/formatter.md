# The `no_nbsp` field formatter

`src/Plugin/Field/FieldFormatter/NoNbspFormatter.php` —
`@FieldFormatter(id = "no_nbsp", label = "No Non-breaking Space Filter", field_types =
{"text", "text_long", "text_with_summary"})`. A plugin **instance** of core's field-formatter
plugin type (no new plugin type defined).

Use it when you want to strip non-breaking spaces **at display time on one field** without
enabling the filter on the field's text format.

## What it does

`viewElements()` renders each item as `#markup => _no_nbsp_eraser($item->processed)` — i.e. it
takes the field's already text-format-processed output and removes `&nbsp;` / U+00A0, collapsing
repeated spaces. Note: it uses the formatter's default (no `preserve_placeholders` option is
exposed on the formatter — that toggle exists only on the filter).

## Enable it

*Manage display* for the bundle (e.g. `/admin/structure/types/manage/article/display`), set the
target text field's **Format** to **No Non-breaking Space Filter**, and save.

Config lives in the view display, e.g.:

```yaml
# core.entity_view_display.node.article.default
content:
  field_body:
    type: no_nbsp
    label: hidden
    settings: {}
```

Scripted:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_body', ['type' => 'no_nbsp', 'label' => 'hidden'])->save();
```

## Filter vs formatter — which to use

- **Filter** (`filter_no_nbsp`): cleans everything rendered through a text format; central, has
  the `preserve_placeholders` option.
- **Formatter** (`no_nbsp`): cleans one field's output only, leaves the text format untouched;
  good for a targeted fix or when you must not alter shared formats.

Both call the same eraser, so the cleaning result is identical (minus the placeholder option).
