# Configure the Paragraphs Summary formatter

No settings page. You enable it per field on an entity's **Manage display** tab
(`admin/structure/…/display`) for a Paragraphs (`entity_reference_revisions`) field, then open the
formatter cog. It only appears for fields whose target entity implements `ParagraphInterface`.

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `allowed_bundles` | array (checkboxes) | `[]` | Paragraph bundles to render. **Empty = all** eligible bundles allowed. Bundles not in the set are skipped. |
| `view_mode` | string (select) | `default` | Paragraph view mode used to render each item (required). |
| `limit` | int | `1` | Max items rendered; `0` = unlimited. |

Eligible bundles come from the field's `handler_settings.target_bundles` (or all bundles of the
target type if unrestricted).

## Where it's stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>:
  content:
    <field_name>:
      type: paragraphs_summary
      settings:
        allowed_bundles: { text: text, hero: hero }   # or [] for all
        view_mode: summary
        limit: 1
```

## Set with Drush (example)

```php
// drush php:eval — first text paragraph only, rendered in the "summary" view mode
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.page.teaser');
$vd->setComponent('field_paragraphs', [
  'type' => 'paragraphs_summary',
  'region' => 'content',
  'settings' => ['allowed_bundles' => ['text' => 'text'], 'view_mode' => 'summary', 'limit' => 1],
])->save();
```

## Render behaviour

`viewElements()` renders each referenced paragraph with its own view builder in `view_mode`,
skips any whose bundle isn't allowed, and breaks once `count(elements) >= limit` (when `limit`
is non-zero). Core's recursive-render guard (`RECURSIVE_RENDER_LIMIT = 20`) aborts and logs to the
`entity` channel if a paragraph render loop is detected.
