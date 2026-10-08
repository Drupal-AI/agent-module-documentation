<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Assistant / AI Architect (aia) — agent index

AI-powered Drupal site-building automation. Describe a goal in natural language and AIA generates the matching configuration — content types, fields, taxonomies, blocks, views, menus, paragraph types — behind a mandatory **dry-run preview + apply** flow with per-task **rollback** and an audit trail. Machine name `aia`; package AI; `^10.2 || ^11`; PHP `>=8.4`.

## Dependencies
Drupal `node`, `field`, `taxonomy`, `block_content`, `views`, `menu_link_content`, and the contrib **`ai`** module (`drupal/ai:^1.2`) for the real LLM backend. `paragraphs` is optional (only the `generate_paragraph_type` action needs it). No config schema shipped; no third-party libraries.

## What it provides
- **Plugin type `AiaAction`** (`Plugin/AiaAction`, attribute `Drupal\aia\Attribute\AiaAction`, manager service `aia.action_manager`, interface `Drupal\aia\Action\AiaActionInterface`, base `AiaActionBase`). Seven plugins: `generate_content_type`, `add_field`, `generate_taxonomy`, `generate_view`, `generate_block`, `generate_menu`, `generate_paragraph_type`.
- **Content entity `aia_task`** (`src/Entity/AiaTask.php`) — audit log of each applied action (action_type, payload/result JSON, success, rolled_back, created, uid, session_id). Schema installed in `aia_install()`.
- **Routes** (all require permission `administer aia`): `aia.overview` `/admin/config/development/aia`, `aia.execute` `/admin/config/development/aia/execute` (`AiaExecuteForm`), `aia.settings` `/admin/config/development/aia/settings` (`AiaSettingsForm`, config `aia.settings`), `aia.tasks` `/admin/reports/aia` (entity list), `aia.task_rollback` `/admin/reports/aia/task/{aia_task}/rollback` (`AiaTaskRollbackForm`).
- **Permission**: single `administer aia` (`restrict access: true`), also the entity `admin_permission`.
- **Services**: `aia.ai_request_service` (default `MockAIRequestService`; real = `AIRequestService` via `aia.provider_resolver`), `aia.action_router`, `aia.pipeline`, `aia.task_logger`, `aia.rollback_service`, `aia.diff_generator`, `aia.error_formatter`, seven `*_payload_validator`s + `aia.structured_response_validator`.
- **Drush** (`drush.services.yml`): `aia:execute`, `aia:dry-run`, `aia:list`, `aia:info`, `aia:tasks`, `aia:rollback` (`AiaCommands`) plus debug commands.

## Solution docs
- [agent/architecture/overview.md](architecture/overview.md) — the dry-run→validate→diff→apply→log→rollback pipeline, router, and how a request flows through the services.
- [agent/plugins/actions.md](plugins/actions.md) — the `AiaAction` plugin contract and all seven action plugins (payloads, what each writes).
- [agent/api/drush.md](api/drush.md) — the six Drush commands, options, and conflict handling.
- [agent/config/settings.md](config/settings.md) — install/enable, `aia.settings` keys, and swapping Mock for real AI.
- [agent/entity/aia_task.md](entity/aia_task.md) — the audit-log entity, task history, and rollback.
