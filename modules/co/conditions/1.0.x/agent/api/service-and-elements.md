<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# conditions — service, elements and field API

## Render elements (`src/Element`)
- `conditions` (`Conditions::getInfo`) and `conditions_groups` (`ConditionsGroups::getInfo`) build on the Plugin Form Element module to render a condition-plugin configuration UI inside any form. Use `conditions_groups` when you need multiple rows each with its own condition logic.

## Service `conditions.service` (`ConditionsService`)
Constructed with `@context.repository`, `@context.handler`, `@plugin.manager.condition`.
- `initializeConditions(array &$condition_groups, array $contexts = []): void` — hydrates each condition plugin's configuration and applies the supplied contexts (via the context handler).
- `resolveConditionsGroups(array $conditions_groups): bool` — evaluates the (already initialised) groups and returns the overall boolean using each group's AND/OR logic.

Typical use:
```php
$svc = \Drupal::service('conditions.service');
$svc->initializeConditions($groups, ['node' => $node_context]);
$visible = $svc->resolveConditionsGroups($groups);
```

## conditions_field submodule
- Field type `conditions` (`Plugin/Field/FieldType/ConditionsItem`) stores condition config as JSON (depends on `json_field`); widgets `ConditionsWidget` / `ConditionsGroupsWidget`; formatter `ConditionsEmptyFormatter`.
- `ConditionsFieldService` can find entities whose stored conditions match: it builds `JSON_EXTRACT(t.<field>_value, '$**.<key>') LIKE :<key>` queries against the field's storage table. Match values are bound parameters (`%value%`); the field/column names derive from field configuration and are guarded by `assert(preg_match(VALID_ID_REGEX, ...))`. Results are cached per `md5(serialize($condition_configuration))`.

## Extending
Register your own `@Condition` plugins; they appear automatically in the `conditions`/`conditions_groups` element UIs.