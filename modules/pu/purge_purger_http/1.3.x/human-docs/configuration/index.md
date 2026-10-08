# Configuration

Generic HTTP Purger has no settings page of its own. You configure it by adding a
**purger** through the Purge UI and then filling in every part of the HTTP request
it should send. This page walks through both.

## Add a purger

1. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
2. Under **Purgers**, click **Add purger**.
3. Choose one of the two types this module provides:
   - **HTTP purger** — sends one request per invalidation (for example, one request
     per changed URL or tag).
   - **Bundled HTTP purger** — sends a single request for a whole batch of
     invalidations at once.
4. The new purger appears in the list. Click it (or its settings link) to open this
   module's configuration form.

You can add several purgers — they are multi‑instance — for example one for Varnish
and one for a CDN.

## The request settings

Each purger's form controls exactly what request gets sent. The fields, with their
defaults:

### What to invalidate

- **Invalidation type** *(default tag)* — which kind of invalidation this purger
  handles: `tag`, `path`, `url`, `wildcardpath`, `everything`, and so on. It must
  match how your cache expects to be told what to clear.

### Where to send it

- **Hostname** *(default `localhost`)* — the host or IP of the cache/proxy.
- **Port** *(default 80)* — the port to connect to.
- **Path** *(default `/`)* — the request path. This is **token‑aware**, so it can
  vary per invalidation (see Tokens below).
- **Scheme** *(default `http`)* — `http` or `https`.
- **Verify TLS certificate** *(on by default)* — only applied when the scheme is
  `https`. Turn it off only for a self‑signed staging proxy.
- **Request method** *(default `BAN`)* — the HTTP method, such as `BAN`, `PURGE`,
  `DELETE`, `GET`, or `POST`, to match your proxy's API.

### Headers and body

- **Headers** — a list of outbound headers (field and value). The values are
  token‑aware, so you can, for example, put the cache tag being cleared into an
  `X-Cache-Tags` header, or add an API‑key header for authentication.
- **Body** — an optional request body, also token‑aware. When set, the purger sends
  a matching content‑type header.
- **Body content type** *(default `text/plain`)* — the content type used when a body
  is present, for example `application/json` for a CDN's JSON purge API.

### Performance and reliability

- **Runtime measurement** *(on by default)* — dynamically measures how much the
  purger can do; turn it off to derive capacity from the timeouts instead.
- **Timeout** *(default 1.0s)* and **Connection timeout** *(default 1.0s)* — request
  and connection time limits, in seconds. Raise them for a slow or remote proxy.
- **Cooldown time** *(default 0.0s)* — seconds to wait after invalidations so the
  cache can settle before the next batch.
- **Maximum requests** *(default 100)* — the most HTTP requests this purger makes in
  a single Drupal run, so a CLI purge cannot hammer the proxy indefinitely.
- **Treat HTTP errors as failures** *(on by default)* — treat 4xx/5xx responses as
  failed purges (so they can be retried) rather than silent successes.

Save the form when done.

## Tokens

Because the path, header values, and body are token‑aware, you can template them per
invalidation. The available token group depends on the purger type:

- The **HTTP purger** exposes the **`invalidation`** group — a single item is being
  processed, so `[invalidation:expression]` is the one tag, path, or URL being
  cleared.
- The **Bundled HTTP purger** exposes the **`invalidations`** group — the whole set,
  so you can embed a token listing every item in one request body.

Common patterns:

- **Tag BAN on Varnish** — an `X-Cache-Tags` header set to `[invalidation:expression]`
  with method `BAN`.
- **Per‑URL PURGE on nginx** — the path set to `[invalidation:expression]`, method
  `PURGE`, invalidation type `url` or `path`.
- **Bundled CDN call** — method `POST`, body content type `application/json`, and a
  JSON body embedding an `[invalidations:…]` token, sent once per batch.

## Check your configuration

Purge's status page includes an **HTTP configuration** diagnostic check that this
module provides. It flags an enabled purger that is missing a required field (name,
hostname, port, request method, or scheme), and warns when `https` is not on port
443 (or `http` is on 443). Check it after configuring to confirm the purger is
valid.
