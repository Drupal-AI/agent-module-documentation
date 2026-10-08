# Sending API: RestClient, hooks, event

## `site_audit_send.rest_client` service (`RestClient`)

Constructor arg `@config.factory`. Uses a Guzzle client.

- `postReport(SiteAuditReport $entity): ResponseInterface` — reads `remote_url` from
  `site_audit_send.settings`, builds a JSON payload from the entity's fields (`payload['report'][field]`),
  runs `hook_alter('site_audit_remote_payload', $payload)`, POSTs it, returns the response. On
  connection failure returns a synthetic `599` response.
- `testUrl($url): ResponseInterface` — POSTs `{test: true}` to validate an endpoint (used by the
  settings form validator).

```php
$client = \Drupal::service('site_audit_send.rest_client');
$response = $client->postReport($report_entity);
```

A 200 response is expected to carry a `ReportUri` header pointing at the stored remote report.

## Send-method hooks

Send methods are discoverable and pluggable:

```php
// Register method options (shown as radios on the send form).
function mymodule_site_audit_send_send_methods() {
  return ['my_dest' => t('My destination')->render()];
}

// Handle sending for method "my_dest".
function mymodule_site_audit_send_send_my_dest(\Drupal\site_audit_report_entity\Entity\SiteAuditReport &$entity) {
  // deliver $entity somewhere…
}
```

Shipped methods: `report_api` (remote server, implemented by
`site_audit_send_site_audit_send_send_report_api()` which calls `RestClient::postReport` and dispatches
the event) and `email` (placeholder "coming soon").

## Event `site_audit_report_sent`

`SiteAuditSentEvent` (constant `EVENT_NAME = 'site_audit_report_sent'`) is dispatched after a
`report_api` send, carrying `->report` (the entity) and `->response` (the Guzzle response).

```php
class MySub implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [\Drupal\site_audit_send\Event\SiteAuditSentEvent::EVENT_NAME => 'onSent'];
  }
  public function onSent(\Drupal\site_audit_send\Event\SiteAuditSentEvent $event): void {
    // $event->report, $event->response
  }
}
```

## Payload alter

`hook_alter('site_audit_remote_payload', &$payload)` lets any module change the outbound JSON before
it is POSTed.
