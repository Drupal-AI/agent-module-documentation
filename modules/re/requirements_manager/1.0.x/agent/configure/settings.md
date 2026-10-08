# Configure Requirements Manager

## Settings form

Route `requirements_manager.settings_form` → `/admin/config/system/requirements-manager`
(`RequirementsManagerSettingsForm extends ConfigFormBase`, permission `administer site configuration`).
The form calls `SystemManager::listRequirements()` to enumerate every current requirement and renders a
table row per key with columns: Key, Title, Current Severity, **Action**, **New Severity**, **Reason**.

- **Action** (`show` | `hide` | `change_severity`): `show` = default (nothing stored). `hide` removes the
  row from the status report. `change_severity` overrides the severity.
- **New Severity** (shown only when action = `change_severity`): `info` | `ok` | `warning` | `error`.
- **Reason** (shown for `hide`/`change_severity`): free text; for `change_severity` it is appended to the
  requirement's description on the report.

Keys previously hidden by the module are still listed (labelled "(hidden by this module)") so they can be
switched back to `show`.

## Stored config

Config object `requirements_manager.settings` (schema `requirements_manager.schema.yml`). Only non-default
entries are saved:

```yaml
requirements:
  <requirement_key>:
    action: hide            # or change_severity
    severity: warning       # only when action == change_severity (info|ok|warning|error)
    reason: 'Accepted risk' # optional
```

Empty by default (`requirements: {}`). Edit programmatically for deployment:

```php
\Drupal::configFactory()->getEditable('requirements_manager.settings')
  ->set('requirements', [
    'update_core' => ['action' => 'change_severity', 'severity' => 'warning', 'reason' => 'Handled by CI'],
    'cron' => ['action' => 'hide'],
  ])->save();
```

## How overrides are applied

`RequirementsManagerHooks::runtimeRequirementsAlter()` runs on `hook_runtime_requirements_alter` with
`order: Order::Last` (so it sees the final requirements from all modules). For each stored override whose
key exists:
- `hide` → `unset($requirements[$key])`.
- `change_severity` → maps the string to a `RequirementSeverity` enum (Info/OK/Warning/Error), replaces
  `$requirements[$key]['severity']`, and appends an italic notice
  *"Severity altered from "X" to "Y" state by Requirements Manager. Reason: …"* to the description
  (handles string, `Stringable`, and render-array descriptions). Legacy integer severities are normalized
  via `RequirementSeverity::from()`.

Note: overrides only affect the **display** of the status report; they do not change the underlying
condition being reported. The `reason` text is authored by an `administer site configuration` admin.
