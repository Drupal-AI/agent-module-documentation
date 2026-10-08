<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloning from code

There is **no service and no Drush command**. The batch callbacks are public static methods you
can call directly, or you can just do the equivalent yourself.

## The shape the callbacks expect

Both callbacks take the form's `$values` array:

```php
$values = [
  'show' => ['entity_type' => 'node', 'type' => 'article'],  // source
  'clone_bundle' => 'Article Copy',                          // target label
  'clone_bundle_machine' => 'article_copy',                  // target machine name (<= 32 chars)
  'target_description' => 'A cloned article type.',
];
```

## Calling the callbacks

```php
use Drupal\entity_type_clone\CloneEntityType;

$context = [];
CloneEntityType::cloneEntityTypeData($values, $context);

$fields = \Drupal::service('entity_field.manager')
  ->getFieldDefinitions($values['show']['entity_type'], $values['show']['type']);
foreach ($fields as $field) {
  if (!$field->getTargetBundle()) {
    continue;                       // base fields are skipped
  }
  if ($values['show']['entity_type'] === 'taxonomy_term' && $field->getName() === 'parent') {
    continue;                       // taxonomy parent is skipped
  }
  CloneEntityType::cloneEntityTypeField(['field' => $field, 'values' => $values], $context);
}
```

`$context` is only used for batch progress messages; an empty array is fine.

> `cloneEntityTypeFinishedCallback()` calls `RedirectResponse::send()` — do **not** call it from
> CLI/drush code.

## Doing it by hand (equivalent, and easier to reason about)

```php
use Drupal\node\Entity\NodeType;
use Drupal\field\Entity\FieldConfig;

// 1. the bundle
$src = NodeType::load('article');
$dst = $src->createDuplicate();
$dst->set('uuid', \Drupal::service('uuid')->generate());
$dst->set('name', 'Article Copy')->set('type', 'article_copy')
    ->set('originalId', 'article_copy')->set('description', '…');
$dst->save();

// 2. the fields
foreach (\Drupal::service('entity_field.manager')->getFieldDefinitions('node', 'article') as $def) {
  if (!$def instanceof FieldConfig) {
    continue;
  }
  $new = $def->createDuplicate();
  $new->set('entity_type', 'node')->set('bundle', 'article_copy')->save();
}

// 3. the displays
$repo = \Drupal::service('entity_display.repository');
foreach (array_keys($repo->getFormModeOptionsByBundle('node', 'article')) as $mode) {
  $srcD = $repo->getFormDisplay('node', 'article', $mode)->toArray();
  unset($srcD['_core']);
  $data = json_decode(str_replace('article', 'article_copy', json_encode($srcD)), TRUE);
  $data['uuid'] = \Drupal::service('uuid')->generate();
  \Drupal::configFactory()
    ->getEditable("core.entity_form_display.node.article_copy.$mode")
    ->setData($data)->save();
}
```

(The module's own `EntityTypeCloneController::arrayReplace()` does the same recursive string
replacement in PHP rather than via JSON.)

## `EntityTypeCloneController` helpers

| Method | Signature | Behaviour |
|---|---|---|
| `arrayReplace()` | `(string $find, string $replace, array $arr): array` | Recursive `str_replace` over string values; bools/numerics pass through untouched. |
| `copyFieldDisplay()` | `($display, $mode, $data)` | `$display` is `'form'` or `'view'`; copies one display for one field. Returns early when the source display's `status` is falsy. |

`UUIDController::uuidGet()` is a debugging helper that returns `[bundle_entity_type][bundle_id] =>
uuid` for every content entity type; it is not routed.

## Role clone from code

```php
use Drupal\user\Entity\Role;

$src = Role::load('editor');
$new = Role::create(['id' => 'editor_copy', 'label' => 'Editor copy']);
$new->save();
user_role_grant_permissions($new->id(), $src->getPermissions());
```

## Gotchas

- `cloneEntityTypeField()` first checks `entity_field.manager->getFieldDefinitions()` for the
  **target** bundle and skips fields already present — so re-running is safe for fields but will
  re-save displays.
- Field **storage** is shared, so cloning never duplicates `field.storage.*`; the clone reuses the
  same storage as the source.
- Displays are copied by string replacement of the bundle machine name. Choose target machine names
  that are not substrings of unrelated values in the display config.
- `taxonomy_term` clones start from a blank `Vocabulary::create()`, so anything configured on the
  source vocabulary entity itself is lost (only fields and displays come across).
