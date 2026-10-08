<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Factors: settings routes, forms & config schema

Marketing "factors" are the criteria the AI scores content against. They are stored in the
**`analyze_ai_content_marketing_audit_factors`** DB table (not config entities) and managed through
four forms. Every route requires **`_permission: administer analyze`** (routing.yml).

## Routes (analyze_ai_content_marketing_audit.routing.yml)

| Route id | Path | Form |
|---|---|---|
| `...settings` | `/admin/config/analyze/content-marketing-audit` | `ContentMarketingAuditSettingsForm` |
| `...factor.add` | `.../factor/add` | `AddFactorForm` |
| `...factor.edit` | `.../factor/{factor_id}/edit` | `EditFactorForm` |
| `...factor.delete` | `.../factor/{factor_id}/delete` | `DeleteFactorForm` |

Menu/task/action links (`.links.*.yml`): settings link sits under `ai.admin_settings`; a local task
"Settings" and a "Results" task pointing at the report View; an "Add factor" action link on the
settings page. `info.yml` `configure:` points at `...settings`.

## Forms (src/Form/)

- **`ContentMarketingAuditSettingsForm`** — lists factors in two `#type => table` sections
  (quantitative, qualitative) with tabledrag weight + an enabled checkbox per row, plus Edit/Delete
  operations. `submitForm()` only writes back **weight** and **status** per factor (via
  `storageService->saveFactor()`, preserving existing label/description/type/options), then
  `invalidateConfigCache()`. Also shows a "View reports" button if the user has `access site
  reports`.
- **`AddFactorForm`** — fields: `label`, `id` (`machine_name`, uniqueness via `factorExists()`),
  `description` (textarea), `type` (`quantitative`|`qualitative`), `options` (textarea, one per line,
  only for qualitative), `weight`, `status`. `validateForm()` enforces a unique id and, for
  qualitative, ≥2 non-empty options. `submitForm()` splits options by newline and calls
  `saveFactor()`.
- **`EditFactorForm`** — same shape, pre-populated; updates the existing row.
- **`DeleteFactorForm`** — confirm form; calls `storage->deleteFactor()` which removes the factor
  **and** its rows in the results table.

## Config schema (config/schema/analyze_ai_content_marketing_audit.schema.yml)

Declares one `config_object` **`analyze_ai_content_marketing_audit.settings`** with a `factors`
sequence (id/label/description/weight/status). Note: the runtime factor store is the **DB table**,
not this config object — the schema exists for completeness / potential config export of factor
metadata. `provides_config_schema: true`; no `config/install/*.settings.yml` ships (only the Views
report config, see the storage doc).

## Install defaults (analyze_ai_content_marketing_audit.install)

`hook_install()` creates both tables and seeds eight factors, all `status = 1`:

- Quantitative (weight 0–6): **usability, knowledge_level, actionability, accuracy, business_value,
  messaging, brand_voice_fit** — each scored -1.0…+1.0.
- Qualitative (weight 100): **funnel_stage** with options `Awareness, Consideration, Decision,
  Retention`.

`hook_uninstall()` empties both tables. Update hooks: `_update_8001` migrates old analyzer plugin
ids in `analyze.settings`; `_8002`/`_8003`/… adjust the report View filters, add a unique key on
`(entity_type, entity_id, factor_id, langcode)` and de-duplicate results.
