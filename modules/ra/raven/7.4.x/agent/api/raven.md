# Raven API — services, events, callbacks

## Logger service

`logger.raven` (`Drupal\raven\Logger\Raven`, interface `Drupal\raven\Logger\RavenInterface`)
is registered as a Drupal logger and as the Sentry client holder. Use
`getClient()` to reach the underlying Sentry client. Normal Drupal logging flows to
Sentry automatically for enabled levels:

```php
\Drupal::logger('my_module')->error($exception);
```

You can also call the Sentry SDK directly anywhere in Drupal:

```php
\Sentry\captureException($e);
\Sentry\captureMessage('Something happened', \Sentry\Severity::warning());
\Sentry\addBreadcrumb(new \Sentry\Breadcrumb(...));
\Sentry\configureScope(function (\Sentry\State\Scope $scope) {
  $scope->setTag('interesting', 'yes');
});
```

## Events (subscribe to customize)

Raven dispatches two events (both in `Drupal\raven\Event`, extending
`Drupal\Component\EventDispatcher\Event`); subscribe with an
`EventSubscriberInterface`:

| Event | Public property | Use |
|---|---|---|
| `OptionsAlter` | `array &$options` | Mutate Sentry PHP client options before the client is built — set `before_send`, `before_breadcrumb`, `ignore_exceptions`, `in_app_exclude`/`in_app_include`, etc. |
| `AttributesAlter` | `array &$attributes`, `array $context` | Alter attributes on outgoing Sentry structured logs (context is read-only). |

Example subscriber that drops all events during maintenance mode:

```php
use Drupal\raven\Event\OptionsAlter;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public function onOptionsAlter(OptionsAlter $event): void {
    $event->options['before_send'] = fn($e, $hint) => $e; // return NULL to drop
  }
  public static function getSubscribedEvents(): array {
    return [OptionsAlter::class => 'onOptionsAlter'];
  }
}
```

Sentry callbacks you can set through `OptionsAlter`: `before_send`,
`before_breadcrumb`, `before_send_log`. Ignore exception classes via the
`ignore_exceptions` option; hide/show stack frames via `in_app_exclude` /
`in_app_include` (use the `DRUPAL_ROOT` constant for paths).

## JavaScript SDK

The browser SDK config can be altered in PHP via the `js_settings_alter` hook or by
setting `$page['#attached']['drupalSettings']['raven']['options']`, or in JS via
`drupalSettings.raven.options` (e.g. `ignoreErrors`, `beforeSend`). Custom JS that
calls the Sentry API must depend on the `raven/raven` library.

## Other services

- `http_client_middleware.raven` — adds tracing headers / spans to Guzzle requests.
- `raven.request_subscriber`, `raven.csp_subscriber` — request-level and CSP handling.
- `raven.overrider` / `raven.seckit_overrider` — config override providers (env vars, Security Kit).
- `raven.twig_tracing_extension` — Twig extension for template spans.

## Monolog integration

With the Monolog module, target `drupal.raven` as a handler in
`web/sites/default/monolog.services.yml`; disable the `message_placeholder` and
`filter_backtrace` processors so stack traces and aggregation work.
