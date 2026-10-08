Replaces an empty Advertising entity ad slot with an alternative (fallback) Advertising entity chosen per entity.

---

Advertising Entity: Fallback is a submodule of the ad_entity project. It adds a per-entity "Fallback" setting to every Advertising entity form: you pick another existing Advertising entity to serve as the fallback for the current one. At display time the module clones the fallback entity, renders both the original and the fallback container into the page (correlated by a random `data-fallback-container` / `data-fallback-container-for` attribute pair), and disables automatic initialization on the fallback. A JavaScript handler (`js/fallback.view.js`) waits a configurable timeout after ad containers are collected; if the original slot has not reported that it is initialized and in-scope, the handler enables and initializes the fallback container instead. A single global "Timeout" setting (microseconds, minimum 100, default 1000) controls how long to wait before the swap. The module hooks `hook_ad_entity_view_alter()`, alters both the Advertising entity form and the global settings form, and stores its data in the entity's third-party settings plus a `fallback` key on `ad_entity.settings`.

---

- Show a house/self-promo ad automatically when a paid ad slot returns empty.
- Guarantee no blank ad space on a page by pairing every revenue slot with a fallback.
- Fill unsold inventory with a default banner without changing the block placement.
- Fall back from a third-party network ad to a generic/DFP ad when the network has no fill.
- Configure the fallback per Advertising entity from its own edit form, no code required.
- Chain a premium ad to a lower-priority ad as a graceful degradation strategy.
- Use one Advertising entity as the fallback target for a specific breakpoint entity.
- Tune how long to wait for the original ad before swapping via the global Timeout setting.
- Keep targeting context on the original slot while the fallback carries its own configuration.
- Serve a promotional message in ad slots on pages where the ad network is disabled or blocked.
- Provide a branded placeholder when an ad is blocked or fails to load client-side.
- Reduce layout shift by reserving the slot and only late-loading the fallback if needed.
- Set a longer timeout for slow-loading networks so real ads get a chance before fallback.
- Set a short timeout when you prefer to fill empty slots quickly.
- Attach the fallback swap behavior globally without editing individual ad templates.
- Maintain fallback pairs entirely through configuration that is exportable with the site config.
- Remove a fallback simply by clearing the select on the entity form (empty value = no fallback).
- Avoid double-initialization: the module marks the original as processed so it is not re-run.
- Use it with the ad_entity_generic submodule to fall back to a custom/generic ad implementation.
- Test empty-slot handling in a staging environment by pointing a slot at a known-empty ad.
