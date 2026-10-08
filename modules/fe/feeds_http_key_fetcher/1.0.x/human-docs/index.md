# Feeds HTTP Key Fetcher — manual setup guide

**Feeds HTTP Key Fetcher** (`feeds_http_key_fetcher`) adds a fetcher to the
[Feeds](https://www.drupal.org/project/feeds) module that includes an
**authentication key** (an API key / auth header) when it fetches a remote feed
over HTTP. If the endpoint you want to import from (JSON or XML) requires an
`X‑API‑Key`‑style header to return a successful response, the plain HTTP fetcher
can't reach it — this one can.

Based on the Feeds HTTP Auth Fetcher, it provides a new fetcher type,
**Download From URL with X API Key**. You choose it on a feed type, then enter the
endpoint URL and the key on the feed itself. On import the fetcher sends the key in
the request header so the endpoint accepts the GET.

The key is entered per feed and stored with that feed's Feeds configuration. There
is no site-wide settings page and no separate key store — you type the value into
the **Authorization X API Key** field on each feed. Requests use Drupal's built-in
HTTP client.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

There is **no separate settings page** for this module. The fetcher is chosen on a
feed type and the URL/key are entered per feed, described in "How to use it" below.

## Where it lives in the admin menu

The fetcher becomes available when you create or edit a feed type at **Structure →
Feed types**. The endpoint URL and key are entered on individual feeds at
**Content → Feeds**.

## How to use it

1. Create or edit a feed type at **Structure → Feed types** and choose **Download
   From URL with X API Key** as the **Fetcher**.
2. Choose a parser (JSON/XML) and configure the mapping as usual.
3. Add a feed at **Content → Feeds** for that type. Enter the endpoint URL, then
   enter the **X API Key** value for the header below the URL.
4. Run the import. The fetcher issues the GET request with your key header and
   hands the response to the parser.
