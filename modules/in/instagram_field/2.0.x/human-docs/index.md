# Instagram Field — manual setup guide

**Instagram Field** (`instagram_field`) provides a field that displays your recent
Instagram posts on an entity — so you can show a user's or account's latest
Instagram content directly on a node, paragraph, or other fieldable entity. It
uses the **Instagram Basic Display API**, refreshes when its cache timeout is
reached, and **caches images and links on your own server** so the display
doesn't hammer Instagram on every page view.

You connect it once by registering a Facebook/Instagram app, entering its
credentials on the module's settings form, and authenticating to obtain an access
token. After that, add the Instagram field to a content type and it renders the
recent posts. It depends on core **Field**, provides its own permission, and lives
in the Field Types package. It supports Drupal 10 and 11.

> **Platform caveat — check this before you rely on it.** This module integrates
> with Instagram's **Basic Display API**, which Meta has been winding down (all
> requests to it began returning errors from December 2024). Before adopting the
> module on a new site, verify that the API path it uses is still functioning for
> your account, since a feed that depends on a retired endpoint will simply stop
> working. The access token it obtains is a **secret** and, like all such tokens,
> is long-lived but finite — it expires and needs refreshing, so a feed that works
> at launch can go quiet later.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — register an app, enter its
   credentials, and authenticate to get an access token.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Instagram Field**
(under **Administration → Configuration → Services**). Access is gated by the
module's own permission. See [Configuration](configuration/index.md).
