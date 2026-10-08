Error custom pages (error_page) replaces Drupal's plain crash output with a friendly, customizable HTML page whenever an uncaught exception or a fatal/user error occurs, and can attach a UUID to each incident so a visitor can quote it to support.

---

The module is deliberately service-light: because an uncaught exception means Drupal services may be unavailable, it avoids the container, configuration API and Twig, and is instead configured entirely through `settings.php`. It works in two ways. For uncaught exceptions it swaps core's `exception.logger` service class with `ErrorPageExceptionLoggingSubscriber` (via `ErrorPageServiceProvider`) and registers `error_page.exception_subscriber` (`ErrorPageFinalExceptionSubscriber`) which runs at priority -255 on `KernelEvents::EXCEPTION`, just before core's `FinalExceptionSubscriber`, to render its own 500 page and stop event propagation. For fatal and user-level PHP errors it provides `ErrorPageErrorHandler::handleError()` / `handleException()`, which you register from `settings.php` with `set_error_handler()` / `set_exception_handler()` (the class is class-mapped in the module's composer.json so it autoloads even before the container boots). Output is rendered by `ErrorPageRenderer`, which reads a plain HTML file (`markup/error_page.html` for pages, `markup/error_message.html` for inline messages) and does raw token replacement of `{{ uuid }}`, `{{ base_path }}` and `{{ error_report }}` — no Drupal rendering involved. A generated UUID is logged to the Drupal logger channel `php` and, for fatal cases, to the PHP error log via `ErrorPagePhpErrorLogger`. Everything is tuned by keys under `$settings['error_page']`: `uuid` (bool, default TRUE), `template_dir` (custom markup directory), and `log[method]` / `log[destination]` (passed straight to PHP's `error_log()`).

---

- Show visitors a branded "We cannot serve your request" page instead of Drupal's raw white-screen-of-death on a fatal error.
- Give each error a UUID so a user can quote it to the help desk and support can grep it in the logs.
- Replace the default 500 exception output with custom HTML that matches the site theme.
- Log every uncaught exception's UUID into the Drupal `php` logger channel for later correlation.
- Register `ErrorPageErrorHandler` in `settings.php` to catch fatal and recoverable PHP errors, not just exceptions.
- Customize the crash page copy by copying `markup/error_page.html` to a directory outside the web root and pointing `template_dir` at it.
- Customize the inline error status message shown for non-fatal user errors via `markup/error_message.html`.
- Inject the site logo or CSS into the error page using the `{{ base_path }}` token to build asset URLs.
- Suppress UUID generation on sites that don't want it by setting `$settings['error_page']['uuid'] = FALSE`.
- Pipe fatal-error details to a dedicated file with `$settings['error_page']['log']['method'] = 3` and a `destination`.
- Keep verbose backtraces out of the public page automatically (the `{{ error_report }}` token is empty unless the site's error-display verbosity allows it).
- Provide a consistent 500 page across web, AJAX (`XmlHttpRequest`) and CLI contexts.
- Preserve HTTP semantics — an `HttpExceptionInterface` keeps its own status code and headers while still showing the friendly page.
- Use it on a production site where `display_errors` is off, so users get a helpful page rather than a blank one.
- Reference a specific incident from a monitoring alert by its UUID logged in watchdog.
- Protect custom templates from public access with the shipped `markup/.htaccess` or by storing them above the web tree.
- Give a support team a single template to restyle without needing to touch PHP or Twig.
- Handle `__toString()` recoverable fatals gracefully with the same friendly page.
- Show an appropriate install-time error message when a fatal occurs during Drupal installation.
- Roll the module out with zero configuration for the exception case (the service swap is automatic on enable) and add `settings.php` handlers only when you also want PHP error coverage.
- Test the different failure modes with the bundled `error_page_test` module (`/error_page_test/exception`, `/fatal_error`, `/user_error`, `/php_notice`).
