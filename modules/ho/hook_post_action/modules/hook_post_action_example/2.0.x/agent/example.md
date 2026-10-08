<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook Post Action Example — handlers

`hook_post_action_example.module` implements every hook_post_action hook; each writes one log line
to the `hook_post_action_test` channel. Enable the module and edit content to see them.

## Handlers and their log output

| Handler (hook) | Logs (channel `hook_post_action_test`) |
|---|---|
| `hook_post_action_example_entity_postsave($entity, $op)` | "The `<inserted/updated/deleted>` entity `<type>` id is `<id>` from …" |
| `hook_post_action_example_entity_postinsert($entity)` | "The inserted entity `<type>` id is `<id>` …" |
| `hook_post_action_example_entity_postupdate($entity)` | "The updated entity `<type>` id is `<id>` …" |
| `hook_post_action_example_entity_postdelete($entity)` | "The deleted entity `<type>` id is `<id>` …" |
| `hook_post_action_example_node_postsave($entity, $op)` | "The `<op>` node `<bundle>` id is `<id>` …" |
| `hook_post_action_example_node_postinsert($entity)` | "The inserted node `<bundle>` id is `<id>` …" |
| `hook_post_action_example_node_postupdate($entity)` | "The updated node `<bundle>` id is `<id>` …" |
| `hook_post_action_example_node_postdelete($entity)` | "The deleted node `<bundle>` id is `<id>` …" |

So a single node insert produces four messages (node_postinsert, node_postsave, entity_postinsert,
entity_postsave).

## The op → past tense helper

```php
function _hook_post_action_example_op_past_tense(string $op): string {
  // insert->inserted, update->updated, delete->deleted, default->saved
}
```

## Copy-paste template

```php
use Drupal\Core\Entity\EntityInterface;

function MYMODULE_entity_postinsert(EntityInterface $entity) {
  // Your side effect here (queue, API call, cache invalidation, …).
  \Drupal::logger('my_channel')->info('inserted @t:@id', [
    '@t' => $entity->getEntityTypeId(), '@id' => $entity->id(),
  ]);
}
```

For the hook list, signatures, and dispatch mechanism see the parent module's
[hooks/post-hooks.md](../../../../2.0.x/agent/hooks/post-hooks.md).
