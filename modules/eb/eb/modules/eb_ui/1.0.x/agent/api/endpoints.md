<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eb_ui — API endpoints, YAML editor & grid providers

## Install / enable
```bash
drush en eb_ui -y
```
Requires `eb`. No external composer libraries; the CodeMirror editor is loaded from a CDN (`cdnjs.cloudflare.com`) via the `eb_ui/codemirror` library, or you can switch to a plain textarea. Configure at `/admin/config/development/eb/settings/ui`.

## AJAX API (`Controller\EbUiApiController`)
POST endpoints run `validateAjaxRequest()` first: reject unless `X-Requested-With: XMLHttpRequest` (403), unless authenticated (403), and unless a valid `X-CSRF-Token` header matching `CsrfRequestHeaderAccessCheck::TOKEN_KEY` is present (403); reject bodies over `MAX_CONTENT_SIZE` = 5 MB (413). Parsed data is checked against `MAX_JSON_DEPTH` = 10. The CSRF token is handed to JS via `drupalSettings.ebUi.csrfToken` in the editor form.

| Endpoint | Method | Route access | Behaviour |
|---|---|---|---|
| `/eb/api/validate` | POST | admin / `import entity architecture` / `create entity definitions` / `edit own entity definitions` | Body is raw YAML or JSON grid data. Detects definition vs. operation format (`OperationDataBuilder::isDefinitionFormat()`), builds operations (`OperationBuilder::buildBatch()`), runs `ValidationManager::validateBatch()`. Returns `{valid, operation_count, errors[]}`. **Does not persist or execute.** |
| `/eb/api/preview` | POST | admin / `import entity architecture` / `preview entity definitions` | Same parse/build path, then `PreviewGenerator::generateBatchPreview()` over `PreviewableOperationInterface` operations. Returns `{success, operation_count, previews[]}`. **Preview only — no execution or persistence.** Preview reflects the caller's own submitted content back to the caller. |
| `/eb/api/bundles/{entity_type_id}` | GET | admin / `create` / `edit own` | Returns `{success, bundles:{id,label}}` from `entity_type.bundle.info`. `no_cache`. |
| `/eb/api/entity-config/{entity_type_id}/{bundle}` | GET | admin / `create` / `edit own` | Returns `{success, fields:{name,label,type,required}}` for configurable (non-base) fields via `entity_field.manager`. `no_cache`. |

All endpoints wrap logic in try/catch and return the exception message in an `errors[]` array (validate/preview return HTTP 200 with `valid/success: false`; bundles/entity-config return 500 on error).

## YAML editor form (`Form\EbUiYamlForm`)
Routes `eb_ui.add` (new) and `eb_ui.edit` (existing, gated by `DefinitionEditAccess`). `buildForm()` loads the definition when editing and calls `verifyAccess()` (defense-in-depth: `createAccess()` for new, `$definition->access('update')` for existing — throws `AccessDeniedHttpException` otherwise). Fields: label, machine-name `definition_id` (disabled when editing), description, and a YAML textarea (`#eb-yaml-editor`). `definitionToYaml()` serialises the entity with Symfony `Yaml::dump($data, 10, 2)`; `validateForm()`/`submitForm()` parse with `Yaml::parse()` (arrays only) and write the `*_definitions` back onto the entity via its setters, then `save()`. "Save and Apply" (`saveAndApply()`) runs save then redirects to `entity.eb_definition.apply_form` (which enforces `apply` access) — the form itself never executes operations. YAML parsing uses Symfony YAML without object/custom-tag flags, so no PHP-object deserialization occurs.

## Custom access checker (`Access\DefinitionEditAccess`)
Service `eb_ui.definition_edit_access`, tag `access_check applies_to _eb_definition_edit_access`. `access()`: empty `definition_id` → `createAccess()`; definition not found → `AccessResult::forbidden()`; otherwise → `$definition->access('update', $account, TRUE)`. Delegates entirely to `EbDefinitionAccessControlHandler` (Tier 1 ownership model).

## Grid provider discovery (`Service\GridProviderManager`)
`getAvailableProviders()` invokes `hook_eb_ui_grid_provider_info()` across modules, normalising each entry (requires `label` + `form_class`; defaults `library`/`theme_class` to NULL). `getActiveProvider()` reads `eb_ui.settings.editor_mode`: `yaml` → NULL (force YAML editor); `auto` → first available provider (or NULL if none); a specific id → that provider (fallback to first). `isYamlMode()` = no active provider. Implement the hook to register a spreadsheet UI (see `eb_aggrid`).

## Settings form (`Form\EbUiSettingsForm`)
Route `eb_ui.settings`, config `eb_ui.settings`. `editor_mode` radios (YAML / Auto / each discovered provider) and `yaml_editor` radios (`codemirror_cdn` / `plain_textarea`).
