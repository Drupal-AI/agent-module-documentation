<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — replicating from code, Action / Rules / Views integrations

Replicate UI does the cloning through the **Replicate** module's service; it adds no
new service of its own. Its own services are internal (`replicate_ui.route_subscriber`,
`replicate_ui.access_check`) and normally not called directly.

## Clone an entity in code — `replicate.replicator`

Service id `replicate.replicator` → `\Drupal\replicate\Replicator`.

```php
$replicator = \Drupal::service('replicate.replicator');

// Deep-clone AND save a new entity (this is what the UI/action use). Returns the
// saved copy; child/referenced entities are cloned per Replicate's event subscribers.
$copy = $replicator->replicateEntity($original_entity);

// Clone by id (loads, then replicateEntity):
$copy = $replicator->replicateByEntityId('node', 42);

// Clone WITHOUT saving (you save it yourself after further edits):
$clone = $replicator->cloneEntity($original_entity);
$clone->set('title', 'Draft copy');
$clone->save();
```

`replicateEntity()` = `cloneEntity()` + `save()`. The clone copies field values as-is;
Replicate UI's confirm form additionally overwrites the **label** with a user-supplied
value (default `"{label} (Copy)"`) before saving — replicate that yourself if you want
a distinct label:

```php
$clone = $replicator->cloneEntity($node);
$clone->set($node->getEntityType()->getKey('label'), $node->label() . ' (Copy)');
$clone->save();
```

## Action plugin — `entity_replicate` (Views Bulk Operations)

Derived per enabled entity type by `EntityReplicateActions`. Ids look like
`entity_replicate:entity_node_replicate`. Its `execute($entity)` calls
`replicateEntity()`; `access()` reuses `ReplicateAccessChecker`. Use it as a bulk
operation in a View (e.g. with Views Bulk Operations) to duplicate many rows at once.
Actions only appear for entity types enabled in `replicate_ui.settings`.

## Rules action — `replicate_ui_entity_replicate`

`\Drupal\replicate_ui\Plugin\RulesAction\EntityReplicateAction`, label "replicate
entity", category "Entity". Context: one `entity`. Its `doExecute($entity)` calls
`replicateEntity()`. Available whenever the Rules module is installed (independent of
the `entity_types` setting).

## Views field — `replicate_ui_link`

`\Drupal\replicate_ui\Plugin\views\field\ReplicateUILink` extends core `EntityLink`,
rendering a link to the entity's `replicate` link template (default label
"Replicate"). Add it to a View to show a Replicate link column. Requires the entity
type to be enabled (so the `replicate` link template exists).

## Entity operation

`replicate_ui_entity_operation()` adds a `replicate` operation (title "Replicate",
weight 45) to enabled entity types that have a `replicate` link template and pass
access — this is the link seen on admin content listings.
