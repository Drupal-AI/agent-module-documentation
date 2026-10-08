<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure log types (bundles)

There is **no global settings form** for this module. All configuration is per-bundle:
a **`log_type`** config entity (one per kind of record). Manage them in the UI at
`/admin/structure/log-type` (add form `/admin/structure/log-type/add`), gated by the
`administer log types` permission. Class: `Drupal\log\Entity\LogType`
(`ConfigEntityBundleBase`); form `Drupal\log\Form\LogTypeForm`.

Config object name: `log.type.<id>` (config prefix `type`). Exported keys:

| Key | Type | Meaning |
|-----|------|---------|
| `id` | string | Machine name (bundle id, immutable after create). |
| `label` | label | Human label. |
| `description` | text | Optional description. |
| `name_pattern` | string | Token pattern used to auto-generate a log's `name` when left blank. Token type is `log`. Form default is `Log [log:id]`; required in the form. |
| `workflow` | string | `state_machine` workflow id used by the `status` field of logs of this type (e.g. `log_default`). |
| `new_revision` | boolean | Default for "Create new revision" on save (defaults to `TRUE`). |

Schema: `config/schema/log.schema.yml` (`log.type.*`). `LogType::calculateDependencies()`
adds a plugin dependency on the module providing the selected workflow.

## name_pattern (auto-naming)

If a log is saved with an empty `name`, `LogStorage::doPostSave()` generates the name by
running `name_pattern` through the token service with the `log` entity as context (see
[api/entity.md](../api/entity.md)). If the stored name still equals what the *original*
values would have generated, an update re-generates it. Examples from the test bundles:
`[log:id:value]` and `[log:id:value] [log:status:value]`. Leave `name_pattern` such that
the form is satisfied; an empty rendered name is allowed but then names are not auto-set.

## Create a log type with Drush / PHP

```php
\Drupal\log\Entity\LogType::create([
  'id' => 'observation',
  'label' => 'Observation',
  'description' => 'Field observations.',
  'name_pattern' => 'Observation [log:id]',
  'workflow' => 'log_default',
  'new_revision' => TRUE,
])->save();
```

Or ship it as config `config/install/log.type.observation.yml`:

```yaml
id: observation
label: Observation
description: 'Field observations.'
name_pattern: 'Observation [log:id]'
langcode: en
workflow: log_default
new_revision: true
```

Import with `drush config:import` (or `drush php:eval` for the `create()` form). After
adding a bundle, fields are managed through Field UI at
`entity.log_type.edit_form` (`field_ui_base_route`).

## Workflows

Bundles pick a workflow by id. The module ships workflow group `log` (`log.workflow_groups.yml`,
`entity_type: log`) and one workflow `log_default` (`log.workflows.yml`) with states
`pending`/`done` and transitions `done` (pending→done) and `to_pending` (done→pending).
Add your own by declaring a `state_machine` workflow in group `log`; it then appears in the
log-type form's Workflow select (`WorkflowManager::getGroupedLabels('log')`).
