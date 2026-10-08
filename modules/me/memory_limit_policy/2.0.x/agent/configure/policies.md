<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure memory limit policies

## The config entity

Type `memory_limit_policy` (`config_prefix: memory_limit_policy`), so each policy is stored as
config `memory_limit_policy.memory_limit_policy.<id>`. Exported properties (`config_export`):

| Key | Type | Notes |
|---|---|---|
| `id` | machine_name | policy id |
| `label` | string | human name |
| `status` | boolean | disabled policies are **not** evaluated |
| `weight` | integer | evaluation order, ascending; last match wins |
| `memory` | string | the limit to apply, e.g. `256M`, `512M`, `1G` (passed straight to `ini_set('memory_limit', …)`) |
| `langcode` | langcode | |
| `policy_constraints` | sequence | ordered list of constraint plugin instances |

Each entry in `policy_constraints` is a map keyed by the constraint plugin id plus its config,
always including `id` and `negate`, e.g.:

```yaml
policy_constraints:
  - id: path
    negate: false
    paths: "/admin/reports/*"
  - id: role
    negate: false
    roles:
      content_editor: content_editor
```

The per-plugin config keys are documented in each condition submodule's `plugins/*` doc
(`roles`, `paths`, `routes`, `methods`, `header_name`/`header_value`/`match_mode`,
`query_param`, `domains`, `name`/`values`, `drush_commands`).

## UI

- List / add / reorder: `/admin/config/performance/memory-limit-policy/list`
  (route `entity.memory_limit_policy.collection`, the module's `configure` route).
- Add form: `/admin/config/performance/memory-limit-policy/add` (a multi-step form — set
  label/memory/weight/status, then add constraints).
- Edit: `/admin/config/performance/memory-limit-policy/{id}`.
- Enable/disable/delete: `.../{id}/enable`, `.../{id}/disable`, `.../policy/{id}/delete`.
- Constraint add/edit/delete run through `\Drupal\memory_limit_policy\Form\ConstraintEdit` /
  `ConstraintDelete` (routes `entity.memory_limit_policy.constraint.*`).
- All routes require the `administer memory limit policies` permission.

## Module settings

`memory_limit_policy.settings` has a single key `header` (boolean, default `false`) at
`/admin/config/performance/memory-limit-policy/settings`
(`MemoryLimitPolicySettingsForm`). When `true`, responses get debug headers
`X-Memory-Limit-Memory`, `X-Memory-Limit-Override`, `X-Memory-Limit-Policy-Name`.

## Drush / programmatic

No dedicated config drush command in the base module. Manage policies with the entity API:

```php
$storage = \Drupal::entityTypeManager()->getStorage('memory_limit_policy');
$storage->create([
  'id' => 'heavy_reports',
  'label' => 'Heavy reports',
  'memory' => '512M',
  'status' => TRUE,
  'weight' => 0,
  'policy_constraints' => [
    ['id' => 'path', 'negate' => FALSE, 'paths' => "/admin/reports/*"],
  ],
])->save();
```

Set the debug-header toggle with:
`drush config:set memory_limit_policy.settings header true -y`.
