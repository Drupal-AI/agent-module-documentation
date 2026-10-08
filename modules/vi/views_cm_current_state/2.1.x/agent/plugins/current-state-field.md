<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `current_state_views_field` handler

One Views **field** handler. The module does **not** define a new plugin *type* — it registers a
handler against core's `@ViewsField` plugin type.

- Class: `Drupal\views_cm_current_state\Plugin\views\field\CurrentStateViewsField`
- Annotation: `@ViewsField("current_state_views_field")`
- Base: `FieldPluginBase`, also implements `TrustedCallbackInterface`.

## Registration (`views_cm_current_state.views.inc`)

`hook_views_data()` attaches the field to the **global** `views` table so it is available in every
view:

```php
$data['views']['table']['group'] = t('Content revision');
$data['views']['table']['join'] = ['#global' => []];
$data['views']['current_state_views_field'] = [
  'title' => t('Current state'),
  'help'  => t('Content moderation content current state.'),
  'field' => ['id' => 'current_state_views_field'],
];
```

## What `render(ResultRow $values)` does

1. Takes `$values->_entity` (the row's entity).
2. Loads that entity's storage and its **latest** revision:
   `$storage->getLatestRevisionId($entity->id())` → `$storage->loadRevision(...)`. If a latest
   revision is found it replaces `$entity` with it — this is why the field can show a pending
   **forward/draft** revision's state.
3. If the (latest) revision has `moderation_state->value`, it resolves the human label via
   `content_moderation.moderation_information`:
   `getWorkflowForEntity($entity)->getTypePlugin()->getState($state)->label()` and returns it.
4. Otherwise it falls back: `isPublished()` → returns `Published`, else `Unpublished`.

## Behaviour notes for an agent

- `query()` is overridden to a **no-op** — the handler adds no SQL; it is purely render-time, so it
  is not sortable or filterable like a stored column.
- `usesGroupBy()` returns `FALSE`.
- `defineOptions()` adds only `hide_alter_empty` (default `FALSE`); otherwise standard field options.
- Difference from core `moderation_state` field: core shows the loaded (default/published) revision's
  state; this shows the **latest** revision's state, so the two columns can disagree when a draft
  edit exists above a published revision.
- Because it keys off the entity's storage generically, it works for any moderated entity type whose
  rows expose `_entity` in the view.
