# Configure elogger

All settings live in the single config object **`elogger.settings`**. Three admin forms edit
different slices of it; a fourth integration adds fields to core's *Logging and errors* page.

## Config object `elogger.settings`

| Key | Type | Default (install) | Meaning |
|-----|------|-------------------|---------|
| `modules` | map (machine_name → machine_name) | ~20 core modules + `actions_forms: '*'` | Which entity-owning modules' CRUD events are logged. Derived from the namespace of the saved entity's class (`Drupal\<module>\...`). |
| `actions_forms` | string | `*` | Which form submissions to log. `*` = every form; otherwise a newline list of form ids. |
| `log_message_templates` | map | `entity_create`/`entity_update`/`entity_delete`/`actions` templates | Per-event-type message body. Supports Drupal tokens and the built-in placeholders `{entity_type}`, `{entity}`, `{user}`, `{form_id}`. |
| `elogger_text_format` | string | `full_html` | Text format applied to the stored `log_message` field. |
| `elogger_row_limit` | string/int | `10000` | Max rows kept in the `elog` table; cron deletes the oldest beyond this. `0` = keep all. |
| `format` | string | ELT token string | Syslog/watchdog line format (uses `elogger:*` tokens). Only used when forwarding to syslog/watchdog. |
| `output_type` | string | (unset → watchdog) | `watchdog` (dblog) or `syslog` — destination of the forwarded copy. |

**Config schema** (`config/schema/elogger.schema.yml`) declares only `format` and `output_type`.
The other keys are written by the forms/`config/install` but are **not** in the schema (partial
schema — `provides_config_schema` is true but incomplete).

## Admin forms

| Route | Path | Form class | Edits |
|-------|------|-----------|-------|
| `elogger.system` *(the `configure` link)* | `/admin/config/system/elogger` | `ElogFiltersConfigForm` | `modules` (multi-select of enabled modules, `elogger` excluded) and `actions_forms` (textarea). Both required. |
| `elogger.system.log_messages` | `/admin/config/system/elogger/log-messages` | `ElogLogMessagesConfigForm` | The four `log_message_templates` (one textarea each, required) and `elogger_text_format`. |
| `elogger.system.settings` | `/admin/config/system/elogger/settings` | `ElogLogMessagesSettingsForm` | `elogger_row_limit` (select: All/100/1k/10k/100k/1M). |
| `elogger.elog_settings` | `/admin/structure/elog` | `ElogSettingsForm` | Placeholder page only; it is the `field_ui_base_route` for adding fields to the `elog` entity. |

All three config forms require the **`administer elogger configurations`** permission;
`elogger.elog_settings` requires **`administer event log entity`**.

## Syslog / watchdog forwarding

When the core **`syslog`** module is enabled, `elogger_form_system_logging_settings_alter()` adds
`format`, a token tree, an `output_type` select (`watchdog` default / `syslog`), and a live example
to `/admin/config/development/logging`. On save it stores `format` + `output_type` into
`elogger.settings`. The forwarding itself is done by the `logger.eventlog` service — see
[../api/logger.md](../api/logger.md). Note: `Elogger::logEvent()` forwards a copy to the `eventlog`
logger channel **only when the `syslog` module exists**; the entity row is always written regardless.

## Set values via drush / PHP

```php
\Drupal::configFactory()->getEditable('elogger.settings')
  // Track only node + user entity events:
  ->set('modules', ['node' => 'node', 'user' => 'user'])
  // Track only these two forms (newline-separated), or '*' for all:
  ->set('actions_forms', "contact_message_feedback_form\nwebform_submission_x_add_form")
  ->set('elogger_row_limit', 1000)
  ->set('elogger_text_format', 'basic_html')
  ->set('output_type', 'syslog')
  ->save();
```

```bash
ddev drush config:set elogger.settings elogger_row_limit 1000 -y
ddev drush config:set elogger.settings actions_forms '*' -y
```

`elogger_row_limit` is enforced by `hook_cron` — see [../hooks/automatic-logging.md](../hooks/automatic-logging.md).
