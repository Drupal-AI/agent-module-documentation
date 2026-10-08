# Instagram Nodes — manual setup guide

**Instagram Nodes** (`instagram_nodes`) imports your Instagram posts into Drupal
as native content. It creates an **`instagram_post` content type** and stores each
imported post as a node with its caption, post ID, image (or video thumbnail),
timestamp, and the original Instagram URL. Because the posts become ordinary
Drupal nodes, you can then display them in a View or a custom block just like any
other content.

The big advantage of importing into content — rather than fetching live on every
page view — is resilience and fewer API calls. Posts are imported during cron (or
manually from the configuration form), so a page that shows them reads from your
database instead of hitting Instagram on each request, which avoids the rate
limiting and request blocking that live feeds can run into. The module can email
you when the access token expires and automatically purge older posts beyond a
limit you set. It provides its own permission and supports Drupal 10.2 and 11.

> **Platform and credentials caveats.** The module needs an Instagram API access
> token, which you generate by adding an Instagram test user (see Meta's
> documentation for creating an app with Instagram login). Note Meta's own
> warning: from December 4, 2024, requests to the Instagram **Basic Display API**
> return errors, so verify your app is on a currently supported Instagram API path
> before relying on this. The access token is a **secret** that expires — store it
> securely (an environment variable on this project's convention), and use the
> module's expiry-email option so you find out before the import quietly stops.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add your access token and set the
   import options.

## Where it lives in the admin menu

The module provides a configuration form at `/instagram-nodes-configuration`,
where you enter the access token and control how imports run. Access is gated by
the module's own permission. See [Configuration](configuration/index.md).

## How to use it

Once configured, posts import automatically on cron (and on save, if you enable
that option) or you can trigger an import manually from the configuration form.
The imported `instagram_post` nodes can then be surfaced anywhere — most commonly
through a View that lists them or a block on the homepage.
