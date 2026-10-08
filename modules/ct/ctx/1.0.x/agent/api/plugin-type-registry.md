<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin-type registry & alter hook

Drupal has no canonical "plugin type ID", so CTX derives one to back the `ctx_plugin_type_list` / `ctx_plugin_list` tools.

## Service: `PluginTypeRegistry`
`src/Plugin/McpTool/Plugin/PluginTypeRegistry.php` (autowired in `ctx.services.yml` with `@service_container` and `@module_handler`).

`getPluginTypes(): list<array{plugin_id, manager_id, manager}>`:
1. Iterates every container service ID beginning with `plugin.manager.` (constant `PREFIX`).
2. Instantiates each; skips those throwing `ServiceCircularReferenceException` / `ServiceNotFoundException`, or not implementing `PluginManagerInterface`.
3. Derives `plugin_id` by stripping the prefix and replacing `.` with `_` (e.g. `plugin.manager.field.widget` → `field_widget`).
4. Invokes `hook_ctx_plugin_type_info_alter` on the list, then sorts by `plugin_id`.

## Service: `PluginDefinitionNormalizer`
`src/Plugin/McpTool/Plugin/PluginDefinitionNormalizer.php` — normalizes plugin definitions (which may be arrays or typed objects) into a consistent structure for the plugin-list tools.

## Hook: `hook_ctx_plugin_type_info_alter(array &$plugin_types)`
Documented in `ctx.api.php`. Passed the discovered list `[{plugin_id, manager_id, manager}]`. Use it to:
- register a manager that doesn't follow the `plugin.manager.*` convention (e.g. `validation.constraint`, `typed_data_manager`);
- rename an awkward derived ID (e.g. `field_field_type` → `field_type`);
- remove an entry (`array_filter`).

Entries are re-sorted by `plugin_id` after the hook runs. Constant `PluginTypeRegistry::HOOK = 'ctx_plugin_type_info'`.
