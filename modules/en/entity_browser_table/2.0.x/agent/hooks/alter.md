# Extend the table: `hook_entity_browser_table_alter()` and subclassing

## The alter hook

Declared in `entity_browser_table.api.php`. It fires from `displayCurrentSelection()` after the
table render array is built, letting you add columns/cells to the widget table.

```php
/**
 * @param array $field_displays
 *   The table render array, keyed by machine name. $field_displays['table'] is the
 *   #type => table element; add to ['table']['#header'] and to each ['table'][$key].
 * @param \Drupal\Core\Entity\ContentEntityInterface[] $entities
 *   The referenced entities, keyed by row id.
 * @param string $details_id
 *   The wrapping details element id.
 */
function hook_entity_browser_table_alter(array &$field_displays, array $entities, string $details_id): void {
  $field_displays['table']['#header']['type-preview'] = t('Type');
  foreach ($entities as $key => $entity) {
    $field_displays['table'][$key][] = [
      'type-preview' => ['#markup' => $entity->bundle()],
    ];
  }
}
```

Note the parameter is named `$field_displays` in the signature but is the same array the widget
calls `$build`; the invocation is `$this->moduleHandler->alter('entity_browser_table', $build, $entities, $details_id)`.
Use it to add a bundle/type column, an author, a computed value, or per-row markup.

## Subclassing the widget

`EntityReferenceBrowserTableWidget extends EntityReferenceBrowserWidget`. Useful override
points (all `public`/`protected` methods on the widget) if the alter hook is not enough:

- `buildTableHeaders()` — the header row array.
- `buildTableRows($details_id, $field_parents, $entities)` — builds each row (handle, first
  column, status, weight, actions).
- `getFirstColumn($entity)` / `getFirstColumnHeader()` — the label/thumbnail column (uses the
  configured `field_widget_display`).
- `getAdditionalFieldsColumn($entity)` / `getAdditionalFieldsColumnHeader()` — the Status column
  (published/unpublished or moderation state).
- `buildEditButton()` / `buildReplaceButton()` / `buildRemoveButton()` / `getEditButtonAccess()`
  / `getReplaceButtonAccess()` — the Action column buttons and their access.
- `defaultSettings()` / `settingsForm()` — add your own widget settings.

Register a subclass by giving it its own `#[FieldWidget(id: ...)]` attribute (for
`entity_reference` / `entity_reference_revisions`) and selecting it on the form display.
