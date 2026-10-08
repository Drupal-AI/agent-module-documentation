# Configuration

Error custom pages has **no configuration UI**. Because it must work even when Drupal's
services and configuration system are unavailable, everything is configured in
**`settings.php`** (or `settings.local.php`) under a `$settings['error_page']` array, plus
one optional handler registration.

## Uncaught exceptions — nothing to configure

Simply enabling the module is enough to replace Drupal's default 500 page for **uncaught
exceptions**. The module swaps in its own renderer automatically on enable, so this case
needs no `settings.php` entry at all.

## Fatal and user-level PHP errors — register the handlers

To also intercept **fatal and user-level PHP errors** (not just exceptions), register the
module's handlers near the bottom of `settings.php`:

```php
// The line below is only needed if you are NOT using Composer autoloading —
// Composer class-maps this file so it usually loads on its own:
// require_once 'modules/contrib/error_page/src/ErrorPageErrorHandler.php';

set_error_handler(['Drupal\error_page\ErrorPageErrorHandler', 'handleError']);
set_exception_handler(['Drupal\error_page\ErrorPageErrorHandler', 'handleException']);
```

## Settings keys

All keys are optional and live under `$settings['error_page']`:

- **`uuid`** *(boolean, default `TRUE`)* — generate a unique ID for each error, show it on
  the page via the `{{ uuid }}` token, and log it. Set it to `FALSE` if you don't want a
  reference code.
- **`template_dir`** *(directory path, default: the module's own `markup/` folder)* — the
  directory holding your custom `error_page.html` and/or `error_message.html`. If you only
  customize one of the two files there, the other falls back to the module's copy.
- **`log['method']`** *(integer, default `0`)* — passed straight to PHP's `error_log()`
  function as its message-type argument. Use `3` to write errors to a file.
- **`log['destination']`** *(string)* — the file to write to when `log['method']` is `3`,
  for example `temporary://error_log.txt`.

A complete example:

```php
$settings['error_page']['uuid'] = TRUE;
$settings['error_page']['template_dir'] = DRUPAL_ROOT . '/../templates/error_page';
$settings['error_page']['log']['method'] = 3;
$settings['error_page']['log']['destination'] = 'temporary://error_log.txt';
```

You can check the live value with Drush:

```bash
drush php:eval "var_export(\Drupal\Core\Site\Settings::get('error_page'));"
```

## Customizing the page markup

The rendered output comes from plain HTML files, not Twig templates:

- **`error_page.html`** — the full error page shown for a crash.
- **`error_message.html`** — the inline status message shown for non-fatal user errors.

To brand them, copy these files out of the module's `markup/` directory into the directory
you set as `template_dir` (ideally somewhere outside the web root, or protected by the
shipped `.htaccess`), and edit them. Three tokens are replaced when the page renders:

- **`{{ uuid }}`** — the incident's unique reference (empty if `uuid` is disabled).
- **`{{ base_path }}`** — your site's base path, useful for building asset URLs so you can
  reference your logo or a stylesheet.
- **`{{ error_report }}`** — verbose error/backtrace details. This stays empty unless the
  site's error-display verbosity permits it, so sensitive details aren't leaked to the
  public page by accident.

## A note on logging

When `uuid` is on, each incident's UUID is written to Drupal's `php` logger channel (so it
appears in the site log / watchdog), and for fatal cases it can also go to the PHP error
log per the `log` settings above. That lets you correlate a code a visitor gives your
support team with the exact incident in your logs, or reference a specific failure from a
monitoring alert.

## Testing (development only)

The bundled `error_page_test` module can trigger each failure mode. To use it, set
`$settings['extension_discovery_scan_tests'] = TRUE;` (never in production), enable the
test module, and visit `/error_page_test/exception`, `/error_page_test/fatal_error`,
`/error_page_test/user_error`, or `/error_page_test/php_notice`.
