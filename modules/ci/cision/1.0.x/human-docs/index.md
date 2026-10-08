# Cision — manual setup guide

**Cision** (`cision`) integrates the
[Cision](https://www.cision.com) Next Generation Communications Cloud API into
Drupal. It provides a service that talks to Cision's Total Mentions, Searches and
Stats APIs, and a block that displays the total mentions for a given Cision search
over a chosen time period. In short, it brings your Cision PR and media-monitoring
data onto your Drupal site.

Use it when you want to surface Cision press coverage or mention counts on a page —
for example a communications or newsroom section that shows how often the
organisation is being mentioned. The module can also pull press releases / news
items in as content and media, caching any external images locally through the
Imagecache External module.

Because it calls an external service, it correctly stores the Cision API
**username and password as [Key](https://www.drupal.org/project/key) entities**
rather than in plain configuration — a good security practice. Be aware that the
module makes outbound requests to Cision's API (egress) and fetches remote images
from Cision's servers, so make sure that traffic is acceptable in your environment
and that responses are cached sensibly. This module is minimally maintained and is
not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   its dependencies, then configure the API keys and block.

## Where it lives in the admin menu

Cision has no settings form of its own. Its configuration lives in two familiar
places:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — where you
  create the `cision_username` and `cision_password` keys that hold your Cision
  API credentials.
- **Structure → Block layout** (or Layout Builder) — where you place the Cision
  block that displays total mentions for a search.

## How to use it

After enabling the module (see [Installation](installation/index.md)):

1. Create a Key named **`cision_username`** at
   `/admin/config/system/keys/manage/cision_username` and set it to your Cision
   API username.
2. Create a Key named **`cision_password`** at
   `/admin/config/system/keys/manage/cision_password` and set it to your Cision
   API password. Storing these as Keys (ideally backed by an environment variable)
   keeps the credentials out of exported configuration.
3. Place the **Cision** block via **Structure → Block layout** or Layout Builder,
   then configure it with the Cision search and time period you want to report on.
