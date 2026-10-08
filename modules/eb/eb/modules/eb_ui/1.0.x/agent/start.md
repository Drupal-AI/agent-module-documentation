<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Builder UI (eb_ui) — agent index

Browser editing layer for Entity Builder (`eb`): a CodeMirror-enhanced YAML editor form, shared AJAX API endpoints, and a grid-provider discovery system. Sub-module of the `eb` project. **Release documented: `1.0.0-alpha1` (pre-release).** Core `^11`. Package: Entity Builder. Depends on `eb:eb`.

## What it provides
- **YAML editor form** — `Form\EbUiYamlForm` (routes `eb_ui.add`, `eb_ui.edit`). Loads/saves an `eb_definition`, renders YAML via CodeMirror 5 (CDN) or plain textarea, dumps the definition with Symfony `Yaml::dump` and parses input with `Yaml::parse`. Verifies access programmatically (`verifyAccess()`) as defense-in-depth. "Save and Apply" appears only if `$definition->access('apply')`.
- **API controller** — `Controller\EbUiApiController` with 4 endpoints (validate, preview, getBundles, getEntityConfig). POST endpoints require auth + `X-CSRF-Token` + `X-Requested-With: XMLHttpRequest` (`validateAjaxRequest()`), enforce 5 MB content and JSON depth ≤ 10. They validate/preview only — they do not execute operations.
- **Grid provider system** — `Service\GridProviderManager` (`eb_ui.grid_provider_manager`) discovers providers via `hook_eb_ui_grid_provider_info()`; `getActiveProvider()`/`isYamlMode()` pick the active editor from `eb_ui.settings.editor_mode`.
- **Custom access checker** — `Access\DefinitionEditAccess` (service `eb_ui.definition_edit_access`, `_eb_definition_edit_access`) delegates to the `eb_definition` access handler (createAccess for new, `update` for existing; denies when definition missing).
- **Settings form** — `Form\EbUiSettingsForm` (route `eb_ui.settings`).

## Routes (`eb_ui.routing.yml`)
| Route | Path | Access |
|---|---|---|
| `eb_ui.add` | `/admin/config/development/eb/definitions/add` | perm `administer entity builder` OR `create entity definitions` |
| `eb_ui.edit` | `/admin/config/development/eb/definitions/{definition_id}/edit` | `_eb_definition_edit_access` (entity update/create access) |
| `eb_ui.api.validate` | `/eb/api/validate` (POST) | perm admin OR `import entity architecture` OR `create` OR `edit own` |
| `eb_ui.api.preview` | `/eb/api/preview` (POST) | perm admin OR `import entity architecture` OR `preview entity definitions` |
| `eb_ui.api.bundles` | `/eb/api/bundles/{entity_type_id}` | perm admin OR `create` OR `edit own` |
| `eb_ui.api.entity_config` | `/eb/api/entity-config/{entity_type_id}/{bundle}` | perm admin OR `create` OR `edit own` |
| `eb_ui.settings` | `/admin/config/development/eb/settings/ui` | perm `administer entity builder` |

## Config
`eb_ui.settings`: `editor_mode` (`yaml`/`auto`/provider id, default `auto`), `yaml_editor` (`codemirror_cdn`/`plain_textarea`, default `codemirror_cdn`). Schema `config/schema/eb_ui.schema.yml`.

## Libraries (`eb_ui.libraries.yml`)
`base`, `modals`, `yaml-editor` (local JS/CSS), and `codemirror` (CodeMirror 5.65.18 loaded from `cdnjs.cloudflare.com`, external).

## Solution docs
- `agent/api/endpoints.md` — the 4 API endpoints, the YAML editor form, the grid-provider hook, settings.
