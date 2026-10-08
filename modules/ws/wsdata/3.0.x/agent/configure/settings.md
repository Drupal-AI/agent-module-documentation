# Global settings

Route `wsdata.settings` → `/admin/config/services/wsdata`, form
`\Drupal\wsdata\Form\WSDataAdminForm` (form id `wsdata_admin_settings_form`), permission
`administer site configuration`. Menu link `wsdata.admin_settings_form` under
*Configuration → Web services*.

Only two toggles, and both are stored in **State** (not config) — despite the form declaring
`wsdata_admin.settings` as its editable config name, `submitForm()` writes to `\Drupal::state()`:

| Field | State key | Default | Effect |
|---|---|---|---|
| Debug Mode | `wsdata_debug_mode` | unset (off) | Each `WSDataService::call()` prints the call status array (`print_r`, `Xss::filter`ed) as a status message; connectors also stash request `options` + response body into the status. |
| Performance log | `wsdata_performance_log` | `0` | On service destruction, logs a `wsdata` debug message with call count, total runtime and a per-call breakdown. |

Set from PHP / drush:

```php
\Drupal::state()->set('wsdata_debug_mode', TRUE);
\Drupal::state()->set('wsdata_performance_log', 1);
```

```bash
drush state:set wsdata_debug_mode 1
drush state:set wsdata_performance_log 1
```

These are diagnostics only — the actual integration lives in the `wsserver` / `wscall` config
entities (see [servers-and-calls.md](servers-and-calls.md)). There is no global endpoint,
timeout or credential setting here.

## Per-server state

Each `wsserver` also keeps runtime state under `wsdata.wsserver.<id>`:

- `endpoint` — if set, **overrides** the configured endpoint (the server form shows a warning
  when this is active). Useful for pointing an exported config at a per-environment URL:
  `drush state:set 'wsdata.wsserver.<id>' '{"endpoint":"https://staging.example.com"}' --input-format=json`.
- `disabled` / `degraded` / `degraded_backoff` — a server can be programmatically disabled
  (default degraded backoff 900s) via `WSServer::disable()` / `enable()` / `isDisabled()`.
