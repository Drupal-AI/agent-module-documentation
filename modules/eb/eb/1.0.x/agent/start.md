<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Builder (eb) — agent index

Declarative, YAML-driven engine that builds/modifies Drupal entity architecture (bundles, fields, displays, field groups, menus) with dependency resolution, preview, two-stage validation, rollback, and audit logging. **Release documented: `1.0.0-alpha1` (pre-release, no stable API; not covered by security advisories).** Core `^11.0`, PHP `^8.3`. Package: Architecture.

## Dependencies
Core only: `field`, `field_ui`, `user`. No external libraries. Optional Drush `^12|^13` (dev). Ships one sub-module: **eb_ui** (browser YAML editor + AJAX API) — see `../modules/eb_ui/1.0.x/agent/start.md`. Extension modules `eb_aggrid`, `eb_field_group`, `eb_pathauto`, `eb_auto_entitylabel` are separate projects, not shipped here.

## What it provides
- **Entities:** `eb_definition` (config entity, the reusable definition; access handler `EbDefinitionAccessControlHandler`), `eb_log` + `eb_rollback` + `eb_rollback_operation` (content entities for audit log and undo data).
- **Plugin types (3):** `eb_operation` (attribute `EbOperation`, base `OperationBase`), `eb_validator` (attribute `EbValidator`, base `ValidatorBase`), `eb_extension` (attribute `EbExtension`, base `EbExtensionBase`). Managers: `plugin.manager.eb_operation|eb_validator|eb_extension`.
- **12 operation plugins:** create/update/delete_bundle, create/update/delete/hide/reorder_field(s), configure_form_mode, configure_view_mode, create_menu, create_menu_link. See `agent/operations/operations.md`.
- **7 validator plugins:** field_type, unique_name, required_fields, dependency, circular_dependency, widget_compatibility, formatter_compatibility.
- **Services:** engine (`eb.operation_builder`, `eb.operation_processor`, `eb.validation_manager`, `eb.preview_generator`, `eb.rollback_manager`, `eb.dependency_resolver`, `eb.change_detector`), data (`eb.yaml_parser`, `eb.operation_data_builder`, `eb.definition_factory`, `eb.definition_generator`, `eb.discovery_service`), field/display (`eb.field_management`, `eb.display_configuration`), logging (`eb.eb_log_manager`, `logger.channel.eb`), security helpers (`eb.content_sanitizer`, `eb.export_security`). Full list in `agent/plugins/extending.md`.
- **Events:** `OperationEvents::PRE_VALIDATE/POST_VALIDATE/PRE_EXECUTE/POST_EXECUTE` (pre-execute can cancel). Hook class `EbHooks` (cascade-deletes rollbacks on definition delete).
- **Drush:** `eb:import|validate|preview|generate|export|list|discovery|rollback|rollback-list|rollback-definition|rollback-purge`. See `agent/drush/commands.md`.

## Routes & permissions
All under `/admin/config/development/eb`. Three permission tiers (see `agent/api/entities-and-routes.md`): Tier 3 `administer entity builder` (restrict access); Tier 2 privileged `apply entity definitions` / `import entity architecture` / `export entity architecture` / `rollback entity operations` (restrict access); Tier 1 ownership-based `create|edit own|view own|delete own|export|preview entity definitions`, `request definition review`.

## Config
`eb.settings` (import/rollback retention, batch limits, `supported_entity_types` allowlist, optional `export_signing_key`). See `agent/config/settings.md`. Settings form route `eb.settings`; module `configure` route is `eb.import`.

## Solution docs
- `agent/config/settings.md` — install, enable, all `eb.settings` keys + schema.
- `agent/operations/operations.md` — the 12 operations, YAML/definition format, engine flow, validators.
- `agent/plugins/extending.md` — services, events, hooks, and writing operation/validator/extension plugins.
- `agent/drush/commands.md` — every `eb:*` command with args/options.
- `agent/api/entities-and-routes.md` — entities, routes, the three-tier permission model, rollback/log.
