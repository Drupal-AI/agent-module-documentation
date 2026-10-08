# RequestHandlerController — polling API

`src/Controller/RequestHandlerController.php` implements the reverse-connection mechanism. Normally
the Sync Core sends requests inbound to a registered site; for a site it can't reach, this submodule
has the site **pull** those requests and execute them locally.

## How polling works (`processRequests()`)

For each queued item the Sync Core returns from `pollRequests()`:

1. Read the request's method, URL, headers and body.
2. Optionally rewrite the host with the `host` option (so Drupal calls a hostname it can resolve for
   itself — e.g. the internal container host).
3. Re-issue the request with `\Drupal::httpClient()`, attaching HTTP Basic Auth using the site's
   Content Sync credentials (`AuthenticationByUser::getInstance()->getUsername()/getPassword()`).
4. Post the response (status, reason, headers, body) back to the Sync Core via
   `respondToRequest()`, then `sleep(1)` between requests.

This is why **Basic Auth must be enabled and configured for Content Sync** — the replayed requests
authenticate to the site with those credentials. The URLs come from the trusted Sync Core the site
is registered against.

## Public static methods

| Method | Purpose |
|---|---|
| `isEnabled($set = NULL)` | Whether request polling is on. Reads the Sync Core feature flag `ISyncCore::FEATURE_REQUEST_POLLING` (memoized). |
| `enable()` | Turn polling on (`enableFeature(FEATURE_REQUEST_POLLING, 1)`). |
| `disable()` | Turn polling off; called by `hook_uninstall`. |
| `processRequests($limit = 0, $options = […])` | Poll and replay queued requests; returns the count handled. `$options` accepts `text`/`warning` logger callbacks and an optional `host` override. |
| `view()` | Render callback for the status route: shows "no pending requests" or the count waiting (`countRequestsWaitingToBePolled()`). |

## Enabling & running

- **Enable** polling from the parent's Advanced settings (it flips `FEATURE_REQUEST_POLLING` on the
  Sync Core). The status page at `/admin/config/services/cms_content_sync/private-environment`
  (permission `administer cms content sync`) reports how many requests are waiting.
- **Cron** — `cms_content_sync_private_environment_cron()` calls `processRequests(0, …)` when enabled
  and logs an `INFO`/`WARN` summary to the `cms_content_sync_private_environment` logger channel.
- **Drush** — for interactive/one-off processing use the `poll` command
  ([../drush/commands.md](../drush/commands.md)).
