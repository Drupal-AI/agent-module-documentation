<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bureau Works — install, provider configuration & operating flow

Source: `bureauworks_tmgmt.info.yml`, `src/BureauTranslatorUi.php`, `config/schema/bureauworks_tmgmt.schema.yml`,
`README.md`.

## Install / enable

- `ddev drush en bureauworks_tmgmt -y` (project dir is `bureau_works_tmgmt_connector`, module machine name is
  `bureauworks_tmgmt`). Pulls in **`tmgmt`** and **`tmgmt_file`** (dependencies in the info.yml).
- Requires a **Bureau Works** subscription and API credentials (Access Key + Secret Key, plus the API
  endpoint URL). No PHP libraries beyond core + TMGMT; no composer.json.

## Where configuration lives

There is **no custom settings route**. Configuration is a standard TMGMT translator (`tmgmt_translator`
config entity) edited under **Translation → Providers** (`/admin/tmgmt/translators`), gated by TMGMT's
`administer tmgmt` permission. The provider must select plugin **`bwx`** ("Bureau Works").

## Provider settings (`BureauTranslatorUi::buildConfigurationForm`)

Connection / identity:
- **`end_point_api`** (textfield) — base API URL; the code appends `/api/v3` (`BureauTranslator::doRequest`).
- **`accesskey`** (textfield) — Bureau Works Access Key.
- **`secretAccesskey`** (textfield) — Bureau Works Secret Key. Both are sent as JSON to POST `/api/v3/auth`.
- **`orgUnitUUID`** (textfield) — Organization Unit UUID used when creating a project (`project/ci`).
- **`contactUUID`** (textfield) — Contact UUID used on project creation.

Workflow behavior:
- **`workflows`** (textfield, CSV) — workflow stages assigned to each uploaded resource, e.g.
  `TRANSLATION,REVIEW,REVIEW_2` (spaces stripped, split on `,`).
- **`autoSaveTranslationsForWorkflows`** (textfield, CSV) — when the last delivered workflow is in this list,
  imported content is **saved** into the target translation (not accepted).
- **`autoAcceptableWorkflows`** (textfield, CSV) — when the last delivered workflow is in this list, the job
  item is **auto-accepted** (`acceptTranslation()`). Checked before the auto-save list.

Preview:
- **`shouldSendPreviewUrl`** (checkbox) — if set, a per-item source preview URL is sent to Bureau Works.
- **`previewBaseUrl`** (url, shown only when the checkbox is on) — public base URL of the site used to build
  the preview URL; if empty the current request host is used. `BureauTranslator::buildPreviewUrl()` only
  sends the URL when `isValidExternalUrl()` confirms it is http/https and resolves to a **globally routable**
  IP (private/reserved ranges are rejected and the URL is dropped with a warning).

Sandbox (read only where present):
- **`use_sandbox`** — when truthy, the job checkout screen shows "Simulate complete" / "Simulate preview"
  action buttons (`BureauTranslatorUi::checkoutInfo`).

Not translator settings but read on the **job** at checkout (`checkoutSettingsForm`): **`name`**,
**`comment`**, **`duedate`** (due date hidden for continuous jobs).

## Config schema note

`config/schema/bureauworks_tmgmt.schema.yml` defines `tmgmt.translator.settings.bureau` (type
`tmgmt.translator_base`) with only `end_point_api`, `accesskey`, `secretAccesskey`. The plugin id is `bwx`,
so the schema key does not match the plugin, and the many other settings the code reads (`orgUnitUUID`,
`contactUUID`, `workflows`, `autoSaveTranslationsForWorkflows`, `autoAcceptableWorkflows`,
`shouldSendPreviewUrl`, `previewBaseUrl`, `use_sandbox`) are **not** in the schema. Functionally the settings
still work (TMGMT stores them as free-form settings), but config-schema validation is incomplete. `data.json`
reports `provides_config_schema: true` because a schema file exists.

## Typical operating flow

1. Configure the provider (endpoint + credentials + org/contact UUID + workflows).
2. Under **Remote languages mappings**, map Drupal langcodes to Bureau Works locale codes.
3. Translation → **Sources**: select items → *Request translation* → pick the Bureau Works provider, set
   name/comment/due date → *Submit to provider*. This creates a Bureau Works project and uploads XLIFF.
4. Translation → **Jobs**: the job shows a Bureau Works project ID. Delivered translations arrive
   automatically on cron, or click **Fetch translations** to pull now.
5. Optionally add the `bw_project_name` / `bw_last_workflow_delivered` Views fields to a job-item view.

## Uninstall

`hook_uninstall` (`bureauworks_tmgmt_uninstall`) removes the `bw_project_name` and
`bw_last_workflow_delivered` fields from the `tmgmt_translation_all_job_items` view so the view does not break
after the module is gone.
