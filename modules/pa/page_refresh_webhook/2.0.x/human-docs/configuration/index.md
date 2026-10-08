# Configuration

Page Refresh WebHook needs four things set: **where** to send the request (the
endpoint), **how** to authenticate it (an API key via the Key module, optional),
**which** content types trigger it, and **how deep** the refresh should go (crawl
depth).

## Store the API key with the Key module (do this first)

The API key value is **never stored in this module's configuration** — only a
reference to a **Key** entity is. Create the key first:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Add a key holding your endpoint's API key value. An **environment‑variable** or
   **file** provider is recommended so the secret never lands in exported config or
   the database.

> **Never hard‑code or commit a secret.** Keep the value in an environment variable
> (or a file outside the docroot) and let the Key module read it. If the selected
> Key is missing at send time, the request errors and is retried or dropped by the
> queue rules.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Page Refresh WebHook**, or navigate
   directly to `/admin/config/services/page-refresh-webhook` (config route
   `page_refresh_webhook.settings`).

## The fields

- **Endpoint** — the URL the POST request is sent to. **Leaving it empty switches
  the webhook off** (nothing is queued) without changing your content‑type
  selections — handy so one config can ship to every environment.
- **API key** — select the Key entity you created above. Its value is sent as an
  `api-key` request header. Leave it unset to send unauthenticated requests.
- **Content types** — enable only the content types whose saves should trigger the
  webhook. Each enabled type has its own crawl depth.
- **Crawl depth** (per content type) — `1` sends just the changed page's URL; `2`
  sends the URL plus linked/attached elements.

The request body is JSON: `{"docs":[{"url": "…"}],"depth": N}`.

## Set the endpoint per environment (optional)

Because an empty endpoint disables the webhook, a common pattern is to leave
`endpoint` empty in exported config and set it only where requests must actually go
— for example production — via a `settings.php` override:

```php
$config['page_refresh_webhook.settings']['endpoint'] = 'https://example.com/admin/crawl';
```

A `$config` override is not shown in the form and the form will not overwrite it.

## How and when it fires

Saving a node of an enabled content type **queues** a request; the queue worker
sends it on the next **cron** run (or immediately with
`drush queue:run page_refresh_webhook`). New and still‑unpublished nodes are skipped
automatically. If the endpoint is unreachable the queue retries next run; if the
endpoint rejects the request (e.g. HTTP 403) the item is dropped and logged.

Remember the direction: this is an **outbound** call from your site — there is no
inbound route a third party can hit. The only authentication involved is the API key
your site sends, so make sure your endpoint verifies that `api-key` header.

You can inspect the stored settings any time with:

```bash
drush config:get page_refresh_webhook.settings
```
