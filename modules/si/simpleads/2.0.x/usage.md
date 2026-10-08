<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SimpleAds is an advertisement manager. It models ads, ad groups, and campaigns as three content entities; serves a group of ads through a block, a `<simpleads>` CKEditor/text-filter tag, a Views style, or a hand-picked reference field, with loop/random rotation and optional modal display; and tracks impressions and clicks via anonymous REST beacons fired by its JS. Cron aggregates raw hits into per-day statistics (tables and Chart.js graphs) and expires ads when a campaign's click, impression, or date limit is reached.

---

SimpleAds lets a site run house ads without an external ad server. Ads are `simpleads` entities of type image, responsive image (separate desktop/tablet/mobile images with configurable media queries), or HTML5 (a ZIP whose index.html is shown in an iframe), each with a click-through URL. Ads belong to a `simpleads_group`, and a block/filter/view/reference-field displays one group with a chosen rotation and optional modal. A `simpleads_campaign` can cap an ad by number of clicks, number of impressions, and/or a date range, automatically deactivating the ad when the limit is met. Impressions and clicks are recorded through the `rest` module: the front-end JS GETs ad markup and POSTs click/impression beacons (default-open to anonymous, gated by `count simpleads clicks/impressions`), stored raw and rolled up daily by cron into unique/total counts and CTR that admins view as tables or charts on each ad's Statistics tab. Settings cover the ad and statistics view modes, the responsive media queries, and the stats date format; a full per-entity permission set controls who can create, edit, delete, and view ads, groups, and campaigns.

---

- Run house or sponsor ads on a Drupal site without a third-party ad server.
- Model ads, ad groups, and campaigns as first-class content entities.
- Place a rotating ad block in any region via the block layout.
- Insert an ad group into body content with the `<simpleads>` CKEditor 5 button.
- Serve image banner ads with a click-through URL.
- Serve responsive ads with distinct desktop, tablet, and mobile images.
- Upload an HTML5 ZIP creative and display it in an iframe.
- Rotate ads in a loop carousel, show N random ads, or one random per page load.
- Pop ads in a modal after a delay or a number of page visits.
- Hand-pick specific ads on a node with a `simpleads_reference` field.
- Show ads selected by a Views display using the SimpleAds view style.
- Target ads to the current node by matching two reference fields.
- Cap a campaign by number of clicks and auto-disable its ads when reached.
- Cap a campaign by number of impressions.
- Schedule a campaign or ad by start and end date.
- Track ad impressions per ad, including unique-by-IP counts.
- Track ad clicks per ad and compute click-through rate.
- View per-ad statistics as Chart.js graphs (all-time, 30-day, week, today).
- Export/review ad performance in a statistics data table.
- Aggregate daily statistics automatically on cron.
- Restrict who may create, edit, or delete ads, groups, and campaigns.
- Allow or deny anonymous click/impression counting per role.
- Group ads for organized rotation and reporting.
- Publish and unpublish ads, or temporarily disable one with a kill switch.
- Extend ad and campaign types through alter hooks.
- Filter ads to the active domain when Domain Access is installed.
