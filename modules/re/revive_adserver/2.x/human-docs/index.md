# Revive Adserver — manual setup guide

**Revive Adserver** (`revive_adserver`) connects your Drupal site to a
[Revive Adserver](https://www.revive-adserver.com/) instance — the popular
self-hosted, open-source ad server — and renders its ad **zones** on your pages.
Instead of hand-pasting Revive invocation tags into templates, you place ads
through Drupal's own tools: a **block** plugin and a **field** you can attach to
any fieldable entity.

For each placement you choose how the ad is delivered — **asynchronous
JavaScript**, an **iFrame**, or classic **JavaScript** — and, if you like, you can
let content editors pick the delivery method on a per-entity basis. The module can
also **sync the list of ad zones** directly from your Revive instance over its
API, so you select zones from a list rather than remembering numeric IDs.

Because ads are ultimately served by Revive, keep the privacy dimension in mind:
ad tags can load third-party content and track visitors, so gate ad scripts behind
cookie/tracking consent where your jurisdiction requires it. Self-hosting Revive
gives you more control over that than a third-party ad network would.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — point Drupal at your Revive instance,
   optionally sync zones over the API, and place ads via a block or a field.

## Where it lives in the admin menu

The module's settings live at **Configuration → Web services → Revive Adserver**
(`/admin/structure/services/revive-adserver`). That is where you enter your Revive
instance details and, optionally, sync the ad zones. Placing actual ads then
happens through the normal **Block layout** and **Manage fields / Manage display**
screens, as described in the [Configuration](configuration/index.md) guide.
