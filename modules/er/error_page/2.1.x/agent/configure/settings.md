# Configuring error_page (settings.php only)

error_page has **no configuration UI** and stores nothing in Drupal config. Everything is set
in `settings.php` (or `settings.local.php`) under the `$settings['error_page']` array. The
values are read with `Drupal\Core\Site\Settings::get('error_page')`.

## Uncaught exceptions — zero config

Just enabling the module is enough to replace core's 500 page for **uncaught exceptions**.
`ErrorPageServiceProvider` swaps the `exception.logger` service class and the module
registers a final exception subscriber. No `settings.php` entry required.

## Fatal / user PHP errors — register the handlers

To also intercept **fatal and user-level PHP errors** (not just exceptions), register the
module's handlers in `settings.php`:

```php
// Only needed if you are NOT using Composer autoloading (Composer class-maps this file):
require_once 'modules/contrib/error_page/src/ErrorPageErrorHandler.php';

set_error_handler(['Drupal\error_page\ErrorPageErrorHandler', 'handleError']);
set_exception_handler([
  'Drupal\error_page\ErrorPageErrorHandler',
  'handleException',
]);
```

## Settings keys

| Setting | Type / default | Effect |
|---|---|---|
| `$settings['error_page']['uuid']` | bool, **default TRUE** | Generate a UUID per error/exception, expose it in the page (`{{ uuid }}`) and log it. Set FALSE to disable. |
| `$settings['error_page']['template_dir']` | string path, default = module's `markup/` | Directory holding custom `error_page.html` / `error_message.html`. If only one file is customized there, the other falls back to the module copy. |
| `$settings['error_page']['log']['method']` | int, default `0` | First arg to PHP `error_log()`. `3` = write to a file. |
| `$settings['error_page']['log']['destination']` | string | Destination when `method` = 3, e.g. `temporary://error_log.txt`. |

Example, all together:

```php
$settings['error_page']['uuid'] = TRUE;
$settings['error_page']['template_dir'] = DRUPAL_ROOT . '/../templates/error_page';
$settings['error_page']['log']['method'] = 3;
$settings['error_page']['log']['destination'] = 'temporary://error_log.txt';
```

## Reading the live value

```bash
drush php:eval "var_export(\Drupal\Core\Site\Settings::get('error_page'));"
```

## Testing (dev only)

Enable the bundled `error_page_test` module after setting
`$settings['extension_discovery_scan_tests'] = TRUE;` (never in production). It exposes
`/error_page_test/exception`, `/error_page_test/fatal_error`, `/error_page_test/user_error`,
`/error_page_test/php_notice`.
