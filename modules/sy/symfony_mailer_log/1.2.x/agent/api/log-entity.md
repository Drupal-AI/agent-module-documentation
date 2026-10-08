<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `symfony_mailer_log` entity & storage

## Entity

Content entity type **`symfony_mailer_log`** (base table `symfony_mailer_log`, `internal = TRUE`,
admin permission `administer symfony mailer entity log entries`). It is not fieldable in the usual
sense — Field UI base route is the collection — and holds one row per logged email.

Links: collection `/admin/reports/symfony_mailer_log`, canonical
`/admin/reports/symfony_mailer_log/{id}`, delete-form `.../{id}/delete`.

### Base fields

| Field | Type | Meaning |
|---|---|---|
| `id`, `uuid`, `langcode` | — | entity keys |
| `type` | string | email type (Mailer type / first tag) |
| `sub_type` | string | email sub-type (remaining tag segments) |
| `from`, `to`, `reply_to`, `cc`, `bcc` | string (multi) | addresses, formatted `Name <email>` |
| `headers` | string (multi) | raw email headers |
| `subject` | string (max 1024) | email subject; used as the entity label |
| `html_body` | string_long | HTML body (viewed via `symfony_mailer_log_html_body` formatter) |
| `text_body` | string_long | plain-text body |
| `account` | entity_reference → user | recipient's Drupal account, if known |
| `theme` | string | theme used to render the email |
| `transport_dsn` | string | transport DSN that (would have) delivered it |
| `created` | created | timestamp the entry was logged |
| `error_message` | string | send error (first 255 chars), if the send failed |

Interface `SymfonyMailerLogInterface` exposes typed getters/setters
(`getSubject()/setSubject()`, `getTo()`, `getErrorMessage()`, `getCreatedTime()`, etc.).

## Querying entries programmatically

```php
$storage = \Drupal::entityTypeManager()->getStorage('symfony_mailer_log');

// All entries to a given address, newest first.
$ids = $storage->getQuery()
  ->accessCheck(FALSE)
  ->condition('to', 'alice@example.com')
  ->sort('created', 'DESC')
  ->execute();
$logs = $storage->loadMultiple($ids);
foreach ($logs as $log) {
  print $log->getSubject() . ' — ' . ($log->getErrorMessage() ?? 'sent OK');
}
```

## Storage helper — expiry

`SymfonyMailerLogStorage` (implements `SymfonyMailerLogStorageInterface`) adds:

```php
public function deleteExpiredBatched(\DateInterval $maximum_age, ?int $batch_size = NULL): void;
```

It deletes the oldest entries with `created < now - $maximum_age`, limited to `$batch_size`
(null = all). This is what `hook_cron` calls using the `log_expiry.*` settings. There is no
public "create a log" API — entries are created by the "Log email" EmailAdjuster during the
Mailer send pipeline (see `configure/settings.md`).
