# Configure security_review

## Where
- **Run & review:** Reports → Security Review — `/admin/reports/security-review` (route `security_review`). Run the checklist here; enable/skip a check and open its Help only *after* it has been run.
- **Settings:** `/admin/config/security-review` (route `security_review.settings`, `configure` in info.yml, form `SettingsForm`). Choose untrusted roles, toggle logging, skip checks, and set check-specific options.
- **Toggle a check:** `/admin/reports/security-review/toggle/{check_id}` (route `security_review.toggle`) — skip/enable one check.
- **Help:** `/admin/reports/security-review/help/{namespace}/{title}` (route `security_review.help`).

All routes require the `access security review list` permission.

## Config object: `security_review.settings`
Editable config (also settable via `drush cset security_review.settings <key> <value>`). Defaults from `config/install`:

```yaml
untrusted_roles:        # role IDs treated as untrusted; most checks only flag resources reachable by these
  - anonymous
  - authenticated
log: false              # log every check run to watchdog
skipped: []             # map of skipped (hushed) checks: {check_id: {skipped: true, skipped_by: uid, skipped_on: ts}}
views_access:
  ignore_default: false
  hushed_views: {}      # view IDs to ignore
upload_extensions:
  hush_upload_extensions: {}   # extensions to ignore
fields:
  known_risky_fields: {}       # field hashes to ignore
file_permissions:
  hushed_files: {}             # directories to ignore
headers:
  headers_to_check: {}         # header names to check
```

Config has a schema (`FullyValidatable`); per-check settings validate as they are saved. A custom check's own settings schema is `security_review.check_settings.<check_id>`.

## Notes
- On install the module auto-skips the `account_creation` check and reminds you to set permissions.
- Results (per-check `result`, `findings`, `hushed_findings`, `time`, `visible`) are stored in **state** under `security_review.check.<id>.…`, not config. The last-run timestamp is state `security_review.last_run`.
- Marking a role untrusted, skipping, and hushing are all persisted in `security_review.settings`; the `security_review` service exposes setters (`setUntrustedRoles()`, `skip()`, `enable()`, `setSkipped()`, `setCheckSettings()`).
