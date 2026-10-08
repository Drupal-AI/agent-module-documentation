<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Triggers a POST request to a configurable endpoint when specific content types are saved.

---

Page Refresh WebHook watches node saves (insert/update/delete) and, for the content types you enable, queues a POST request to a configurable endpoint so an external system (e.g. a crawler, static-site builder, CDN, or cache) can rebuild or refresh the changed page. The request is not sent during the save: saving the node adds an item to the `page_refresh_webhook` queue and the queue worker sends it on the next cron run, so a slow or unreachable endpoint can never delay editing or hold the save transaction open. Each request carries a JSON body `{"docs":[{"url":...}],"depth":N}` and, when a Key is selected, an `api-key` header whose value comes from the Key module (env/file backed, never stored in module config). Crawl depth is per content type (1 = just the URL, 2 = the URL and linked/attached elements). Unpublished new nodes and still-unpublished updates are skipped, and other modules can veto a trigger with `hook_page_refresh_webhook_trigger_webhook()`. Leaving the endpoint empty switches the webhook off without changing the enabled content types, so one config can ship to every environment and the endpoint is set only where requests must go (e.g. a `$config` override in `settings.php`). Version 2.0 requires Drupal 11.2+ / PHP 8.3+, uses class-based `#[Hook]` implementations, adds a config schema, and moves the trigger logic into decoratable services.

---

- POST a webhook to an external system when a node is saved.
- Notify a crawler or static-site builder to rebuild a changed page.
- Purge or refresh a CDN/cache entry after content changes.
- Target only specific content types for triggering.
- Send the changed page's absolute URL in the payload.
- Choose crawl depth per content type (1 = URL only, 2 = URL plus linked elements).
- Queue requests so saving content never waits on the endpoint.
- Send queued requests on cron, or on demand with `drush queue:run`.
- Retry automatically when the endpoint is down (queue suspended, items kept).
- Drop requests the endpoint rejects (e.g. HTTP 403) instead of retrying forever.
- Deduplicate repeated saves of the same URL within one cron run.
- Authenticate requests with an API key stored securely via the Key module.
- Run unauthenticated requests by leaving the API key unset.
- Disable the webhook per environment by leaving the endpoint empty.
- Set the endpoint only on production via a `settings.php` `$config` override.
- Skip webhooks for new or still-unpublished nodes automatically.
- Veto a trigger from custom code via `hook_page_refresh_webhook_trigger_webhook()`.
- Prevent refreshes for draft/moderated content.
- Decorate the `page_refresh_webhook.trigger` or `.sender` service to customize behavior.
- Inspect settings with `drush config:get page_refresh_webhook.settings`.
- Aid decoupled / headless / static-build workflows.
