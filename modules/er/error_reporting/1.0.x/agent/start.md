<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error Reporting (error_reporting) — agent index

Replaces Drupal's default exception output with a styled error page showing exception
type/message, a ±17-line source excerpt per stack frame, and Server/Request/Cookie/Session/App
panels. Package `Tools and Utilities`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.3.
No external dependencies (submodule adds one — see below).

- **Config form, config object + schema, install behaviour** → [config/settings.md](config/settings.md)
- **Capture paths (exception handler + kernel subscriber), rendering, formatter** → [api/capture.md](api/capture.md)
- **Submodule `error_ai_recommendations`** → documented in its own tree at
  `modules/error_ai_recommendations/1.0.x/`.

## What it actually is

- Two capture paths, both feeding the same `custom_error_display` theme hook:
  1. `error_reporting_exception_handler()` in `error_reporting.module`, registered globally with
     `set_exception_handler(...)` at module load. Handles otherwise-uncaught / bootstrap-time
     throwables and, when `enable_error_reporting` is set, renders via `ErrorController::handler()`
     (`src/Controller/ErrorController.php`).
  2. `ExceptionSubscriber` (`src/EventSubscriber/ExceptionSubscriber.php`), service
     `error_reporting.exception_subscriber`, subscribes to `KernelEvents::EXCEPTION` at priority
     **100** for normal in-request exceptions; when the config flag is off it passes 404s through
     and returns a generic 500 for everything else.
- `ExceptionFormatter::formatException()` (`src/Utility/ExceptionFormatter.php`) builds the error
  data: message, mapped exception type, per-frame source snippets via `getFormattedLines()`, and
  `$_SERVER` / request / cookie / session dumps for the current request.
- Template `templates/custom-error-display.html.twig` renders it (highlight.js, MDB, jQuery, font
  awesome from CDNs). Assets `libraries/css/error_reporting.css`, `libraries/js/error_reporting.js`
  are referenced by path (no `*.libraries.yml`).
- Provides: 1 route (settings form), 1 permission, 1 config object, 1 theme hook, 1 event
  subscriber service. No entities, no plugins, no Drush, no fields.

## Config / routes / permissions

- Route `error_reporting.config_form` → `/admin/config/system/error-reporting`, form
  `ErrorReportingConfigForm`, permission `administer site configuration`.
- Config object `error_reporting.settings` — key `enable_error_reporting` (boolean, default TRUE;
  schema in `config/schema/error_reporting.schema.yml`). The AI submodule adds a `provider` key.
- Permission `error_reporting.view_error_reports` ("View error reports", `restrict access: TRUE`) —
  gates display of the detailed in-request error report.
- `hook_install` sets `enable_error_reporting` TRUE; `hook_uninstall` sets it FALSE.
