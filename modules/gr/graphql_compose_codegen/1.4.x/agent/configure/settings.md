<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings, install, status checks

## Install
```
composer require drupal/graphql_compose_codegen
drush en graphql_compose_codegen
```
Requires `graphql_compose` (which requires the `graphql` module) and Drush 12/13. Paragraphs, webform, and
scheduler are optional and only add coverage when present.

## Settings form
Route `graphql_compose_codegen.settings_form` → `/admin/config/development/graphql-compose-codegen`
(menu link under **Configuration → Development**). Gated by permission `administer graphql_compose_codegen`
(defined in `graphql_compose_codegen.permissions.yml`, `restrict access: true`). Form class
`\Drupal\graphql_compose_codegen\Form\SettingsForm` (a `ConfigFormBase`, form id
`graphql_compose_codegen_settings`).

![GraphQL Compose Codegen settings form](../../../../../../../screenshots/graphql_compose_codegen/1.4.x/settings-form.png)

Three fields, all saved to the config object `graphql_compose_codegen.settings`:

| Field | Config key | Notes |
|---|---|---|
| Base TypeScript type name | `base_ts_type` | Default `NodeCommonFields`. Required, maxlength 64. Validated against `/^[A-Za-z_$][A-Za-z0-9_$]*$/` (a valid TS identifier). Used in generated node `extends` clauses (`export type DrupalArticle = NodeCommonFields & {…}`). |
| Base type fields | `base_type_fields` | Textarea, one field name per line. Fields that already live in the shared base type; excluded from **node** per-bundle output. Unknown names are saved but produce a non-blocking warning. |
| Default output directory | `output_dir` | Relative to Drupal root or absolute. Empty ⇒ `gqcc:generate` prints to stdout unless `--output-dir` is given. Overridable per run with `--output-dir`. |

`getEditableConfigNames()` returns `['graphql_compose_codegen.settings']`. `validateForm()` also soft-checks
`base_type_fields` against real node field definitions and warns (does not fail) on unknown names.

## Config object & schema
Default install config (`config/install/graphql_compose_codegen.settings.yml`):
```yaml
base_type_fields:
  - title
  - path
  - body
base_ts_type: NodeCommonFields
output_dir: ''
```
Schema `config/schema/graphql_compose_codegen.schema.yml` types it as a `config_object` with a `sequence`
of strings (`base_type_fields`) plus two strings (`base_ts_type`, `output_dir`). Set headlessly with
`drush config:set graphql_compose_codegen.settings base_ts_type MyBase`.

## Status report checks (hook_runtime_requirements)
`GraphqlComposeCodegenHooks::runtimeRequirements()` (bridged for D10 via
`graphql_compose_codegen_requirements()` in `.install`) adds runtime warnings at
`/admin/reports/status`: one when **no node bundles** exist, one listing **stale `base_type_fields`** entries
that match no field on any node bundle. On uninstall, `graphql_compose_codegen_uninstall()` deletes the state
key `graphql_compose_codegen.last_snapshot` (config is removed by core; state is not).
