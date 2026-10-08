<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behavior: when the widget shows and what it does

Single hook-service class
`Drupal\entityqueue_form_widget\Hook\EntityqueueFormWidgetHooks` (registered as an autowired
service, `entityqueue_form_widget.services.yml`). No config to set — behavior is entirely
driven by the Entityqueue queues that exist on the site.

## Where it appears

`#[Hook('form_node_form_alter')]` → only on **node** add/edit forms. It adds a `details`
element keyed `entityqueue_form_widget` into the `advanced` group (`#group => 'advanced'`),
i.e. the right sidebar, weight 100, titled "Entityqueues settings", with intro text linking
to the Entityqueue management page (`entity.entity_queue.collection`).

The element is added **only if** `getAllowedSubqueueList($node)` is non-empty — so if no queue
matches the node, no widget renders.

## Which subqueues match (`getAllowedSubqueueList()`)

For every `entity_subqueue`, look at its parent queue's entity settings:

- include it when `entity_settings.target_type` == the node's entity type id (`node`), **and**
- `handler_settings.target_bundles` is empty (all bundles) **or** contains the node's bundle.

So a queue targeting `node` / Article shows on Article forms; a queue targeting
`node` / Page does not.

## Which checkboxes render (permissions)

Inside the panel, `$form['entityqueue_form_widget']['entityqueues'][<queue_id>]` is a checkbox
added for each matching subqueue **only if** the current user has
`update <queue_id> entityqueue` **or** `manipulate all entityqueues`. These are
**Entityqueue's** permissions; this module declares none. Each checkbox:

- title shows `label (N out of MAX items)` (MAX `0` → "unlimited"; multiple-handler queues
  also show the parent queue label),
- `#default_value` = 1 when the node is already in that subqueue (queried from
  `entity_subqueue__items`),
- is **disabled** when the queue is full (`items >= max`), not already checked, and the queue
  does not "act as queue".

## On submit (`doNodeFormSubmit()`)

The submit handler is appended to each non-preview submit button. For values under
`entityqueue_form_widget['entityqueues']`:

- **Checked** queues → `EntitySubqueue::addItem($node); ->save()` (skipped when the node is
  unpublished and has no `publish_on` — Scheduler support: a `publish_on` timestamp counts as
  will-be-published).
- **Unchecked** queues → `EntitySubqueue::removeItem($node); ->save()` — but only removed when
  a published revision of the node exists; if there is no published version it is removed from
  all listed queues.

## Consequences for an agent

- To make the widget appear on a content type's form, create/enable an Entityqueue whose
  target type is `node` and whose `target_bundles` includes that bundle (or is empty).
- Programmatic queue membership is plain Entityqueue API
  (`EntitySubqueue::load(<id>)->addItem($node)->save()`); this module only wires that into the
  node form.
- Nothing here is stored in this module's config — queues live in `entityqueue.*` config and
  the `entity_subqueue` content entities.
