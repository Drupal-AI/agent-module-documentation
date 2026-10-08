<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks provided

Documented in `ai_context.api.php`. Two alter hooks let other modules shape the scope system.

## `hook_ai_context_scope_info_alter(array &$definitions): void`

Add, modify, or remove scope plugin **definitions** before discovery/use (settings tabs, matching).
Invoked by `AiContextScopeManager` via `alterInfo('ai_context_scope_info')`. Use it to hide or
replace scopes based on config or optional-module availability.

```php
function my_module_ai_context_scope_info_alter(array &$definitions): void {
  if (!\Drupal::moduleHandler()->moduleExists('my_optional_module')) {
    unset($definitions['my_scope']);
  }
}
```

The module itself uses this (`ai_context_ai_context_scope_info_alter`) to hide the `entity_item`
scope when `dynamic_entity_reference` is not installed.

## `hook_ai_context_scope_values_alter(array &$values, string $scope_id): void`

Alter the `value_id => label` options a scope offers, on display paths (forms, labels, filters) via
`AiContextScopeInterface::getAlteredValues()`. Matching uses stored value ids directly and does
**not** call this hook.

```php
function my_module_ai_context_scope_values_alter(array &$values, string $scope_id): void {
  if ($scope_id === 'use_case') {
    $values['custom_workflow'] = t('Custom Workflow');
  }
}
```

## Selected hooks the module implements (in `ai_context.module`)

Relevant to integrators: `hook_help`, `hook_cron` (prunes usage records per retention settings and
runs token backfill), `hook_entity_delete` (cleans usage rows for deleted entities),
`hook_ai_context_item_insert/update/delete` (maintain the scope index),
`hook_entity_type_build`/`hook_entity_type_alter`/`hook_entity_base_field_info` (entity setup),
`hook_form_alter`/`hook_field_widget_single_element_form_alter` (item/scope form UX),
`hook_block_access`, and Scheduler bridges (`hook_scheduler_hide_publish_date`, etc.). Attribute-based
`#[Hook]` classes live in `src/Hook/` (`DiffHooks`, `DynamicEntityReferenceHooks`, `SchedulerHooks`,
`AiContextThemeHooks`).
