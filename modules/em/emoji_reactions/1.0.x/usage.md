<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Emoji Reactions lets visitors and editors react to any fieldable Drupal entity with configurable emoji, toggled over AJAX, with live counts, a reaction log, analytics, a REST API and Views integration.

---

Emoji Reactions provides an `emoji_reaction` field type that you attach to any content type, comment type, taxonomy vocabulary, user, paragraph or other fieldable entity through the standard Manage Fields UI. Once attached, a reaction widget appears in the entity display; users click an emoji to add, remove or change their reaction and the counts update without a page reload. The available emoji are `emoji_reaction` configuration entities (six ship by default — thumbs up, heart, celebrate, sad, wow and angry) that can each be a Unicode character, an image URL or raw SVG, and be reordered, enabled/disabled and given accessibility labels. Presentation is chosen per view-mode on the field formatter (23 layouts, from plain pills to Facebook/Reddit/Slack-style bars) or via the Emoji Reactions block. Behind the widget, reactions are stored in dedicated database tables with per-emoji aggregated counts, every event is written to a reaction log with browser/OS/device/masked-IP analytics, and admins get a filterable log, per-entity and site-wide statistics reports, Drush commands, a REST API for decoupled front-ends, and a set of hooks for custom integrations. It depends only on core User, Field, Serialization and REST.

---

- Add a "like / love / celebrate" reaction bar to blog posts or news articles.
- Let readers react to comments to surface the most-appreciated replies.
- Collect quick sentiment feedback on knowledge-base or documentation pages.
- Add emoji reactions to taxonomy term pages (e.g. topic hubs).
- Let members react to each other's user profiles on a community site.
- Add reactions to paragraphs so individual sections of a page can be reacted to.
- Show a compact reaction row on teasers and a full animated bar on the full page view of the same content.
- Configure a Facebook-, Reddit-, Slack-, Discord- or Instagram-styled reaction layout per view-mode.
- Allow anonymous visitors to react, deduplicated by IP and/or session with a configurable expiry window.
- Restrict which of the enabled emoji appear on a specific field/view-mode.
- Let users hold a single reaction per item, or allow multiple reactions simultaneously.
- Allow users to swap their reaction to a different emoji instead of removing it first.
- Throttle reaction spam with a configurable per-hour flood limit.
- Poll the server periodically so counts stay current across open browser tabs.
- Build a "Most reacted content" block or report with Views using the reaction relationships.
- Build a "Recent reactions" admin view filtered by browser, OS or device type.
- Build a view of the content the current user has reacted to.
- Review a filterable, sortable admin reaction log and drill into any single reaction's detail.
- Bulk-delete selected, filter-matched, or all reactions from the admin log.
- View per-entity statistics (reaction breakdown for one item) and site-wide engagement reports.
- Power a decoupled React/Vue front-end via the REST submit/toggle and entity-data endpoints.
- Award points or send notifications when a reaction is added, using the react_alter hook.
- Attach extra data (referrer, campaign id) to each logged reaction via the log-fields/log-insert hooks.
- Rebuild the aggregated counts cache or wipe an entity's reactions from the command line with Drush.
- Add a brand-new custom emoji (Unicode, image or SVG) through the Manage Emojis admin screen.
- Expose reaction counts as a live JSON feed for lightweight client-side widgets.
