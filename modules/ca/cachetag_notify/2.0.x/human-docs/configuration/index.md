# Configuration

CacheTag Notify needs one thing: the URL of the external service that should receive
your cache-tag invalidations.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → CacheTag Notify**, or navigate directly to
   `/admin/config/system/cachetag_notify`.

## Set the notify endpoint

Enter the **endpoint URL** that should receive the notifications. From then on,
whenever Drupal invalidates cache tags, the module POSTs the list of invalidated tags
as a JSON body to that URL. Typical targets are:

- a **CDN or reverse-proxy** purge webhook (Varnish, Fastly, and the like),
- a **static-site rebuild** hook, or
- any other service that needs to react to Drupal content changes.

Save the form. There is nothing else to tune — the notification fires automatically on
every invalidation once an endpoint is set.

## Good practice for the endpoint

- **Point it only at a service you control or trust.** The URL is configured here by an
  administrator and is never taken from incoming web requests, so there's no risk of an
  attacker redirecting the notifications — but the tag list still leaves your site, so
  send it somewhere you own.
- **Use HTTPS.** The module sends the POST with Drupal's default HTTP client settings,
  which keep TLS certificate verification **enabled** — so an `https://` endpoint is
  verified normally. Prefer it over plain `http://`.
- **Watch the log.** Delivery problems — client, server, or connection errors — are
  logged to Drupal's log (watchdog), so check there if the receiving service isn't
  seeing the notifications.
