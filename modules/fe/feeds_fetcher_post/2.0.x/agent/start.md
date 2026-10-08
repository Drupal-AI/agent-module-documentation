<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Fetcher POST (feeds_fetcher_post) — agent index

A **Feeds** (`drupal/feeds`) fetcher plugin that downloads a source with an HTTP **POST**
instead of a GET, attaching custom headers and a POST body. Requires `feeds`.
Version **2.0.0**. Core requirement `^10 || ^11` (composer requires `drupal/feeds:^3.0`).

## What it provides

- One fetcher plugin, id **`httpfetcherpost`**, title *"Download from URL additional POST
  parameters"* — class `Drupal\feeds_fetcher_post\Feeds\Fetcher\HttpFetcherPost`, which
  **extends core's `HttpFetcher`** and overrides the protected `get()` so the request is
  issued with `POST` (`$this->client->requestAsync('POST', $url, $options)->wait()`).
- No permissions, no routes, no services, no Drush, no submodules, no admin config page of its
  own. It only registers the plugin; everything is configured through the Feeds UI.
- Config schema `feeds.fetcher.httpfetcherpost` (adds `headers`, `post_parameter`,
  `post_variant` on top of core's HTTP fetcher settings).

## The mechanism (from source)

- **Fetcher-level settings** reuse core's `HttpFetcherForm` unchanged (`request_timeout`,
  `auto_detect_feeds`, `always_download`, PubSubHubbub options).
- **Feed-level settings** come from `HttpFetcherPostFeedForm` (extends core
  `HttpFetcherFeedForm`), adding three fields saved on the **feed content entity** via
  `$feed->setConfigurationFor()`:
  - **Headers** — textarea, one `KEY: VALUE` per line, parsed by `/(.*?): (.*)/` into request
    headers.
  - **POST parameters** — textarea (the body content).
  - **POST variant** — required radios: `FORM_PARAMS` (each `KEY: VALUE` line → a form field,
    sent as `application/x-www-form-urlencoded`) or `BODY` (textarea sent verbatim as the raw
    request body, e.g. JSON/XML/SOAP). Default `FORM_PARAMS`.
- The **URL** is the feed's ordinary Feed-URL source field, inherited from core's HTTP fetcher —
  this module does not add or change it.
- `get()` also merges cached ETag / Last-Modified conditional headers (inherited caching) and,
  on a Guzzle `RequestException`, deletes the partial sink file and throws a `FetchException`.

## Setup (admin-only)

1. `drush en feeds_fetcher_post` (pulls in `feeds`).
2. Structure > Feed types > *(your type)* > **Fetcher** → select *"Download from URL additional
   POST parameters"*.
3. Content > Feeds > *(your feed)* → enter the **URL**, **Headers**, **POST parameters** and pick
   the **POST variant**; import as usual.

## Three things to plan

1. **Credentials are stored plaintext and can leak on error.** Headers and POST parameters are
   entered on the feed entity and stored unencrypted in the database; there is **no Key/token
   reference** support. A failed fetch re-throws a `FetchException` whose message contains the
   **full headers and POST body**, so an `Authorization` header or an API key in the body can
   reach on-screen messages and the log (dblog/watchdog). Prefer short-lived/low-scope
   credentials and restrict who can configure feeds and read reports.
2. **POST is not idempotent by convention.** A retry on timeout, a re-queued import or an
   overlapping cron run may make the endpoint act twice — fine for a read-only report, not for
   anything that records the request.
3. **The response is untrusted parser input**, exactly as with a GET source — you are trusting
   whoever controls the endpoint. This is inherited Feeds behaviour, not specific to POST.

## See also

- `feeds/post-fetcher.md` — configuring and using the POST fetcher, with header/body examples.
