<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable auto-add on an Entityqueue

No settings page (`configure: null`). You turn auto-add on **per Entityqueue**, and the choice
is stored inside that queue's `entity_settings`.

## The two options

Injected by `auto_entityqueue_form_alter()` into the queue add/edit form
(`entity_queue_add_form` / `entity_queue_edit_form`), under an **"Auto Entityqueue"** fieldset:

| Option | Key | Meaning |
|---|---|---|
| Automatically add entities to queue | `auto_add` (bool) | New entities of the queue's target type/bundles are auto-added. |
| Insert entities at front of queue | `insert_front` (bool) | Prepend instead of append. Only visible when `auto_add` is on. |

## Where it is stored

Config entity `entity_queue.<queue_id>`, inside the reference handler settings:

```yaml
entity_settings:
  target_type: node
  handler: default                       # or 'views'
  handler_settings:
    target_bundles:
      article: article
    auto_entityqueue:
      auto_add: true
      insert_front: false
```

## Via the UI

1. *Structure → Entityqueues → (queue) → Edit* (or Add).
2. Set the reference **target type** and, on the reference handler, the allowed **bundles**.
3. In **Auto Entityqueue**, tick **Automatically add entities to queue** (and optionally
   **Insert entities at front of queue**).
4. Save.

## Scriptable (drush php:eval)

```php
use Drupal\entityqueue\Entity\EntityQueue;
$q = EntityQueue::load('my_queue');
$es = $q->getEntitySettings();                 // entity_settings
$es['handler_settings']['auto_entityqueue']['auto_add'] = TRUE;
$es['handler_settings']['auto_entityqueue']['insert_front'] = FALSE;
$q->set('entity_settings', $es)->save();
```

Read back:
```bash
drush cget entity_queue.my_queue entity_settings.handler_settings.auto_entityqueue
```
Or PHP: `EntityQueue::load('my_queue')->getEntitySettings()['handler_settings']['auto_entityqueue']`.

## Runtime behavior

- `auto_entityqueue_entity_insert()` runs on **entity creation only** (not updates).
- `auto_entityqueue_get_queues_by_type_and_bundle($type, $bundle)` selects queues where: target
  type matches, `target_bundles` contains the bundle, `auto_add` is TRUE, and the queue is
  **enabled** (`$queue->status()`).
- `auto_entityqueue_add_entity_to_queue()` adds the entity id to **every subqueue** of each
  matching queue. With `insert_front` it `array_unshift`es; otherwise it appends. If
  `queue_settings.max_size` is set and the subqueue is at capacity, it first pops the opposite
  end (`array_pop` for front insert, `array_shift` for back insert) — a rolling window.
- If the reference handler is `views`, target bundles are also derived from the view's
  `node.type.*` config dependencies.

## Notes

- The module has **no config schema of its own**; the `auto_entityqueue` sub-array lives under
  Entityqueue's `handler_settings` (typed as a generic mapping there).
- Requires the `entityqueue` module (`^1.8`).
