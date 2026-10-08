<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Share Websub extends the Entity Share module with continuous, automatic content updates between Drupal sites, using a variation of the WebSub (PubSubHubbub) protocol. The base module itself is a shared shim: it ships the two functional submodules (Hub and Subscriber) and a signature helper they both use.

---

Entity Share already lets one Drupal site (a server) expose channels of content over JSON:API that another site (a client) can pull on demand. Entity Share Websub adds the missing "push" half: a subscriber site registers interest in specific entities, and the publisher site notifies it whenever that content changes, so imports happen automatically instead of on a manual sync. The project is split into three modules. The top-level `entity_share_websub` module is a thin base that other two depend on; its only code is `SignatureTrait`, a reusable `sha256` HMAC-style signing method used to sign and validate the `X-Hub-Signature` header on every hub↔subscriber HTTP call. `entity_share_websub_hub` turns a site into a publishing hub (it exposes a `/subscribe` endpoint, tracks subscriptions in a database table, and pushes update/cancel notifications through a queue on kernel terminate). `entity_share_websub_subscriber` turns a site into a subscriber (it adds Subscribe/Unsubscribe buttons to the Entity Share pull form, exposes verification/update/delete callback routes, and imports content when notified). You enable the base module plus whichever role a given site plays; a single site can be both.

---

- Keep an editorial "hub" site and several downstream sites automatically in sync without a scheduled cron pull.
- Push a news article to subscribing regional sites the moment it is published on the central newsroom site.
- Let a subscriber site subscribe to individual entities (by UUID) rather than importing a whole channel.
- Automatically re-import content on a subscriber whenever the source entity is updated on the publisher.
- Cancel syndication of a piece of content across all subscribers when it is unpublished or deleted on the hub.
- Provide the shared `SignatureTrait` so hub and subscriber sign every callback with a matching `X-Hub-Signature`.
- Build a content distribution network of Drupal sites that mirror a canonical source in near-real time.
- Replace a manual "Synchronize" click in Entity Share with an automated subscription-driven workflow.
- Syndicate press releases, product data, or policy pages from a parent organisation site to affiliate sites.
- Run a site that is simultaneously a subscriber (pulling from upstream) and a hub (publishing to downstream) in a chain.
- Notify subscribers asynchronously via a queue so publishing a change never blocks the editor's request.
- Verify subscription intent with a challenge/response handshake before any content is pushed.
- Protect notification endpoints with per-subscription secrets so only the real hub can trigger an import.
- Let content editors on a subscriber site opt to break a subscription before locally editing imported content.
- Standardise multi-site content governance where one team authors and many sites consume.
- Distribute taxonomy terms, media, or any fieldable entity (not just nodes) to subscribing sites.
- Reduce load and latency versus polling: subscribers are told when something changed instead of asking repeatedly.
- Provide a base dependency that both the hub and subscriber submodules build on (install it alongside either).
- Migrate an Entity Share deployment from manual pulls to event-driven pushes without changing channel config.
- Sign and validate serialized payloads consistently between publisher and subscriber using one hashing routine.
- Support a hub-and-spoke publishing model for franchises, universities, or government portals.
