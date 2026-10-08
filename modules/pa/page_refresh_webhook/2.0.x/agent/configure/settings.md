<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Page Refresh WebHook

**Admin UI:** `/admin/config/services/page-refresh-webhook` (route `page_refresh_webhook.settings`, permission `administer site configuration`).
**Config object:** `page_refresh_webhook.settings` (has schema; `drush config:get page_refresh_webhook.settings`).

## Keys

| Key | Type | Meaning |
|---|---|---|
| `endpoint` | uri, nullable | URL the POST is sent to. Empty/`null` = webhook off (nothing queued, nothing logged), but content-type settings are kept. |
| `api_key` | string (Key entity ID), nullable | Key whose value is sent as the `api-key` request header. Empty = unauthenticated requests. |
| `content_types` | sequence keyed by node bundle | Only enabled bundles are stored. Each: `enabled` (bool), `depth` (int, `1` or `2`). |

Default install config: `endpoint: null`, `api_key: null`, `content_types: {}` (off, no bundles).

`depth` 1 = only the entity URL; 2 = URL plus linked/attached elements. Default when unset: `1`.

## Set via drush

```bash
# Enable webhook for the "article" bundle at depth 2.
drush config:set page_refresh_webhook.settings content_types.article.enabled true -y
drush config:set page_refresh_webhook.settings content_types.article.depth 2 -y
drush config:set page_refresh_webhook.settings endpoint 'https://example.com/admin/crawl' -y
drush config:set page_refresh_webhook.settings api_key my_key_id -y
```

## API key (Key module)

The value is never stored in this module's config — only the Key entity ID is. Create the Key at `/admin/config/system/keys` (env- or file-backed provider recommended). At send time the module resolves it via `key.repository`; a missing Key throws a `RuntimeException` and the queue item is retried/dropped per the queue rules.

## Per-environment endpoint

Leave `endpoint` empty in exported config and set it only where requests must go, e.g. in `settings.php`:

```php
$config['page_refresh_webhook.settings']['endpoint'] = 'https://example.com/admin/crawl';
```

A `$config` override is not shown in the form and the form does not overwrite it (the form reads/writes stored config only).

## Send timing

Requests are **not** sent on save — they are queued (`page_refresh_webhook` queue) and sent by the queue worker on cron. See [../drush/queue.md](../drush/queue.md).
