# Feeds Fetcher POST — manual setup guide

**Feeds Fetcher POST** (`feeds_fetcher_post`) adds a fetcher to the
[Feeds](https://www.drupal.org/project/feeds) module that retrieves its source
with an HTTP **POST** request instead of a GET. It lets Feeds reach endpoints that
the standard GET‑based fetchers simply can't.

Feeds normally assumes a source is something you fetch with a GET — an RSS feed, a
CSV at a URL, a JSON endpoint. Plenty of real endpoints aren't like that: an API
that expects a query in the request **body**, a SOAP service, an endpoint whose
search specification is too long or too structured for a query string, or a
reporting service that expects a POST describing what to return. This fetcher
supplies that general case, so you can send custom headers and POST parameters and
then parse the response like any other feed. The body and form parameters follow
Guzzle's request options (`body` and `form_params`).

Three things are worth planning before you rely on it:

1. **The request body often contains credentials or a query.** Whatever you
   configure is stored in the feed type's configuration and exported with it — so
   an API key placed directly in a POST body can end up in version control. Prefer
   a token reference resolved at request time over a literal secret.
2. **POST is not idempotent by convention.** A fetcher that retries — on a
   timeout, a queue re‑run, or a cron overlap — may cause the far end to act
   twice. That's harmless for a read‑only reporting endpoint, but not for anything
   that records a request.
3. **The response is untrusted input to a parser**, exactly as with a GET source.
   A feed that trusts what it receives is trusting whoever controls the endpoint —
   which matters most when that's a partner rather than your own organisation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

There is **no separate settings page** for this module. The fetcher is selected on
a feed type, and the headers and POST parameters are entered per feed, described in
"How to use it" below.

## Where it lives in the admin menu

The fetcher becomes available when you create or edit a feed type at **Structure →
Feed types**. Headers and POST parameters are entered on individual feeds at
**Content → Feeds**.

## How to use it

1. Edit a feed type at **Structure → Feed types** and choose **Download From URL
   additional POST parameters** as the **Fetcher**.
2. Choose a parser (JSON/XML, etc.) and configure the mapping as usual.
3. Add a feed at **Content → Feeds** for that type. Enter the download URL, then
   add the **header** values and **POST parameters** the endpoint expects.
4. Run the import. The fetcher issues a POST request with your headers and body,
   and hands the response to the parser.
