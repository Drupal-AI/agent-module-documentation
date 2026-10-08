# Feeds HTTP OAuth Fetcher — manual setup guide

**Feeds HTTP OAuth Fetcher** (`feeds_http_oauth`) adds an **OAuth 2.0‑enabled HTTP
fetcher** to the [Feeds](https://www.drupal.org/project/feeds) module (Feeds 3.x),
so a feed can import data from an API that requires OAuth 2.0 authentication. It
obtains an access token from the token endpoint and sends it with each request —
letting Feeds reach protected endpoints on a schedule.

It's deliberately a **thin extension** of Feeds' core HTTP fetcher: it reuses the
core fetcher's configuration and behaviour (caching, conditional requests,
timeouts, always‑download), and only injects the OAuth token at request time. It
does **not** patch or modify Feeds core, and it does not add OAuth options to the
existing fetchers — it's a separate fetcher plugin called **Download from url
(OAuth 2.0)**. OAuth settings are kept **per feed**, not per feed type. Currently
it supports the **client_credentials** and **password** grant types (token refresh
caching is not implemented yet).

Credentials are stored through the **Key** module rather than in plaintext
configuration. You create Key values for the client ID and client secret and then
select them on the feed, alongside the token URL, grant type, and where to send the
client credentials (body or header).

> **Handle credentials carefully.** Store the OAuth client ID and secret (and any
> token) as Keys backed by an environment or secure provider — never in plaintext
> config. Fetched data becomes site content, so treat it as external input.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds and Key.

There is **no separate settings page** for this module. The fetcher is chosen on a
feed type and its OAuth settings are entered per feed, described in "How to use it"
below.

## Where it lives in the admin menu

The fetcher becomes available when you create or edit a feed type at **Structure →
Feed types**. OAuth settings and Key selections are entered on individual feeds at
**Content → Feeds**; the Key values themselves are managed under the Key module at
**Configuration → System → Keys**.

## How to use it

1. Create Key values for the OAuth **client ID** and **client secret** (see
   [Installation](installation/index.md) for secure‑storage guidance).
2. Create or edit a feed type at **Structure → Feed types** and choose **Download
   from url (OAuth 2.0)** as the **Fetcher**. Configure the standard HTTP fetcher
   options (request timeout, always download, and optionally auto‑detect feeds /
   PubSubHubbub) as needed.
3. Add a feed at **Content → Feeds** for that type. Enter the **source URL** (the
   protected API endpoint), then the OAuth settings: **access token URL**, **grant
   type**, where to **send the client ID and secret** (body or header), the
   **client ID** and **client secret** (selected from your Keys), an optional
   **scope**, and — for the password grant only — a **username** and **password**.
4. Run the feed. It requests an access token from the token endpoint, adds it to
   the HTTP request, and then fetches and processes as usual. If token acquisition
   fails, the feed fails gracefully.
