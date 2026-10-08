<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object & prompt

## Install / enable

Requires the **AI module** (`drupal/ai`) with a configured chat provider, plus core `node`,
`field`, `user`, `views`. `drush en ai_jsonld_schema_generator`. `hook_install()` installs the
`ai_schema_route` entity type (base table); the optional Views view
`views.view.ai_schema_mappings` is installed from `config/optional/`. Many `hook_update_N`
functions exist but only tune the prompt template and entity columns (see
`ai_jsonld_schema_generator.install`).

## Settings form

Route `ai_jsonld_schema_generator.settings` → `/admin/config/ai-schema`, permission
**`administer ai schema settings`** (`restrict access: true`). Form `Form\AiSchemaSettingsForm`,
config object `ai_jsonld_schema_generator.settings`.

| Key | Widget | Meaning |
|---|---|---|
| `sitewide_schema_organization` | textarea | Organization JSON-LD attached on every page (tokens allowed). Empty to omit. |
| `sitewide_schema_website` | textarea | WebSite JSON-LD attached on every page (tokens allowed). |
| `enabled_content_types` | checkboxes | Content types that show the generate button and can store schema (≥1 required). |
| `node_content_source` | radios | `tokens` (render `content_template`) or `full_page` (fetch rendered page). |
| `content_template` | textarea | Token template used when source = `tokens` (e.g. `[node:title]`, `[node:body]`, `[node:url]`). |
| `prompt_template` | textarea | Prompt with the required `{{ content }}` placeholder. |
| `provider_model` | select | AI simple-option provider/model; empty = site default chat provider. |
| `auto_generate_on_publish` | checkbox | Generate + save schema when a node is first published. |
| `auto_regenerate_on_update` | checkbox | Regenerate on node update. |
| `rate_limit_max_per_hour` | number | Flood limit of generations per user per window (0 = off). |
| `rate_limit_window` | number | Flood window in seconds (min 60). |
| `page_schema_paths` | (managed by the URL form) | Allowed paths for URL schema generation. |

`validateForm()` requires at least one enabled content type and requires `{{ content }}` in the
prompt template. The install prompt (`config/install/...settings.yml`) is a long "structured data
expert" instruction telling the model to output a `schema_type` + `json_ld` object (or a
`schemas` array), infer all applicable schema.org types into an `@graph`, and honor mandatory
`Breadcrumb:`/`FAQ:` signals.

## Site-wide schema attachment

`SchemaAttacherService::getSitewideSchemas()` reads the two site-wide config values, runs
`token->replace()` (`[site:name]`, `[site:url]`), normalizes double slashes, JSON-decodes, and
keeps only blocks with `@context` + `@type`. These are attached (weights -100/-99) ahead of the
path-specific block on every page. They are admin-authored via this form only.

## Config schema

`config/schema/ai_jsonld_schema_generator.schema.yml` types every key (strings, booleans,
integers, and `enabled_content_types` / `page_schema_paths` sequences). `provides_config_schema`
is therefore true.
