<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — error_reporting

## Enable / install

- `drush en error_reporting -y`. No dependencies.
- `hook_install()` (`error_reporting.install`) sets `error_reporting.settings:enable_error_reporting`
  to TRUE when the config exists but is falsy. `hook_uninstall()` sets it back to FALSE.
- Install default: `config/install/error_reporting.settings.yml` ships `enable_error_reporting: true`.

## Settings form

- Route `error_reporting.config_form` → `/admin/config/system/error-reporting`.
- Permission: `administer site configuration` (`error_reporting.routing.yml`).
- Form class `ErrorReportingConfigForm` (`src/Form/ErrorReportingConfigForm.php`), extends
  `ConfigFormBase`, form id `error_reporting_config_form`, editable config
  `error_reporting.settings`.
- One field: `enable_error_reporting` (checkbox) → saved by `submitForm()`.
- Practical note (README): disable it on production/live and clear cache so the enhanced debugger
  is not active for real visitors.

## Config object & schema

- Object `error_reporting.settings`, type `config_object`
  (`config/schema/error_reporting.schema.yml`).
- Keys:
  - `enable_error_reporting` (boolean) — master on/off for both capture paths.
  - `provider` (string) — **added by the `error_ai_recommendations` submodule** via its
    `hook_form_alter`/submit; selects the AI provider used for fix suggestions. Not present in the
    base schema.

Example export:

```yaml
# error_reporting.settings
enable_error_reporting: true
```

## What the flag controls

- In `error_reporting_exception_handler()` (module file): if the flag is falsy, uncaught
  exceptions get a plain generic 500 response; if truthy, `ErrorController::handler()` renders the
  full styled page.
- In `ExceptionSubscriber::onKernelException()`: if the flag is falsy, 404s pass through untouched
  and everything else gets a generic 500; if truthy the styled page is rendered. Display of the
  detailed in-request report is also subject to the `error_reporting.view_error_reports` permission.
