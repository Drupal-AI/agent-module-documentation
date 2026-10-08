# PhotoPrism Integration — manual setup guide

**PhotoPrism Integration** (`photoprism_integration`) connects Drupal to
[PhotoPrism](https://www.photoprism.app/), the AI‑powered photo‑management server,
through its REST API. At its heart is a reusable PHP **client service** that wraps
the PhotoPrism API — albums, photos, labels, people, places, folders, moments and
calendar — so developers can build custom integrations (a block, a media‑library
sync, a gallery) without writing API plumbing themselves.

It is primarily a **developer's toolkit** rather than a turnkey feature. Alongside
the service it ships a small admin UI: a settings form where you enter your
PhotoPrism server URL and access token (with an AJAX **Test Connection** button),
and a basic album browser that lists albums and their photos to demonstrate what the
service can do.

You connect it to a running PhotoPrism instance using the server's URL and an access
token (or app password). It depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is a small settings form (covered under "How to use it" below) but no complex
configuration section — the module is mostly a service for developers to build on.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → PhotoPrism Integration**
(`/admin/config/media/photoprism`), behind the *Administer site configuration*
permission. The demo album browser lives at
`/admin/config/media/photoprism/albums`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In PhotoPrism, create an **access token** or **app password** for Drupal to use.
3. Go to **Configuration → Media → PhotoPrism Integration** and enter:
   - **Server URL** — the address of your PhotoPrism server, e.g.
     `http://photoprism.local:2342`. If Drupal and PhotoPrism run in separate
     Docker/DDEV containers, use the internal hostname the container can reach (for
     example `http://host.docker.internal:2342`), not `localhost`.
   - **Access token** (or app password) — the credential from the previous step.
4. Click **Test Connection** to confirm Drupal can reach the server, then save.
5. Browse albums from the admin album pages, or inject the
   `photoprism_integration.client` service into your own controllers, blocks or
   forms to build a custom integration.

> **Keep the access token protected.** The token is stored in the module's
> configuration, which means it can end up in exported config. Restrict who holds
> the *Administer site configuration* permission, and be careful about where your
> configuration export is stored.
