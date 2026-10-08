# Geysir hooks

Geysir invites one hook (see `geysir.api.php`).

## `hook_geysir_paragraph_links_alter(array &$links, array $context)`

Alter the per-paragraph action links before they are rendered into the button bar. Invoked in
`geysir_preprocess_field()` via `\Drupal::moduleHandler()->alter('geysir_paragraph_links', ...)`
once per paragraph delta.

`$links` — an associative array of link render definitions. Default keys Geysir supplies:
`add_before`, `add_after`, `edit` (or `translate` on translated parents), `cut`, `delete`,
`paste_before`, `paste_after`. Each value is an array with `title`, `url` (a `Url` object) and
`attributes` (typically `class: ['use-ajax', 'geysir-button']`, `data-dialog-type: 'modal'`).
Add, remove or reorder entries here (e.g. inject `up`/`down` move links).

`$context` — array with:
- `paragraph` — `\Drupal\paragraphs\ParagraphInterface`, the current paragraph item.
- `parent` — `\Drupal\Core\Entity\FieldableEntityInterface`, the parent entity.
- `delta` — int, the field delta.
- `field_definition` — the field definition.

Example:

```php
function mymodule_geysir_paragraph_links_alter(array &$links, array $context) {
  if ($context['delta'] > 0) {
    $links['up'] = [
      'title' => t('Move up'),
      'url' => \Drupal\Core\Url::fromUserInput('#'),
      'attributes' => ['class' => ['geysir-button']],
    ];
  }
}
```

No other hooks or events are provided. Geysir also implements core hooks internally
(`hook_entity_type_build`, `hook_toolbar`, `hook_theme`, several `hook_preprocess_HOOK`) but
those are not extension points for you to implement.
