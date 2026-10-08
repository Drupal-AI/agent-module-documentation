<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webhook` content entity

`Drupal\webhook\Entity\Webhook` — a `ContentEntityType` recording received webhooks.

- id `webhook`, base table `webhook`, `admin_permission = access webhook overview`.
- Handlers: `EntityViewBuilder`, `WebhookListBuilder`, `EntityViewsData`, add/edit form
  `WebhookForm`, delete `ContentEntityDeleteForm`, `AdminHtmlRouteProvider`.
- Links: collection `/admin/content/webhook`, add `/admin/content/webhook/add`,
  canonical `/webhook/{webhook}`, edit/delete under `/admin/content/webhook/{webhook}/…`.

## Base fields (`baseFieldDefinitions`)

| Field | Type | Notes |
|---|---|---|
| `title` | string (required, ≤255) | Set to `"Webhook {uuid}"` by the subscriber. |
| `headers` | string_long | JSON-encoded request headers of the received webhook. |
| `payload` | string_long | JSON-encoded payload. |
| `created` | created | Timestamp. |

Plus `getTitle()/setTitle()`, `getCreatedTime()/setCreatedTime()`.

## How records are created — `WebhookSubscriber`

`Drupal\webhook\EventSubscriber\WebhookSubscriber` (service subscribes to `webhook.send` and
`webhook.receive`):

```php
public function onWebhookReceive(ReceiveEvent $event) {
  $webhook = Webhook::create([
    'title'   => $this->t('Webhook @uuid', ['@uuid' => $event->getWebhook()->getUuid()]),
    'headers' => json_encode($event->getWebhook()->getHeaders()),
    'payload' => json_encode($event->getWebhook()->getPayload()),
    'created' => time(),
  ]);
  $webhook->save();
}
```

`onWebhookSend()` is an empty stub (no persistence on send). So enabling this submodule causes every
**incoming** webhook dispatched as `webhook.receive` by the parent framework to be stored and listed.
Templating: `hook_theme('webhook')` + `template_preprocess_webhook()` render the canonical view.
