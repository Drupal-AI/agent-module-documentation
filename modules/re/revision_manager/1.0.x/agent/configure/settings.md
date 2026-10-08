<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Revision Manager

## Where

Settings form: **`/admin/config/content/revision-manager`** (route
`revision_manager.settings`, permission **`administer revision_manager`**). All global settings
live in the config object **`revision_manager.settings`**.

## `revision_manager.settings` keys

| Key | Type | Meaning |
|---|---|---|
| `enabled_entities` | map `entity_type_id => bool` | which entity types are managed (e.g. `node: true`). |
| `defaults` | `entity_type_id => plugin_id => {id, status, settings}` | per-entity-type default policy for each plugin. |
| `disable_automatic_queueing` | bool | if TRUE, entities are **not** auto-enqueued on save. |
| `verbose_log` | bool | log revision deletions to watchdog. |

A `defaults` entry for the `amount` plugin on nodes looks like:

```yaml
defaults:
  node:
    amount:
      id: amount
      status: true            # plugin enabled for this entity type
      settings:
        amount: 3             # keep the newest 3 revisions
    age:
      id: age
      status: false
      settings:
        age: 6                # months (used when age.status is true)
```

### Enable node revision management, keep newest 3 (drush)

```php
$c = \Drupal::configFactory()->getEditable('revision_manager.settings');
$enabled = $c->get('enabled_entities') ?: [];
$enabled['node'] = TRUE;
$c->set('enabled_entities', $enabled);
$defaults = $c->get('defaults') ?: [];
$defaults['node']['amount'] = ['id' => 'amount', 'status' => TRUE, 'settings' => ['amount' => 3]];
$c->set('defaults', $defaults)->save();
```

Read back: `drush cget revision_manager.settings` (see `enabled_entities.node`,
`defaults.node.amount.settings.amount`).

## Per-bundle overrides (third-party settings)

A bundle can override the entity-type defaults. When Revision Manager is enabled for the entity
type, its plugin subforms are added to the **bundle edit form** (e.g. Article settings), and
non-default values are saved as a **third-party setting** on the bundle config entity:

```yaml
# config: node.type.article
third_party_settings:
  revision_manager:
    amount:
      id: amount
      status: true
      settings:
        amount: 10
```

Schema: `node.type.*.third_party.revision_manager` (and `media.type.*`, `taxonomy.vocabulary.*`,
`block_content.type.*`, `system.menu.*`, `group.type.*`) → `revision_manager.plugin_collection`.
Set/read with `$bundle->setThirdPartySetting('revision_manager', 'amount', [...])` /
`getThirdPartySettings('revision_manager')`.

## Combining Amount + Age (important)

When **both** plugins are enabled for a type/bundle, deletion is **conservative**: a revision is
deleted only if *every* enabled plugin independently flags it. The current revision and any
forward (pending) revisions are always preserved. More enabled criteria ⇒ fewer deletions.

## Running cleanup

- **Automatic**: on entity save the entity is enqueued into the `remove_revisions` queue —
  unless `disable_automatic_queueing` is TRUE.
- **On demand**: tick "Enqueue enabled entities for revision deletion" on the settings/bundle
  form, or run `drush rm:queue` (see [drush/commands.md](../drush/commands.md)).
- The queue worker actually deletes the flagged revisions when the queue is processed (cron).
