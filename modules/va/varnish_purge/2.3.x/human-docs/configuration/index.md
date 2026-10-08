# Configuration

Varnish Purger has **no settings page of its own**. You configure it by adding a
*purger* through the Purge module and filling in that purger's form. Each
configurable purger you add stores its own settings, so you can run several at
once (for example one per data centre).

## Add a purger

You can add a purger two ways. From Drush:

```bash
drush p:purger-ls                      # list configured purgers
drush p:purger-add varnish             # HTTP purger, one request per invalidation
drush p:purger-add varnishbundled      # one HTTP request per batch
drush p:purger-add varnish_zeroconfig_purger
```

Or from the UI at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`): under *Purgers*, add one and
pick the Varnish plugin.

The **`varnish`** and **`varnishbundled`** purgers each have a configuration form
(click **Configure** next to the purger in Purge's UI). The
**`varnish_zeroconfig_purger`** has *no* form — it is driven entirely from
`settings.php` (see the last section).

## The purger settings, field by field

The form is grouped into vertical tabs. Defaults are shown in parentheses.

- **Name** *(required)* — a human‑friendly label for this purger instance, so you
  can tell several apart.
- **Invalidation type** *(default `tag`)* — the single kind of invalidation this
  purger handles. The options come from Purge's invalidation plugins: `tag`,
  `url`, `wildcardurl`, `everything`, `path`, and so on. Each configurable purger
  clears exactly one type; add more purgers if you need several.
- **Hostname** *(default `localhost`)* — the Varnish host or IP to send requests
  to.
- **Port** *(default `80`)* — the Varnish port.
- **Path** *(default `/`)* — the request path. Purge tokens are replaced here, so
  you can compute the URL per invalidation.
- **Request method** *(default `BAN`)* — the HTTP method. Only `BAN` or `PURGE`
  are offered; match this to what your VCL expects.
- **Scheme** *(default `http`)* — `http` or `https`.
- **Verify SSL certificate** *(default on)* — only relevant when the scheme is
  `https`. Unchecking it lets you talk to a Varnish server with a self‑signed
  certificate, but that is insecure — leave it on in production.
- **Headers** *(default none)* — a table of outbound header `field`/`value` pairs,
  token‑replaced. This is how you do tag purging: add a header named `Cache-Tags`
  with the value `[invalidation:expression]`. You can also add authentication
  headers here.
- **Cooldown time** *(default `0.0`)* — seconds to wait after a group of requests
  so other purgers get fresh content (range 0.0–3.0).
- **Maximum requests** *(default `100`)* — the most HTTP requests this purger will
  make in a single Drupal execution (range 1–50000).
- **Runtime measurement** *(default on)* — when on, Purge measures how long
  requests take and auto‑tunes throughput. When off, capacity is fixed at
  connect timeout + timeout.
- **Timeout** *(default `1.0`)* — the overall request timeout in seconds
  (0.1–8.0; used when runtime measurement is off).
- **Connection timeout** *(default `1.0`)* — how long to wait to connect, in
  seconds (0.1–4.0).
- **HTTP errors** *(default on)* — when on, `4xx`/`5xx` responses count as failed
  invalidations. Turn it off if your Varnish returns a non‑2xx status on a
  successful purge.

One validation rule to know: **connection timeout + timeout** must add up to
between **0.4 and 10.0** seconds, or the form won't save.

There is no default install configuration — a purger settings entity is created
only when you add a purger, and its ID gets a random suffix (for example
`varnish_purger.settings.a1b2c3`).

## Check the diagnostic

After saving, run `drush p:diagnostics` (or look at Purge's UI). The **Varnish**
check will report an **error** if any of *name*, *hostname*, *port*, *request
method*, or *scheme* is empty, and a **warning** if your scheme and port don't
match (https on a port other than 443, or http on 443). Otherwise it reports OK.

## Zero‑config purger via settings.php

The `varnish_zeroconfig_purger` needs no form. Instead it reads your Varnish
server addresses from Drupal core's `$settings['reverse_proxy_addresses']` (IP
strings — ports are not read from there). It handles `url`, `wildcardurl`, `tag`,
and `everything` all at once, and is meant to be used with the module's shipped
`zeroconfig.vcl` (written for Varnish 4). Copy and adapt that VCL into your
Varnish configuration; it accepts `PURGE` (single URL), `BAN` (a pipe‑separated
`Cache-Tags` header), and wildcard‑URL bans.
