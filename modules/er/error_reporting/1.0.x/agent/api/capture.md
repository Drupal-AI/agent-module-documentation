<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error capture, formatting & rendering — error_reporting

Two independent capture paths render the same `custom_error_display` template.

## Path 1 — global exception handler (module file)

- `error_reporting.module` calls `set_exception_handler('error_reporting_exception_handler')` at
  file load (top-level), overriding Drupal's default handler.
- `error_reporting_exception_handler(\Throwable $exception)`: reads
  `error_reporting.settings:enable_error_reporting`. If falsy → sends a generic 500
  `Response` and returns. If truthy → builds `new ErrorController($renderer)` and calls
  `handler($exception)`.
- Fires only for throwables that escape the HttpKernel try/catch (e.g. bootstrap-time or otherwise
  uncaught fatals). Normal in-request exceptions go through Path 2.

## Path 2 — kernel EXCEPTION subscriber

- Service `error_reporting.exception_subscriber` (`error_reporting.services.yml`), args
  `@renderer, @config.factory, @current_user`.
- `ExceptionSubscriber::getSubscribedEvents()` → `KernelEvents::EXCEPTION` at priority **100** (runs
  before Symfony's default listener).
- `onKernelException($event)`:
  1. Resolves the exception via `getExceptionFromEvent()` (supports both `ExceptionEvent` and the
     legacy `GetResponseForExceptionEvent`).
  2. If the config flag is off: 404 → stop propagation and return; otherwise set a generic 500
     response.
  3. If on: format via `ExceptionFormatter`, render, and send a 500 response with the styled page.

  The detailed in-request report is shown subject to the `error_reporting.view_error_reports`
  permission (see [config/settings.md](../config/settings.md)).

## Rendering

- `ErrorController::handler()` (`src/Controller/ErrorController.php`) and the subscriber both build:
  `#theme => 'custom_error_display'`, `#cache => ['max-age' => 0]`, `#data => $errorData`,
  `#ai_fix_btn => moduleExists('error_ai_recommendations')`, then `renderer->renderRoot()` and send
  a `Response` with `HTTP_INTERNAL_SERVER_ERROR`.
- Theme hook `custom_error_display` registered in `error_reporting_theme()`; template
  `templates/custom-error-display.html.twig`. `error_reporting_preprocess_custom_error_display()`
  adds `drupal_version` and `php_version`.
- Template loads highlight.js, MDB UI kit, jQuery, Font Awesome, DOMPurify/showdown from CDNs;
  local CSS/JS are referenced by path from `errorData['css']`/`['js']`.

## ExceptionFormatter (`src/Utility/ExceptionFormatter.php`)

- `formatException(\Throwable)` returns an array:
  - `message`, `exception_type` (mapped by `getExceptionType()` from the class/error constants to
    "Fatal Error"/"Warning"/"Notice"/"Deprecated"/"ERROR"),
  - `trace` — the main frame plus each backtrace frame that has a readable `file`; every frame gets
    `file`, `line`, `function`, and `content` (a source excerpt),
  - `server` (`$_SERVER` all), `request` (POST all), `cookie` (all), `session` (all if present),
  - `css`, `js` paths (resolved from the module extension path).
- `getFormattedLines(array $lines, $errorLine)`: returns 17 lines before and 17 after the error
  line, each prefixed with its 1-based line number; `<` is replaced with `&lt;` in the excerpt.
- Reads file contents with `file_get_contents()` only when `is_readable()` && `file_exists()`.

## Assets

- `libraries/css/error_reporting.css`, `libraries/js/error_reporting.js` — plain files referenced
  directly; there is no `error_reporting.libraries.yml` and no `library_dependencies`.
