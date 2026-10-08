<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Propagates Search API 'exclude from search' flags from media entities to the nodes that reference them, via entity hooks and a queue.

---

Media Node Search Exclusion automatically propagates the Search API "exclude from search" flag from media entities to the nodes that reference them, so hiding a media item from search also hides the pages built around it.

Entity hooks (`EntityHooks`) react to media and node saves and resolve, per configured rules, whether a referencing node should be excluded; the work can run inline or be deferred to a queue (`QueueManager`) for large reference sets. A `SettingsManager` reads the exclusion field name, allowed media bundles and debug flag; resolver services (`MediaExclusionResolver`, `NodeMediaExclusionResolver`, a customizable `DefaultCustomNodeExclusionRule`) compute the propagation, and `NodeExclusionUpdater` writes the node's exclusion field. The settings form at `/admin/config/search/media-node-search-exclusion` (permission `administer site configuration`) configures fields, bundles, queue use and debug logging, with an integrated Tour. A JS-backed status endpoint `POST /media-node-search-exclusion/statuses` (permission `access content`) returns, for a list of requested media IDs, each item's label, bundle and current exclusion boolean — used by the node/media edit forms to show live status. A tour-seen endpoint records per-user tour dismissal.

Note: the statuses endpoint is gated only by `access content` (effectively broad/anonymous on many sites) and returns media labels + exclusion state for any requested media IDs; it is read-only and does not mutate, but it does expose media labels to low-privilege users. Typical setup: enable the module, pick the media exclusion field and allowed bundles on the settings form, choose inline vs queue processing, then re-save media to propagate.
---
- Hide referencing nodes when a media item is excluded from search.
- Choose which field marks media as search-excluded.
- Limit propagation to specific media bundles.
- Process propagation inline for small sites.
- Defer propagation to a queue for large reference sets.
- Show live exclusion status on node edit forms.
- Show live exclusion status on media edit forms.
- Enable debug logging to trace propagation decisions.
- Customize the node exclusion rule via a service.
- Reset the on-boarding tour for users.
- Configure allowed media bundles centrally.
- Keep Search API indexes free of media-hidden pages.
- Batch-update nodes after changing exclusion settings.
- Integrate with search_api_exclude_entity fields.
- Provide an admin settings page for the whole workflow.
