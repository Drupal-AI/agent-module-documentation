<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Auto Exports (coc_forms_auto_export) — agent index

Project name "Webform Auto Exports" (machine name `coc_forms_auto_export`, package `Webform`,
sometimes called "CoC/Casey Forms"). Adds **automatic, scheduled CSV export of Webform submission
results**, delivered by **email** and/or **SFTP**. Configured **per Webform**, not site-wide.
Installed **3.0.0-alpha1** (version dir `3.0.x`). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Built by the City of Casey (Victoria, AU).

## Dependencies

- Drupal modules (`.info.yml`): **`webform:webform`** and **`webform:webform_ui`** (both required).
- PHP library: **`phpseclib/phpseclib` `~3`** — required in `composer.json`, but only actually needed
  for **SFTP** delivery. `hook_requirements` (`.install`) emits a *warning* (not an error) if
  `phpseclib3\Net\SFTP` is missing, so email-only setups work without it.

## Architecture (from source — there are NO routes, controllers, permissions, or config schema)

The module has **no `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, and no `config/`
schema directory** — confirmed against the full file set. It works entirely through hooks:

- **`hook_form_alter`** (`.module`) injects an **"Automatic CSV Export"** fieldset into Webform's
  own `webform_results_export` form (Structure → Webforms → *form* → Results → Downloads). All the
  per-form options live here; a custom submit handler persists them.
- Per-form settings are saved into a **mutable config object** `coc_forms_auto_export.config.<webform_id>`
  (created dynamically, no schema) **and** a row in a custom DB table.
- **`hook_schema`** (`.install`) defines table **`webform_auto_exports`** (one row per form:
  `name`, `path`, `schedule_config` blob, `search_config` blob, `next_run`, `last_run`,
  `enable_auto_export`, `enable_sftp`, `enable_email`, `email`).
- **`hook_cron`** (`.module`) is the engine: finds due rows (`enable_auto_export=1` AND
  `next_run <= now`), runs Webform's exporter with this module's exporter plugin, then SFTPs and/or
  emails the file, and reschedules `next_run`.
- **`hook_mail`** builds the HTML email carrying the CSV attachment; **`hook_uninstall`** deletes
  all `coc_forms_auto_export.config.*` objects.

### Plugins / elements it provides (instances, not new plugin types)

- **WebformExporter plugin** `coc_delimited` (`COCDelimitedWebformExporter`, extends core Webform's
  `DelimitedWebformExporter`) — exports only the selected columns, in the configured order.
- **FormElement** `auto_export_excluded_columns` (`AutoExportExcludedColumns`, extends
  `WebformExcludedBase`) — the sortable column-picker in the settings pane.
- **Helper class** `SFTPController` (a plain class in `Controller/`, **not** a routed controller) —
  static `sendFile()` using phpseclib SFTP; called only from `hook_cron`.

## Solution docs

- **Per-form settings pane** (every field in the `hook_form_alter` "Automatic CSV Export" fieldset,
  how they persist, config keys, the `webform_auto_exports` table) →
  [config/export-settings.md](config/export-settings.md)
- **The export pipeline** (`hook_cron` scheduling, date-range math, the `coc_delimited` exporter,
  SFTP + email delivery, `hook_mail`) → [export/pipeline.md](export/pipeline.md)

## Notes for agents

- **No admin route to link to.** To configure, open a specific Webform's Results → Downloads page;
  there is no `/admin/config/...` settings form and `configure` is null.
- **Scheduling depends on Drupal cron** actually running frequently enough for the chosen frequency
  (hourly/daily/weekly/monthly).
- **Exports contain PII.** Submission CSVs (names, emails, messages, uploads) are emailed and/or
  pushed off-site by SFTP; ensure both destinations are secured. The SFTP password is stored in the
  per-form config object.
- There is no `config/install` default — a form has no automatic export until an admin enables it.
