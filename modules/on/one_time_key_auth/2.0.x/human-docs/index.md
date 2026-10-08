# One time key auth — manual setup guide

**One time key auth** (`one_time_key_auth`) is a developer tool that mints
single‑use, short‑lived keys which authenticate a single request as a chosen
user. Ask its service for a key for a given user ID, deliver that key however you
like, and the next request that arrives carrying `?otka=<key>` is treated by
Drupal as if that user were logged in — for exactly one request.

It registers a **global** authentication provider, in the same way core's Cookie
authentication is global: once the module is enabled the provider applies across
the whole site, so any request presenting a valid key is authenticated. There is
no admin form and no configuration screen — the module does nothing on its own
until your code calls its service to generate a key. That makes it the building
block for "magic link" flows, one‑shot API calls, authenticated webhooks, or
download links that must not be reused.

**How the keys are scoped — read this before you use it.** Each key is generated
as 256 bits of cryptographically secure random data (`bin2hex(random_bytes(32))`),
stored with a **15‑minute expiry** (this lifetime is fixed and not currently
configurable), and matched by exact lookup. A key is **deleted the moment it is
used**, so it is genuinely single‑use and cannot be replayed; expired keys are
purged on each use. A security review found the mechanism sound — the keys are
unpredictable, there is no way to guess or forge a key to impersonate another
user, and requests carrying a key are excluded from the page cache.

The one caveat is where the key travels: it rides in the **URL query string**
(`?otka=…`), so it can end up in web‑server and proxy logs, browser history, and
`Referer` headers. Deliver keys only over HTTPS, keep the 15‑minute window short,
and treat any generated URL as a secret. And note the module's own warning:
generating a key for **user 1** (the superuser) hands whoever holds it full
superuser power — deliberately, since that is the point of the tool, but use it
with care.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it is an API only, with no
routes, forms, or permissions of its own. Setup is covered below and in
Installation.

## How to use it

There is no built‑in route that hands out keys — your site or a custom module
controls issuance. In code you ask the service for a key and then deliver it:

```php
$uid = 'The uid of the user you want the key to authenticate as';
$key = \Drupal::service('one_time_key_auth')->generateKeyFor($uid);
// Deliver $key to the recipient over a secure channel (e.g. an emailed HTTPS link).
```

Within 15 minutes, a request to any Drupal URL that includes `otka=<key>` as a
GET or POST value is handled as though the target user were logged in. After that
single request the key is gone. Because issuance is entirely up to you, keep the
generation logic behind whatever authorization your use case requires, and never
generate a key for a more privileged account than the flow actually needs.
