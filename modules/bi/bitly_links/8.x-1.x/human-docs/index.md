# Bitly Links — manual setup guide

**Bitly Links** (`bitly_links`) creates Bitly short URLs for your nodes by
calling the Bitly v4 API. Before it can shorten anything, an administrator
authorizes the site's Bitly application through Bitly's OAuth flow; from then on
the module holds an access token it uses to talk to Bitly on the site's behalf.

You would reach for this module when you want short, shareable links attached to
your content — for example to drop into social posts. It is a focused, one-purpose
Bitly integration: it adds a small set of admin pages for authorizing the app,
checking the current token, and testing that shortening works, and it makes its
API calls to `https://api-ssl.bitly.com` over HTTPS with Guzzle's default TLS
verification.

Every page the module adds sits behind Drupal's **Access administration pages**
permission, so nothing here is exposed to anonymous visitors. Your Bitly OAuth
client ID, client secret, and access token are stored in Drupal's `State` system,
which keeps them out of your exported site configuration — treat all three as
secrets and do not paste them into committed config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register a Bitly app, run the OAuth
   authorization flow, and test that shortening works.

## Where it lives in the admin menu

The module groups its pages under `/admin/bitly_links`. From there you can
authorize the Bitly app (`/admin/bitly_links/authorize`), check the current
token's status, and run a shorten test (`/admin/bitly_links/shorten_test`). All of
these require the **Access administration pages** permission.
