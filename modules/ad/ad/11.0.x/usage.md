<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A self-hosted advertising framework: define ads, assign them to sized placements, serve them randomly through block-layout slots, and (via submodules) count impressions and clicks.

---

Advertisement (`ad`) is the base of a small ad-server ecosystem. The base module itself ships only the skeleton: a config-entity ad **placement** type (nine preset sizes such as Leaderboard 728×90 and Skyscraper), an **Advertisement slot** block plugin (`ad`) that picks a random bucket + placement and renders a placeholder, a settings form at `/admin/config/content/ad`, and two extensible plugin types — **buckets** (ad content providers, `Plugin/Ad/Bucket`) and **trackers** (statistics engines, `Plugin/Ad/Track`) — wired together by the `ad.bucket_factory` and `ad.tracker_factory` services. Out of the box the base module renders nothing useful; you enable the `ad_content` submodule to get an actual ad entity and provider, `ad_track` to record impressions/clicks, `ad_content_scheduler` to time-publish ads via the Scheduler module, and the experimental `ad_content_js` for network/JavaScript ads. The shipped release is 11.0.0-alpha12 (the version tracks Drupal core, not the module's own maturity), requires Drupal core ^11, and there is no upgrade path from the old 4.x line.

---

- Turn on self-served banner advertising on a Drupal 11 site without a third-party ad network.
- Define reusable ad **placements** by standard IAB size (billboard, leaderboard, skyscraper, rectangle, mobile leaderboard, etc.).
- Place an **Advertisement slot** block in a region and let it serve a random ad of the matching placement.
- Assign one or several buckets to a single block so it rotates ads from multiple providers.
- Hide empty ad blocks entirely when no matching ad is available (`hide_empty_blocks`).
- Add a mandatory "Advertisement" label to every ad block to satisfy ad-disclosure laws (`advertisement_indicator`).
- Manage ad content as revisionable, translatable entities with per-type permissions (via `ad_content`).
- Create image ads and text ads as separate ad content types with their own fields.
- Record total and per-event impression and click counts for sold-inventory reporting (via `ad_track`).
- Choose immediate tracking or queue/cron-deferred tracking to control write load on busy sites.
- Report click-through rate in a Views table with the `ad_track_click_through` field.
- Exempt trusted roles (editors, admins) from being counted, using the bypass-tracking permissions.
- Schedule ads to publish and unpublish automatically on set dates (via `ad_content_scheduler` + Scheduler).
- Extend the system with a custom bucket plugin that serves ads from an external network or your own store.
- Extend the system with a custom tracker plugin that pushes statistics to an external analytics service.
- Duplicate an existing placement configuration as the starting point for a new one.
- Enable or disable individual placements without deleting them.
- Restrict who may administer settings, placements, ad types, and ad content through granular permissions.
- Serve ads through an AJAX placeholder so impression tracking fires per view rather than per cache-render.
- Control whether IP address, user agent, URL, page title and referrer are stored with each tracked event (privacy tuning).
- Flush all stored tracking events from the settings form's "Clear event data" action.
- Prototype JavaScript/network-script ad units with the experimental `ad_content_js` submodule.
