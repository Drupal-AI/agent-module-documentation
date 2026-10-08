# ActivityPub — manual setup guide

**ActivityPub** (`activitypub`) connects a Drupal site to the **Fediverse** — the
network of servers (Mastodon and many others) that talk to each other using the
open **ActivityPub** protocol. With it enabled, your site can publish activities
out to other servers and receive activities from them: it implements actors,
inboxes and outboxes, followers, and a reader/timeline of federated content.

It is a substantial integration. It depends on core's **Image** module, ships
several submodules (an API layer, comment federation, a Mastodon-compatible API,
a reader/timeline, and a scheduler), provides Drush commands and its own
permissions, and is configured at a central settings page. It runs on Drupal 10
and 11.

**Please read this before deploying — security caveat for this alpha
(1.0.0-alpha26).** ActivityPub servers normally prove that an incoming activity
really came from the actor it claims to be from, using HTTP signatures. In this
alpha that inbound signature verification is **incomplete**: when signature
verification fails — including when a signature is missing or invalid — the inbox
still publishes "timeline"-type activities **if the claimed actor is followed by
any local user**. The module's own settings screen says as much. The practical
consequence is that someone can post unsigned or forged activities to your
inbox, impersonating an actor your site follows, and have them appear on the
local timeline as if genuine (content spoofing / impersonation / malicious-link
injection). Until upstream requires a valid signature, treat incoming federated
timeline content as **not authenticated**: don't present it as verified, keep the
module updated, and lean on the "require follow" and blocked-domains settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — set up actors and the federation
   settings, and understand the security options.

## Where it lives in the admin menu

The module's settings are at the **ActivityPub settings** page
(route `activitypub.settings`). From there you configure your site's actors and
the federation behaviour. It also provides Drush commands for operational tasks.
