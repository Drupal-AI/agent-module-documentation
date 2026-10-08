<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism & programmatic access

## How instrumentation is wired

`http_client_log.services.yml`:

```yaml
services:
  http_client_log_decorator:
    class: Drupal\http_client_log\HttpClientLogService
    public: false
    decorates: http_client_factory
    decoration_priority: 1
    arguments:
      - '@http_handler_stack'
      - '@entity_type.manager'
      - '@config.factory'
      - '@datetime.time'
```

`HttpClientLogService` (`src/HttpClientLogService.php`) extends core
`Drupal\Core\Http\ClientFactory`. In its constructor it calls `parent::__construct($stack)` and then:

```php
$logger = new Logger($entity_type_manager, $config_factory, $time);
$this->stack->push(new LogMiddleware($logger, new SimpleHandler()));
```

`LogMiddleware` and `HandlerInterface` come from `covergenius/guzzle_logger`
(`GuzzleLogMiddleware\…`). Because the service decorates `http_client_factory`, every client
returned by `\Drupal::httpClient()` / the `http_client` service carries the middleware. There is no
way to opt a single request out except through the configured filters (URL/method/time/status/
content-type) — see `agent/config/settings.md`.

`SimpleHandler` (defined in the same file) implements the library's `HandlerInterface` and simply
forwards the request/response/exception/options as a context array to `Logger::log()`.

## What `Logger::log()` does

`src/Logger/Logger.php` reads `context['request']` and `context['response']`, applies the filter
chain, and on success builds the entity:

```php
$field_values = [
  'type' => 'http_client_log',
  'changed' => $this->time->getCurrentTime(),
  'request_http_method' => $request->getMethod(),
  'request_url' => $request->getUri(),
  'request_headers' => /* every header joined "Name: v1|v2", CRLF-separated */,
  'request_payload' => /* request body stream contents (stream rewound around the read) */,
  // when a Response exists:
  'response_status_code' => $response->getStatusCode(),
  'response_reason_phrase' => $response->getReasonPhrase(),
  'response_headers' => /* every response header, joined */,
  'response_body' => /* response body stream contents */,
  // when an exception exists:
  'errors' => $context['exception']->getMessage(),
];
$this->entityTypeManager->getStorage('http_client_log')->create($field_values)->save();
```

Notes:
- Headers and bodies are captured verbatim; there is **no redaction, masking, or truncation** in the
  logger. (The DB columns are `longtext` via `string_long`.)
- The body streams are read with `getContents()` and rewound if seekable, so logging does not consume
  the response for the calling code.
- A `context` key is set in `$field_values` but there is no `context` base field, so it is dropped on
  save.
- Save failures are caught and reported to the standard `http_client_log` logger channel; they do not
  break the HTTP request.

## Reading logs programmatically

The `http_client_log` entity is a normal content entity:

```php
$storage = \Drupal::entityTypeManager()->getStorage('http_client_log');
$ids = $storage->getQuery()
  ->accessCheck(TRUE)
  ->condition('response_status_code', 400, '>=')
  ->sort('id', 'DESC')
  ->range(0, 50)
  ->execute();
foreach ($storage->loadMultiple($ids) as $log) {
  $method = $log->get('request_http_method')->value;
  $url    = $log->get('request_url')->value;
  $status = $log->get('response_status_code')->value;
  $body   = $log->get('response_body')->value;
}
```

Fields available: `request_http_method`, `request_url`, `request_headers`, `request_payload`,
`response_status_code`, `response_reason_phrase`, `response_headers`, `response_body`, `errors`,
`name`, `user_id`, `status`, `created`, `changed`.

## Entity type & routes

- Content entity `http_client_log` — `base_table: http_client_log`,
  `admin_permission: administer http client log entity entities`, publishable, owner = current user
  at creation. Access handler: `src/HttpClientLogEntityAccessControlHandler.php`.
- Config bundle entity `http_client_log_entity_type` (`src/Entity/HttpClientLogEntityType.php`)
  provides the single `http_client_log` bundle and its add/edit/delete structure forms.
- Routes: detail `entity.http_client_log.canonical`
  (`/admin/reports/http-client-logs/{http_client_log}`, `_entity_access: http_client_log.view`);
  listing via `views.view.http_client_log` at `/admin/reports/http-client-logs`
  (`perm: administer http client log entity entities`); settings
  `http_client_log.settings` (`administer site configuration`).
