<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Share Websub — agent index

Base module for a WebSub-style **push** layer on top of Entity Share. It has **no config,
no routes, no permissions, no Drush** of its own — its only code is a signature helper. The
real behaviour lives in its two submodules; enable this base plus whichever role a site plays.

- **The one thing this module provides: `SignatureTrait` (X-Hub-Signature hashing)** →
  [api/signature-trait.md](api/signature-trait.md)

Submodules (documented separately, nested under this project):
- **`entity_share_websub_hub`** — makes a site a publishing hub: `/subscribe` endpoint,
  subscription table, queued update/cancel notifications. See
  `modules/entity_share_websub_hub/1.1.x/agent/start.md`.
- **`entity_share_websub_subscriber`** — makes a site a subscriber: Subscribe/Unsubscribe
  buttons on the Entity Share pull form, callback routes, automatic import. See
  `modules/entity_share_websub_subscriber/1.1.x/agent/start.md`.

Key facts:
- Depends on `entity_share` and `views_custom_cache_tag`.
- A site can be both hub and subscriber. The subscriber is the only configurable piece
  (`configure` route lives in that submodule); this base and the hub have no settings form.
- Signatures are `sha256` over `secret . serialize($data)`, formatted `sha256=<hex>` and
  compared against the `X-Hub-Signature` HTTP header.
