# Programmatic API — events & tokens

The tracker's `gtag("config", …)` and `gtag("event", …)` calls are built through Symfony events,
so other modules add configuration and events by subscribing. Event names are constants on
`Drupal\google_analytics\Constants\GoogleAnalyticsEvents`:

- `ADD_CONFIG` (`google_analytics_add_config`) — dispatched per account with a
  `GoogleAnalyticsConfigEvent` (holds the `GaJavascriptObject` + account). Subscribe to add/modify
  `gtag("config")` parameters. Core subscribers: `EventSubscriber/GoogleAnalyticsConfig/DefaultConfig`, `CustomConfig`.
- `ADD_EVENT` (`google_analytics_add_event`) — dispatched with a `GoogleAnalyticsEventsEvent`; call
  `$event->addEvent($name, $parameters)` to emit an extra `gtag("event")`. See
  `EventSubscriber/GoogleAnalyticsEvents/*`.
- `PAGE_PATH` (`google_analytics_page_path`) — set a custom tracked page path; stop propagation once
  matched. Core subscribers under `EventSubscriber/PagePath/*` (Search, HttpStatus, ContentTranslation, InvalidUserLogin).
- `BUILD_JAVASCRIPT` (`google_analytics_build_javascript`).

Register a subscriber the usual way (`*.services.yml` tagged `event_subscriber`).

## Tokens (`google_analytics.tokens.inc`)
Adds two **user** tokens usable in custom snippets / custom dimensions:
- `[user:role-names]` — comma-separated role names of the account.
- `[user:role-ids]` — comma-separated role machine ids.

## Legacy `google_analytics_api()`
`hook`-style function returning `['api' => 'gtag.js']`, advertising the supported tracking API.
