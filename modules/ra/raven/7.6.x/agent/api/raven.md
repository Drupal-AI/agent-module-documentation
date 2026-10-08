<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Raven API — services, events, callbacks

## Logger service

`logger.raven` (`Drupal\raven\Logger\Raven`, interface
`Drupal\raven\Logger\RavenInterface`) is registered as a Drupal logger and holds
the Sentry client. Use `getClient(bool $force_new = FALSE, bool $force_throw =
FALSE)` to build/reach the underlying Sentry client (it calls `\Sentry\init()` with
options assembled from `raven.settings`); `flush()` sends any unsent events. Normal
Drupal logging flows to Sentry automatically for enabled levels:

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

| Event | Constructor / property | Use |
|---|---|---|
| `OptionsAlter` | `public array &$options` | Mutate Sentry PHP client options before the client is built (dispatched inside `Raven::getClient()`) — set `before_send`, `before_breadcrumb`, `ignore_exceptions`, `in_app_exclude`/`in_app_include`, etc. |
| `AttributesAlter` | `public array &$attributes`, `public array $context` | Alter attributes on outgoing Sentry structured logs (context is read-only). |

Example subscriber that can drop events via `before_send`:

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

`Drupal\raven\Hook\PageAttachments` (a `hook_page_attachments`) populates
`$page['#attached']['drupalSettings']['raven']['options']` (dsn, environment,
release, tracesSampleRate, sendClientReports, …). Alter these in PHP with a
`hook_page_attachments_alter`, or in JS via `drupalSettings.raven.options` (e.g.
`ignoreErrors`, `beforeSend`). Custom JS that calls the Sentry API must depend on
the `raven/raven` library. The bundled Sentry browser SDK is the
`raven/sentry-browser` library; by default it is served un-aggregated, but enabling
the `aggregate_bundle` setting flips its `preprocess` flag on (via
`Drupal\raven\Hook\LibraryInfoAlter`, a `hook_library_info_alter`) so it can be
combined with other JS.

## Other services

- `http_client_middleware.raven` (`Http\HttpClientMiddleware`) — wraps Guzzle with
  `Sentry\Tracing\GuzzleTracingMiddleware` to add tracing headers / spans.
- `raven.request_subscriber`, `raven.csp_subscriber`, `raven.config_subscriber`,
  `raven.console_subscriber` — request-level, CSP, config and console
  (non-Drush `dr` command) handling. `ConsoleSubscriber` starts/finishes a Sentry
  transaction per console command when `console_tracing` is enabled.
- `raven.overrider` (`Config\Overrides`) / `raven.seckit_overrider`
  (`Config\SecKitOverrides`) — config override providers (env vars, Security Kit).
- `raven.twig_tracing_extension` — Twig extension for template spans.
- `raven.request_fetcher` — Sentry `RequestFetcher` integration for request context.
- `RavenServiceProvider` swaps the `http_handler_stack` factory to
  `Http\HandlerStackFactory::create()` (opportunistic connection/TLS sharing).

## Monolog integration

With the Monolog module, target `drupal.raven` as a handler in
`web/sites/default/monolog.services.yml`; disable the `message_placeholder` and
`filter_backtrace` processors so stack traces and aggregation work.
