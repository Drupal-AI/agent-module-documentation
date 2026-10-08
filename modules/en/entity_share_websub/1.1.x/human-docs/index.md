# Entity Share Websub — manual setup guide

**Entity Share Websub** (`entity_share_websub`) adds **automatic, push-based
content updates** to the Entity Share module, using a variation of the WebSub
(PubSubHubbub) protocol. Entity Share on its own lets one Drupal site publish
channels of content over JSON:API that another site can *pull* on demand. This
project adds the missing half: a subscriber site registers interest in specific
content, and the publisher notifies it the moment that content changes — so
imports happen automatically instead of waiting for a manual sync or a scheduled
pull.

The project is organised as three modules working together:

- **`entity_share_websub`** (this base module) is a thin shim. It has no settings,
  no routes and no permissions of its own — its only job is to provide a shared
  signature helper that both roles use to sign and verify the `X-Hub-Signature`
  header on every hub-to-subscriber call. You always enable it alongside one or
  both of the submodules below.
- **`entity_share_websub_hub`** turns a site into a publishing **hub**: it exposes
  a subscribe endpoint, tracks subscriptions, and pushes update/cancel
  notifications to subscribers through a queue.
- **`entity_share_websub_subscriber`** turns a site into a **subscriber**: it adds
  Subscribe/Unsubscribe buttons to the Entity Share pull form, exposes the
  callback routes the hub calls, and imports content automatically when notified.

A single site can play both roles (subscribing from upstream and publishing
downstream), which lets you build hub-and-spoke content networks — a central
newsroom pushing to regional sites, a parent organisation syndicating to affiliate
sites, and so on.

This base module itself has nothing to configure. The subscriber submodule is the
piece with a settings form; see its own documentation. This page and
[Installation](installation/index.md) cover what the base module is and how to
install the pieces.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the project with Composer and
   enable the base module plus whichever role(s) each site plays.

## Where it lives in the admin menu

The base module adds no admin pages. Configuration and controls live in the
submodules: the subscriber submodule adds a settings form and the
Subscribe/Unsubscribe buttons on the Entity Share pull form, and the hub exposes
the subscription endpoint. See each submodule's own docs.

## How to use it

1. Set up **Entity Share** first, with its channels configured, on the sites
   involved.
2. On every participating site, enable this base module.
3. On the publishing site, also enable **`entity_share_websub_hub`**. On a
   consuming site, also enable **`entity_share_websub_subscriber`**. A site that
   does both enables both.
4. On a subscriber, use the Subscribe buttons on the Entity Share pull form to
   register interest in content; from then on updates are pushed automatically.
