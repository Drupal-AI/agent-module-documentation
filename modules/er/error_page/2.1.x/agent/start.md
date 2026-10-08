# Error custom pages (error_page) — agent index

Replaces Drupal's raw fatal-error/exception output with a friendly, customizable HTML page,
optionally tagging each incident with a UUID. **No admin UI, no config entities, no Drush,
no permissions, no plugins** (`configure` = null, `provides_config_schema` = false). It is
configured **only through `settings.php`** under `$settings['error_page']`, and it activates
its exception handling automatically on enable via a service-class swap.

- **All `settings.php` keys, handler registration, and how to customize the page markup** →
  [configure/settings.md](configure/settings.md)
- **How it hooks into Drupal internally (service swap, event subscriber, error handlers, renderer)** →
  [api/mechanism.md](api/mechanism.md)
- **Customizing / overriding the rendered output and templates** →
  [extend/templates.md](extend/templates.md)

Key facts:
- Enabling the module swaps core's `exception.logger` service class to
  `Drupal\error_page\EventSubscriber\ErrorPageExceptionLoggingSubscriber` and registers
  `error_page.exception_subscriber` (`ErrorPageFinalExceptionSubscriber`, priority **-255** on
  `KernelEvents::EXCEPTION`) — this covers **uncaught exceptions** with no settings needed.
- To also catch **fatal / user PHP errors** you must add `set_error_handler()` /
  `set_exception_handler()` for `Drupal\error_page\ErrorPageErrorHandler` in `settings.php`.
- Markup tokens: `{{ uuid }}`, `{{ base_path }}`, `{{ error_report }}` in
  `markup/error_page.html` and `markup/error_message.html`.
