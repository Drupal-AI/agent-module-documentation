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
  `modules/entity_share_websub_hub/1.2.x/agent/start.md`.
- **`entity_share_websub_subscriber`** — makes a site a subscriber: Subscribe/Unsubscribe
  buttons on the Entity Share pull form, callback routes, automatic import. See
  `modules/entity_share_websub_subscriber/1.2.x/agent/start.md`.

Key facts:
- Depends on `entity_share` and `views_custom_cache_tag`.
- A site can be both hub and subscriber. The subscriber is the only configurable piece
  (`configure` route lives in that submodule); this base and the hub have no settings form.
- Signatures are `sha256` over `secret . serialize($data)`, formatted `sha256=<hex>` and
  compared against the `X-Hub-Signature` HTTP header.

New in 1.2.x (submodule behaviour; the base module itself is unchanged apart from the version):
- **Hub** ships a dedicated `entity_share_websub` queue worker (`HubWorker`) that processes
  notifications one at a time with a configurable pause between items (`hub_worker_delay`,
  default 5 s), so large backlogs drain gradually. A new `process_on_terminate` setting
  (default on) lets busy hubs skip processing during `kernel.terminate` and rely on the queue
  worker / cron instead.
- **Subscriber** adds an *Unsubscribe Content* operation on imported content and hides the raw
  *Delete* action until the content is unsubscribed, keeping subscription records in sync.
- WebSub HTTP parameter reading was fixed so query-string values (`hub_topic`, `hub_mode`,
  `hub_challenge`, `hub_lease_seconds`, `remote`, `channel`) and POST body values are read from
  the correct request bag.
