<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings, cron, remote post

There is one settings form, `audit_export_core.settings` at **`/admin/config/system/audit-export`**
(`Form\AuditExportConfigForm`, form id `audit_export_core_settings_form`, permission
`administer audit export settings`). The `audit_export_post` submodule bolts its own "Remote Post"
section onto this same form via `hook_form_FORM_ID_alter()`. Three config objects back it.

## `audit_export_core.settings` (config object + schema)

Fieldset **CSV Download**:

| Config key | Form field | Type | Default | Meaning |
|---|---|---|---|---|
| `audit_export_save_filesystem` | Save export to filesystem | bool | `false` | When on, the "Download CSV" button appears on a report view. |
| `audit_export_filesystem` | Filesystem | string | `temporary` | Stream wrapper for saved exports. Options: `temporary`, `public`, and `private` (offered only when a private scheme is configured). |
| `audit_export_filesystem_path` | Export path | string | `audit-export` | Sub-path within the chosen scheme, e.g. `{scheme}://audit-export`. (Form field name is `audit_export_path`, saved to this key.) |

Fieldset **Cron Configuration** (consumed by `audit_export_core_cron()` in the `.module`):

| Config key | Type | Default | Meaning |
|---|---|---|---|
| `audit_export_enable_cron` | bool | `false` | Master switch for cron report processing. |
| `audit_export_run_on_every_cron` | bool | `false` | Run on every cron tick vs. respect the frequency below. |
| `audit_export_cron_frequency_default` | int (minutes) | `1440` | Minimum minutes between refreshes (state key `audit_export.last_cron_run`). |
| `audit_export_cron_queue_timeout` | int (seconds) | `120` | Timeout applied to the `audit_export_processor` queue worker (via `hook_queue_info_alter`). |

Cron flow: `audit_export_core_cron()` checks the switches, acquires the `audit_export_processing`
lock, and if the queue is empty calls `audit_export_core.cron`
(`AuditExportCron::queueAudits($timeout)`), which chunks each audit's `prepareData()` output into
batches and enqueues them for `AuditExportProcessor`.

## `audit_export_post.settings` (submodule `audit_export_post`)

Added to the settings form as the **Remote Post** details section; submitted by
`audit_export_post_settings_form_submit()`. Config keys (schema `audit_export_post.schema.yml`,
defaults from `config/install/audit_export_post.settings.yml` and `hook_install`):

| Config key | Type | Default | Meaning |
|---|---|---|---|
| `enable_remote_post` | bool | `false` | Master switch; enabling resets state `audit_export_post.last_post_time` to 0. |
| `remote_url` | string | `''` | Endpoint the report JSON is POSTed to (admin-set; alterable via `hook_audit_export_post_url_alter`). |
| `site_name` | string | site name | Identifier sent in the payload's `site_info`. |
| `authentication_type` | string | `none` | `none`, `basic`, or `bearer`. |
| `username` / `password` | string | `''` | Used when `authentication_type = basic` (password only re-saved when re-entered). |
| `token` | string | `''` | Bearer token when `authentication_type = bearer`. |
| `timeout` | int (s) | `300` | Guzzle request timeout (30–900). |
| `verify_ssl` | bool | `true` | Verify the endpoint's TLS certificate. |
| `debug_mode` | bool | `false` | Verbose logging to the `audit_export_post` channel (added via `hook_config_schema_info_alter`). |

Posting is triggered by `hook_audit_export_process_complete` / `hook_audit_export_audit_finished`
(and a `hook_batch_alter`-installed finished callback), and on cron by
`audit_export_post_cron()` → subscriber `onCron()`. The payload is built by
`AuditExportRemotePost::buildPostData()` as `{site_info, report_data}`.

## `audit_export_tool.settings` (submodule `audit_export_tool`)

Schema-only (no dedicated form): `default_pagination_limit` (int), `max_sync_rows` (int),
`enable_derived_tools` (bool). See [../api/tool-api.md](../api/tool-api.md).
