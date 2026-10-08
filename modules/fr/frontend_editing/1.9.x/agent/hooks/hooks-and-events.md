<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & access events

## Alter hooks (`frontend_editing.api.php`)

### `hook_fe_field_wrapper_exclude_alter(array &$fields, array $context)`
Add **full field names** (`entity_type.bundle.field_name`) to exclude them from the editable
frontend wrapper (they render but get no edit affordance). `$context` has `entity_type`,
`bundle`, `field_name`.

```php
function mymodule_fe_field_wrapper_exclude_alter(array &$fields, array $context) {
  if ($context['entity_type'] === 'node' && $context['bundle'] === 'article') {
    $fields[] = 'node.article.field_internal_note';
  }
}
```

(Equivalent to listing the field in the `exclude_fields` config key.)

### `hook_fe_allowed_bundles_alter(array &$bundles, array $context)`
Alter the list of bundles offered for frontend editing / paragraph add. Remove an entry to
disallow it. `$context` has `entity_type`, `bundle`, and for paragraph add a `view_display`.

```php
function mymodule_fe_allowed_bundles_alter(array &$bundles, array $context) {
  if ($context['entity_type'] === 'node') {
    $key = array_search('node.article', $bundles, TRUE);
    if ($key !== FALSE) { unset($bundles[$key]); }
  }
}
```

## Access events (`src/Event/`, dispatched via `event_dispatcher`)

Subscribe to these to override paragraph-action access. Constants on
`Drupal\frontend_editing\Event\FrontendEditingEvents`:

| Constant | Event class | Fires for |
|---|---|---|
| `FE_PARAGRAPH_MOVE_ACCESS` | `ParagraphMoveAccess` | up/down move |
| `FE_PARAGRAPH_ADD_ACCESS` | `ParagraphAddAccess` | add / add-before |
| `FE_PARAGRAPH_DELETE_ACCESS` | `ParagraphDeleteAccess` | delete |

Each event extends `ParagraphAccessBase` and carries the paragraph and an
`AccessResultInterface` (via `AccessResultTrait`) you can tighten or loosen.

```php
use Drupal\frontend_editing\Event\FrontendEditingEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyFeSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [FrontendEditingEvents::FE_PARAGRAPH_DELETE_ACCESS => 'onDelete'];
  }
  public function onDelete($event) {
    // Inspect $event->getParagraph(); then $event->setAccessResult(...);
  }
}
```

These run **in addition to** the `move/add/delete paragraphs` permissions and `paragraphs_edit`
lineage access — a subscriber can deny even when the permission is granted.
