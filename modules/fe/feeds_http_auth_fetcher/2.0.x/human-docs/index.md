# Feeds HTTP Authorization Fetcher — manual setup guide

**Feeds HTTP Authorization Fetcher** (`feeds_http_auth_fetcher`) fills a small but
common gap in the Feeds module. Feeds' standard "Download from URL" fetcher works
great for public feeds, but it can't send credentials — so it fails against any
API or feed that requires a bearer token or other authorization header. This
module adds one extra fetcher plugin, **Download from URL with Authorization**,
that behaves exactly like the core HTTP fetcher but also sends a configurable
`Authorization` header (and, optionally, an `Accept-Encoding` header). That lets
Feeds import from token‑protected REST endpoints, partner APIs, and private feeds
using its normal scheduling and import pipeline.

The credentials are set **per feed**, not globally, so several feeds can share one
feed type while each sends its own token. Everything else — conditional caching
(ETag / Last‑Modified), request timeout, streaming the download to a file, and
error handling — is inherited unchanged from Feeds core. The module only adds the
header; it doesn't change who can create feeds or how requests are made.

There is no settings page, no permission, and no configuration schema of its own.
You select the fetcher on a feed type and then fill in the auth fields on each
individual feed, which is why this guide covers usage here rather than in a
separate configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

## Where it lives in the admin menu

It has no page of its own. You choose the fetcher on a feed type at **Structure →
Feeds → (your feed type) → Settings → Fetcher**, and enter the credentials on each
feed's add/edit form.

## How to use it

### 1. Select the fetcher on your feed type

Go to **Structure → Feeds**, edit your feed type, open the **Fetcher** settings,
and choose **Download from URL with Authorization**. Its own settings (like the
request timeout) are the same as the standard HTTP fetcher. You can switch an
existing feed type to this fetcher without rebuilding it.

### 2. Fill in the auth fields on each feed

On each feed's add/edit form you'll now see, in addition to the **Feed URL**:

- **Authorization Header Key** — the header name. Defaults to `Authorization`, but
  you can set something like `X-Api-Key` for APIs that expect a custom header.
- **Authorization Header Token** — the credential value sent for that header.
  **Important:** the token is sent verbatim, so include any scheme yourself — enter
  `Bearer abc123`, not just `abc123`, if the endpoint expects a bearer token.
- **Accept encoding headers** — an optional `Accept-Encoding` value (for example
  `gzip` or `deflate, gzip;q=1.0`).

### 3. Import as usual

Run the import (manually or on cron). The fetcher makes the same request Feeds
normally would, but with your header attached, so authenticated sources that would
otherwise reject the request with a 401 or 403 now import successfully.

> **Security note.** The feed URL and credentials are set by whoever can create or
> edit the feed — the same trust level as Feeds' own HTTP fetcher. This module only
> adds the header; it does not widen who can trigger an outbound fetch. Treat feed
> editing as a trusted operation, since tokens are entered and stored in the feed's
> configuration.
