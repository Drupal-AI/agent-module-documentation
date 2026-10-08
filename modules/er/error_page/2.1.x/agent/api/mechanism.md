# How error_page works internally

The design principle: an uncaught exception may mean the container/services are broken, so the
module avoids Drupal services, the config system and Twig wherever possible.

## Uncaught exceptions (automatic on enable)

1. **Service swap** — `src/ErrorPageServiceProvider.php` (a `ServiceModifierInterface`)
   rewrites the class of core's `exception.logger` service to
   `Drupal\error_page\EventSubscriber\ErrorPageExceptionLoggingSubscriber`. This subclass of
   core `ExceptionLoggingSubscriber` overrides `onError()` to also generate a UUID (stored on
   the request attribute `_error_page_uuid`) and log it to the `php` logger channel + PHP
   error log.
2. **Final subscriber** — `error_page.exception_subscriber`
   (`ErrorPageFinalExceptionSubscriber`, defined in `error_page.services.yml`, arg
   `@config.factory`) subscribes to `KernelEvents::EXCEPTION` at **priority -255**, i.e. one
   step before core's `FinalExceptionSubscriber` (-256). Its `onException()` builds an
   `error_report` (respecting the site's error-display verbosity, adding a backtrace only in
   verbose mode), calls `ErrorPageRenderer::render('page', …)`, and sets a `Response` (500, or
   the original status code for an `HttpExceptionInterface`), which pre-empts core's page.

Verify the swap on a live site:

```bash
drush php:eval "echo get_class(\Drupal::service('exception.logger'));"
# -> Drupal\error_page\EventSubscriber\ErrorPageExceptionLoggingSubscriber
```

## Fatal / user errors (only if handlers registered)

`src/ErrorPageErrorHandler.php` is a static class (class-mapped in composer.json so it loads
without the container). `handleError()` / `handleException()` are ~95% copies of core's
`_drupal_error_handler_real()` / `_drupal_exception_handler()`, adjusted to call
`ErrorPageRenderer` for output. `logError()` decides fatal vs not, logs via
`\Drupal::logger('php')` when a logger factory exists, and falls back to
`ErrorPagePhpErrorLogger::log()` (a thin wrapper over PHP `error_log()` driven by the
`log[method]`/`log[destination]` settings). Handling differs by SAPI: CLI prints plain text
and `exit(1)`; XHR prints the raw message; web renders the HTML page.

## Rendering

`src/ErrorPageRenderer.php::render($type, $uuid, $original_exception, $error_report)` reads
`error_{$type}.html` from `template_dir` (or the module `markup/` dir) and does a plain
`strtr()` of the three tokens. If rendering itself throws, it delegates to
`_drupal_exception_handler_additional()` and exits — so a broken template can never loop.

## Logging classes

- `ErrorPagePhpErrorLogger` (`ErrorPagePhpErrorLoggerInterface`) — wraps `error_log()`.
- Logger channel used for watchdog entries: **`php`** (message includes `[@uuid]`).
