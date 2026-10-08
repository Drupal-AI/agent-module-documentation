<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Raven

Everything is stored in the single config object **`raven.settings`**. There is no
dedicated route: `raven.info.yml` sets `configure: system.logging_settings`, and
`Drupal\raven\Form\RavenConfigForm::buildForm()` (called from a
`hook_form_system_logging_settings_alter`) injects Raven's fields into the core
**Logging and errors** form at `/admin/config/development/logging` (fragment
`#edit-raven`). Fields are grouped into **JavaScript**, **PHP** (with **Errors**,
**Structured logs** and **Performance tracing** sub-sections) plus top-level
Environment/Release settings.

![Raven Sentry settings on the Logging and errors form](../../../../../../../screenshots/raven/7.6.x/settings-form.png)

![Raven PHP and performance-tracing settings](../../../../../../../screenshots/raven/7.6.x/settings-form-part2.png)

Read/write with drush (config over UI):

```bash
drush cget raven.settings
drush cset raven.settings client_key 'https://examplePublicKey@o0.ingest.sentry.io/0' -y
```

## Environment-variable overrides

`Drupal\raven\Config\Overrides` overrides these keys from `$_SERVER` when present
(these win over stored config, so DSNs stay out of exported config):

| Env variable | Overrides keys |
|---|---|
| `SENTRY_DSN` | `client_key` (PHP) and `public_dsn` (JavaScript) |
| `SENTRY_ENVIRONMENT` | `environment` |
| `SENTRY_RELEASE` | `release` |

## Key settings (`raven.settings`)

Defaults are from `config/install/raven.settings.yml`; schema is
`config/schema/raven.schema.yml`. Nothing is sent to Sentry until a DSN is set
**and** the relevant handler/level is enabled.

| Key | Type | Default | Purpose |
|---|---|---|---|
| `client_key` | uri\|null | `null` | Sentry DSN for PHP events |
| `public_dsn` | uri\|null | `null` | Sentry DSN for the browser JavaScript SDK |
| `environment` | string\|null | `null` | Environment tag (e.g. `production`) |
| `release` | string\|null | `null` | Release/version tag |
| `log_levels` | map of 8 bools | all `false` | Which PSR levels (`emergency`…`debug`) are sent as **error events** |
| `logs_log_levels` | map of 8 bools | all `false` | Which PSR levels are sent as **structured logs** |
| `stack` | bool | `true` | Attach stack traces to messages |
| `trace` | bool | `false` | Reflection-based argument tracing (can leak args to Sentry) |
| `message_limit` | int | `2048` | Max message length (chars) |
| `rate_limit` | int | `0` | Max events per request (`0` = unlimited) |
| `timeout` | float | `2` | Sentry HTTP client timeout (seconds) |
| `ignored_channels` | string[] | `[]` | Logger channels never sent to Sentry |
| `ignored_messages` | string[] | `[]` | Log-message patterns to drop |
| `fatal_error_handler` | bool | `false` | Capture fatal PHP errors |
| `fatal_error_handler_memory` | int | `2560` | Reserved memory (KB) for the fatal handler |
| `javascript_error_handler` | bool | `false` | Load Sentry JS SDK to capture browser errors |
| `drush_error_handler` | bool | `false` | Capture exceptions thrown by Drush commands |
| `request_tracing` | bool | `false` | Create a transaction per request/response |
| `traces_sample_rate` | float\|null | `null` | Backend performance-trace sample rate (0–1) |
| `browser_traces_sample_rate` | float\|null | `null` | Browser performance-trace sample rate (0–1) |
| `database_tracing` | bool | `false` | Add a span per database query |
| `database_tracing_args` | bool | `false` | Include query arguments in DB spans |
| `twig_tracing` | bool | `false` | Add a span per Twig template |
| `drush_tracing` | bool | `false` | Trace Drush command execution |
| `console_tracing` | bool | `false` | Trace non-Drush Symfony Console (`dr`) command execution |
| `404_tracing` | bool | `false` | Trace 404 responses |
| `profiles_sample_rate` | float\|null | `null` | CPU profiling rate (needs Excimer extension) |
| `trace_propagation_targets_backend` | string[] | `[]` | Hosts that receive `sentry-trace`/`baggage` from PHP |
| `trace_propagation_targets_frontend` | string[] | `[]` | Regexes for browser trace propagation |
| `auto_session_tracking` | bool | `false` | Browser session tracking (release health) |
| `send_client_reports` | bool | `false` | Send browser client reports |
| `send_inp_spans` | bool | `false` | Send Interaction-to-Next-Paint spans |
| `show_report_dialog` | bool | `false` | Show Sentry user-feedback dialog on errors |
| `error_embed_url` | uri\|null | `null` | Error embed URL (for feedback-dialog CSP rules) |
| `send_user_data` | bool | `false` | Attach authenticated user email/username to events |
| `capture_user_ip` | bool | `false` | Attach end-user IP address |
| `send_request_body` | bool | `false` | Attach the HTTP request body (POST data) |
| `modules` | bool | `false` | Attach installed Composer packages to events |
| `http_compression` | bool | `true` | Gzip Sentry payloads (needs Zlib) |
| `tunnel` | bool | `false` | Relay browser events through `/raven/tunnel` |
| `cron_monitor_id` | string\|null | `null` | Sentry cron-monitor slug for check-ins |
| `seckit_set_report_uri` | bool | `false` | Send Security Kit CSP reports to Sentry |
| `send_monitoring_sensor_status_changes` | bool | `false` | Send Monitoring sensor changes to Sentry |
| `aggregate_bundle` | bool | `false` | Allow the bundled Sentry browser SDK JS to be aggregated/preprocessed with other libraries |
| `ssl` | string | `verify_ssl` | Legacy SSL-mode key (present in schema/defaults; not read by current `src/`) |
| `ca_cert` | string | `''` | Legacy CA-cert path key (present in schema/defaults; not read by current `src/`) |

The three sample-rate / URL fields and both DSN fields use a `ConfigTarget` with
`valueToNullOrValue()`, so submitting an empty field stores `null` (disabling that
feature). `log_levels` / `logs_log_levels` map to/from checkboxes via
`booleansToCheckboxes()` / `checkboxesToBooleans()`.

Example — capture error-and-above as events, enable structured logs, sample 25% of
backend traces plus DB spans:

```bash
drush cset raven.settings log_levels.error true -y
drush cset raven.settings log_levels.critical true -y
drush cset raven.settings logs_log_levels.error true -y
drush cset raven.settings request_tracing true -y
drush cset raven.settings traces_sample_rate 0.25 -y
drush cset raven.settings database_tracing true -y
drush cr
```

(Structured logs are delivered whenever `logs_log_levels` selects a level; there is
no separate master switch in this release.)

## CSP reporting

Raven provides a `CspReportingHandler` plugin with id **`raven`** (label "Sentry")
in `src/Plugin/CspReportingHandler/Raven.php` for the
[CSP module](https://www.drupal.org/project/csp): set CSP's reporting handler to
"Sentry" to route violation reports to your Sentry project. Alternatively, with
Security Kit installed, enable `seckit_set_report_uri` to send CSP/CT reports
directly from the browser to Sentry (`Drupal\raven\Config\SecKitOverrides`).
