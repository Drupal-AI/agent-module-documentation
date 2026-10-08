<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Graph Mail API — `graph_mail.helper` and the `graphmail` plugin

## The `graphmail` Mail plugin

`\Drupal\graph_mail\Plugin\Mail\GraphMail` (id `graphmail`) implements `MailInterface`.
`format()` joins the body array into one string; `mail()` calls
`MailHelper::initMailBody()` then `MailHelper::send()`, catching exceptions, logging them to
the `graph_mail` channel, and re-queuing on HTTP 429. Use it like any core mail plugin — send
via the mail manager with the module/key you configured Graph Mail for:

```php
\Drupal::service('plugin.manager.mail')->mail(
  'mymodule', 'mykey', 'to@example.com', $langcode,
  ['message' => '<p>Hello</p>', 'subject' => 'Hi'],
);
```

(Only reaches Graph if `graphmail` is the selected plugin for that module/key — see
[../configure/settings.md](../configure/settings.md).)

## Service `graph_mail.helper` — `\Drupal\graph_mail\MailHelper`

Constructor args: `@config.factory`, `@http_client`, `@datetime.time`, `@queue`.

| Method | Purpose |
|---|---|
| `initMailBody(array $message): array` | Builds the Graph `message` payload from Drupal's `$message` array. |
| `send(array $mail_body): void` | Gets a token, POSTs to `/users/{user_id}/sendMail`. Throws on error. |
| `handleException(\Exception $e): int` | Returns retry delay seconds for HTTP 429 (from `Retry-After`, else 600), else 0. |
| `queueMessage(array $mail_body, int $delay): void` | Adds the payload to `graph_mail_retry_queue` with a `retry` timestamp. |
| `config(string $name): ImmutableConfig` | Config accessor helper. |

`initMailBody()` details:
- Body comes from `$message['body']` (string/`MarkupInterface`, or first element if array), else
  `$message['params']['message']`; sent as `contentType: HTML`.
- `to` from `$message['to']`; `cc`/`bcc`/`reply-to` parsed from `$message['headers']`
  (case-insensitive, comma-separated). Addresses parsed via `Symfony\Component\Mime\Address`.
- From = `default_mail` config, else `system.site` mail.
- Attachments: each `$message['params']['attachments']` item (`filename`, `filecontent`) becomes a
  `#microsoft.graph.fileAttachment` with base64 `contentBytes`.
- `saveToSentItems` from the `save_to_sent_items` config value.

## Token / send flow (internal)

`send()` → `initGraph()` → `requestToken()`: POST
`https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token`
(`form_params`: `client_id`, `client_secret`, `scope=https://graph.microsoft.com/.default`,
`grant_type=client_credentials`). Non-200 or a response without `access_token` throws
`GraphMailInitException`. The token initialises a `Microsoft\Graph\Graph` client (API version
from config), which POSTs the payload to `/users/{user_id}/sendMail`.

## Sending directly from code

```php
$helper = \Drupal::service('graph_mail.helper');
$body = $helper->initMailBody([
  'to' => 'a@example.com',
  'subject' => 'Hi',
  'body' => '<p>Hello</p>',
  'headers' => ['Cc' => 'b@example.com'],
]);
$helper->send($body); // throws GraphMailInitException / TransferException on failure
```

## Retry QueueWorker

`\Drupal\graph_mail\Plugin\QueueWorker\RetryQueue` (id `graph_mail_retry_queue`). On cron it
reads each item's `retry` timestamp: if due it re-sends; a further 429 throws
`DelayedRequeueException($delay)`; if not yet due it re-throws `DelayedRequeueException` for the
remaining wait.
