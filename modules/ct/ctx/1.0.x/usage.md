CTX exposes a Drupal site's structure and state to AI coding assistants as a set of Model Context Protocol (MCP) tools, for local development only.

---

CTX registers one MCP server (id `ctx`, built on the MCP Core module) and roughly 55 `mcp_tool` plugins that let a connected AI agent explore and manipulate a Drupal site directly instead of guessing at its data model. Tools cover extension management, configuration and config-entity CRUD, content-entity CRUD and rendering, entity-type/field introspection and ER diagrams, raw database queries and update.php, plugin- and service-registry inspection, state, queue, watchdog, cron, cache clearing, router and site-requirements reporting, managed-file creation, one-time login links, and PHP eval/script escape hatches. The module ships no routes, permissions, or configuration of its own; agents reach the tools through MCP Core's bearer-token-gated `/mcp/{server}` endpoint. It requires PHP 8.4, Drupal core `^11.3`, `drupal/mcp_core`, and the `mcp/sdk` library, and is designed to pair with an agent instruction file (`AGENTS.md`/`CLAUDE.md`) that nudges the agent to prefer `ctx_*` tools over equivalent Drush commands. CTX is intended strictly for local development and must not be enabled on production or publicly accessible sites; the README recommends `$settings['config_exclude_modules'][] = 'ctx';`.

---

- Let an AI coding assistant discover your site's content entity types with `ctx_content_entity_type_list` and `ctx_content_entity_type_info`.
- Inspect a bundle's fields, cardinality, and storage with `ctx_content_entity_type_field_info` before writing migration or theming code.
- Generate a Mermaid/entity-relationship diagram of an entity type's references with `ctx_content_entity_type_erd`.
- List and read arbitrary configuration objects with `ctx_config_list` and `ctx_config_get` to see how a feature is configured.
- Update a single config value (e.g. `system.site` name or front page) with `ctx_config_set` during development.
- Diff active configuration against sync storage and check import/export status with `ctx_config_diff`, `ctx_config_status`, `ctx_config_import`, and `ctx_config_export`.
- Create, view, update, validate, delete, and query config entities (views, fields, image styles, etc.) with the `ctx_config_entity_*` tools.
- Query content entities using the Entity Query API — including dot-notation across references — with `ctx_content_entity_query`.
- Create, view, render, update, validate, and delete content entities (nodes, users, terms) with the `ctx_content_entity_*` tools while prototyping.
- Render an entity in a given view mode to inspect its output with `ctx_content_entity_render`.
- Install or uninstall modules on the fly with `ctx_module_install` and `ctx_module_uninstall`, and list/inspect them with `ctx_module_list` and `ctx_module_info`.
- Resolve an extension's filesystem path with `ctx_extension_path`.
- Run raw SQL (any statement type, named placeholders, `{table}` prefix expansion) with `ctx_database_query`, and inspect the connection with `ctx_database_connection_info`.
- Apply pending database updates (`update.php`) programmatically with `ctx_database_update`.
- List every discoverable plugin type and its plugins with `ctx_plugin_type_list` and `ctx_plugin_list`.
- List and inspect container services with `ctx_service_list` and `ctx_service_info`.
- Enumerate registered routes with `ctx_router_info` to find controllers and paths.
- Read and mutate the key/value State store with `ctx_state_get`, `ctx_state_set`, and `ctx_state_delete`.
- Inspect and drain queues with `ctx_queue_list` and `ctx_queue_delete`.
- Read and clear the log with `ctx_watchdog_list` and `ctx_watchdog_clear` to debug a failed write.
- List all defined permissions with `ctx_user_permission_list`.
- Generate a one-time login link for a user (by uid, name, or role) with `ctx_user_login_link` to test as that account locally.
- Create a managed file entity from a local path or Drupal URI with `ctx_file_create`.
- Trigger a cron run with `ctx_cron_run` and clear all caches with `ctx_cache_clear`.
- Read site settings and requirements/status-report data with `ctx_site_settings` and `ctx_site_requirements`.
- Fall back to `ctx_php_eval` or `ctx_php_script` to execute arbitrary PHP in the Drupal environment when no dedicated tool fits.
