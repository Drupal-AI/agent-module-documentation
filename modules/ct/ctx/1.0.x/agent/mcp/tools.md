<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CTX tool catalog

All tools are `mcp_tool` plugins on server `ctx`, reached via mcp_core's `/mcp/ctx` endpoint. IDs are the `#[McpTool(id: …)]` values; class paths are under `src/Plugin/McpTool/`. Arguments listed are the `__invoke()` parameters / `inputSchema` keys.

## Extension (`Extension/`)
- `ctx_extension_path` — resolve an extension's filesystem path. (`ExtensionPathTool`)
- `ctx_module_list` — list modules with status. (`ModuleListTool`)
- `ctx_module_info` — show one module's info. (`ModuleInfoTool`)
- `ctx_module_install` — install one or more modules. (`ModuleInstallTool`)
- `ctx_module_uninstall` — uninstall modules. (`ModuleUninstallTool`)

## Configuration (`Config/`)
- `ctx_config_list` — list config object names. (`ConfigListTool`)
- `ctx_config_get` — read a config object. (`ConfigGetTool`)
- `ctx_config_set` — set dot-keyed values in an existing config object and save (`name`, `values`). (`ConfigSetTool`)
- `ctx_config_delete` — delete a config object. (`ConfigDeleteTool`)
- `ctx_config_diff` — diff active vs. sync. (`ConfigDiffTool`)
- `ctx_config_status` — import/export status. (`ConfigStatusTool`)
- `ctx_config_import` — import configuration. (`ConfigImportTool`)
- `ctx_config_export` — export configuration. (`ConfigExportTool`)

## Config entities (`ConfigEntity/`, `ConfigEntityType/`)
- `ctx_config_entity_create` / `_view` / `_query` / `_update` / `_validate` / `_delete` — CRUD + validate + query for config entities.
- `ctx_config_entity_type_list` — list config entity types. (`ConfigEntityType/ListTool`)
- `ctx_config_entity_type_info` — one config entity type's definition. (`ConfigEntityType/InfoTool`)

## Content entities (`ContentEntity/`, `ContentEntityType/`)
- `ctx_content_entity_create` / `_view` / `_render` / `_update` / `_validate` / `_delete` — CRUD, render in a view mode, validate.
- `ctx_content_entity_query` — Entity Query API search; conditions support dot notation across references; `limit` clamped to 100; returns `{ids}`. Uses `accessCheck(FALSE)`. (`ContentEntity/QueryTool`)
- `ctx_content_entity_type_list` — list content entity types. (`ContentEntityType/ListTool`)
- `ctx_content_entity_type_info` — one content entity type's definition. (`ContentEntityType/InfoTool`)
- `ctx_content_entity_type_field_info` — field/storage definitions for a type/bundle. (`ContentEntityType/FieldInfoTool`)
- `ctx_content_entity_type_erd` — entity-relationship diagram of references. (`ContentEntityType/ErdTool`)

## Database (`Database/`)
- `ctx_database_query` — run any SQL against the default connection; `:name` placeholders (array values expand for `IN`), `{table}` prefix expansion; read statements route through `Connection::query()`, others through `prepareStatement(..., TRUE)`; multi-statement `;` is rejected by core. Returns `{rows, rowCount}`. (`Database/QueryTool`)
- `ctx_database_connection_info` — connection driver/details. (`Database/ConnectionInfoTool`)
- `ctx_database_update` — apply pending update hooks (update.php). (`Database/UpdateTool`)

## PHP escape hatches (`Php/`)
- `ctx_php_eval` — `eval($code . ';')` inside Drupal; returns captured output. (`Php/PhpEvalTool`)
- `ctx_php_script` — `include` a readable local PHP file (resolved via `realpath`) inside a static closure that sees only `$arguments` and `$scriptPath`. (`Php/PhpScriptTool`)

The server `instructions` tell agents to use these only when no dedicated tool fits.

## Plugins & services (`Plugin/`, `Service/`, `Router/`)
- `ctx_plugin_type_list` — list discoverable plugin types. (`Plugin/PluginTypeListTool`)
- `ctx_plugin_list` — list plugins of a type. (`Plugin/PluginListTool`)
- `ctx_service_list` — list container services. (`Service/ServiceListTool`)
- `ctx_service_info` — one service's definition. (`Service/ServiceInfoTool`)
- `ctx_router_info` — list routes. (`Router/RouterInfoTool`)

See [../api/plugin-type-registry.md](../api/plugin-type-registry.md) for how plugin types are discovered.

## State / Queue / Watchdog / Cron / Cache
- `ctx_state_get` / `ctx_state_set` / `ctx_state_delete` — key/value State store. (`State/`)
- `ctx_queue_list` / `ctx_queue_delete` — inspect / drain queues. (`Queue/`)
- `ctx_watchdog_list` / `ctx_watchdog_clear` — read / clear the dblog. (`Watchdog/`)
- `ctx_cron_run` — trigger cron. (`Cron/CronTool`)
- `ctx_cache_clear` — clear all caches. (`Cache/CacheClearTool`)

## User & Site (`User/`, `Site/`)
- `ctx_user_permission_list` — list all defined permissions. (`User/PermissionListTool`)
- `ctx_user_login_link` — one-time login URL for a user, selected by exactly one of `uid`, `name`, or `role` (first active user with that role, `accessCheck(FALSE)`); blocked users are rejected; returns `user_pass_reset_url()`. (`User/LoginLinkTool`)
- `ctx_site_settings` — read site settings. (`Site/SettingsTool`)
- `ctx_site_requirements` — status-report / requirements data. (`Site/RequirementsTool`)

## File (`File/`)
- `ctx_file_create` — create a managed `file` entity from a local path or Drupal URI; `destination` (default `public://`), `exists` (`rename`/`replace`/`error`); returns `{id, uri, filesize}`. (`File/CreateTool`)
