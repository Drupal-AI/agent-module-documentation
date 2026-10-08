# CacheTag Notify — manual setup guide

**CacheTag Notify** (`cachetag_notify`) bridges Drupal's cache-tag invalidations to the
outside world. Whenever Drupal invalidates cache tags, this module POSTs the list of
those tags — as a JSON body — to a URL you configure. That lets an external system
react: a CDN or reverse proxy can purge the matching content, a static-site build can
be triggered, or any other webhook-style integration can stay in sync with Drupal's
cache.

This is useful for headless and edge-cached setups where content lives in more than
one cache tier and something outside Drupal needs to know when Drupal's content
changes. It is a **Performance / cache-invalidation** feature; it decides what to
notify, not who can see anything, and has no access-control role.

The destination endpoint is set by an administrator on a settings form — it is **not**
taken from incoming requests, so there is no untrusted-input risk in where the
notifications go. The module sends the POST with Guzzle using its default TLS
verification (certificate checks stay **on**), which is the safe behaviour. Point the
endpoint at a service you control.

The module works on Drupal 8.8, 9, and 10.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the endpoint URL that receives the
   invalidated cache tags.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → CacheTag Notify**
(`/admin/config/system/cachetag_notify`), gated by the core **Administer site
configuration** permission.

## How to use it

Enable the module, open the settings form, and enter the URL of the external service
that should be told about cache-tag invalidations. From then on, every invalidation
POSTs its tag list as JSON to that endpoint automatically. Delivery failures are
logged to Drupal's log (watchdog), so you can check there if the receiving service
isn't getting the notifications.
