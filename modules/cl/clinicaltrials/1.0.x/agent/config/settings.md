<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, content type & access

## Install / enable

`drush en clinicaltrials -y` (pulls in core `language`; the installed config pulls in `node` +
`menu_ui`). Enabling creates the **`clinicaltrials`** content type. Then configure at
**`/admin/config/clinical-trials`** and import from the CLI (see
[services/import-and-delete.md](../services/import-and-delete.md)).

## Settings form

`Form/ClinicalTrialsSettingsForm` extends `ConfigFormBase`; form id `clinical_trials_configuration`;
edits config object **`clinicaltrials.settings`**. Route `clinicaltrials.admin` at
`/admin/config/clinical-trials`, gated by permission `administer clinical trials config`. Fields map
1:1 to config keys (defaults from `config/install/clinicaltrials.settings.yml`):

| Form field | Config key | Default | Feeds ClinicalTrials.gov API as |
|-----------|-----------|---------|------------------------------|
| Studies API URL (base) | `base_url` | `https://clinicaltrials.gov/api/v2` | base of request URL (**required**) |
| Studies API URL (endpoint) | `studies_api_url` | `/studies` | appended to base (**required**) |
| query.lead | `lead` | `''` | `query.lead` (LeadSponsorName, Essie syntax) |
| filter.overallStatus | `overallstatus` | `''` | `filter.overallStatus` |
| fields | `fields` | `''` | `fields` (comma/pipe list; omitted if empty) |
| pageSize | `page_size` | `'2'` | `pageSize` (batch size; coerced ≤1000 by API) |
| MarkupFormat | `markup_format` | `legacy` | `markupFormat` (`legacy` / `markdown`) |

`countTotal=true` is always added by the service. Notes:
- The service reads config with `getEditable('clinicaltrials.settings')` and falls back to
  `https://clinicaltrials.gov/api/v2/` + `/studies` if unset. `base_url` and `studies_api_url` are
  concatenated with no separator handling beyond the leading `/` on the endpoint.
- **No config schema ships** (there is no `config/schema/` directory), so these keys are untyped.
- The Drush import (`ImportCommands::importCtStudies`) refuses to run unless **all seven** keys —
  including `lead`, `overallstatus`, `fields` — are non-empty; with the shipped defaults (`lead`,
  `overallstatus`, `fields` empty) the import aborts with a "Following config is empty" message until
  those are filled in.

## Content type & fields

Created from `config/install/`:
- **`node.type.clinicaltrials`** — label "ClinicalTrials", `new_revision: true`, main-menu link
  settings via `menu_ui` third-party settings.
- **Title** relabelled **"Nct Id"**, required (`base_field_override…title`); import stores the
  study's `nctId` (e.g. `NCT01234567`) as the title, truncated to 250 chars + `...` if >255.
- **`field_data`** (`string_long`, label "Data", cardinality 1) — stores `serialize($protocolSection)`
  for the study; rendered with the `basic_string` formatter on the default and teaser view displays
  (`core.entity_view_display.node.clinicaltrials.*`). The value is a serialized PHP array string, not
  HTML.
- `language.content_settings.node.clinicaltrials` enables content translation for the bundle
  (matching the `language` dependency).

## Access & lifecycle

- **Permission** `administer clinical trials config` (`.permissions.yml`) — `restrict access: true`,
  gates the only route. No other permissions; no front-end routes.
- **Menu**: `clinicaltrials.admin_config` (under `system.admin_config`) and
  `clinicaltrials.admin_settings_form` both point at `clinicaltrials.admin`.
- **Uninstall validator** `ClinicalUninstallValidator` (service tagged
  `module_install.uninstall_validator`, `lazy: true`, with generated
  `ProxyClass/ClinicalUninstallValidator`): blocks uninstall while any `clinicaltrials` node exists
  (`accessCheck(FALSE)` query, range 0–1), returning a "delete all contents" reason.
- **`hook_uninstall`** deletes state keys `clinical_trials_current_nct_id` and
  `clinical_trials_previous_nct_id`.
