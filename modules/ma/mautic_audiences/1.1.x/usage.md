<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audience-based personalization that turns a visitor's Mautic segments and tags into a composable Drupal primitive for varying content.

---

Mautic Audiences resolves the segments and tags a visitor has in Mautic and exposes that "audience" through a single resolver service that every other feature consults. It reads from local stores on the render path — `user.data` for authenticated users, `keyvalue.expirable` keyed by the `mtc_id` tracking cookie for anonymous visitors — and only calls the Mautic API on webhook receipt, cron reconciliation, or a manual Drush sync, so page rendering makes zero API calls. Custom cache contexts hash on the resolved audience (segments + tags) rather than on the cookie, so two visitors in the same audience share cache entries. On top of the resolver it ships block and Layout Builder visibility conditions (Mautic segment / Mautic tag), a global Views filter, Twig functions (`is_in_segment()`, `has_tag()`, `current_audiences()`), boolean and joined-string tokens, and a small JavaScript "check, don't list" API backed by `/mautic-audiences/check` and `/mautic-audiences/me`. Identity strategy plugins map Drupal users to Mautic contacts (by email or a custom user field), an inbound webhook keeps local audience data fresh, and a cron reconciliation job plus a queue worker resync drifted users. An editorial debug page and a preview-as-audience mode help editors verify targeting. Two bundled submodules extend it: `mautic_audiences_field` adds an audience field type with an optional per-field view-access gate, and `mautic_audiences_klaro` gates resolution on Klaro consent. It requires Advanced Mautic Integration for the API client and tracking script, and runs on Drupal 10.3+ and 11.

---

- Show or hide a block by the visitor's Mautic segment membership, with any/all matching and optional negation.
- Add the same Mautic segment/tag visibility conditions to blocks placed inside Layout Builder sections.
- Reuse the conditions anywhere `ConditionInterface` plugins are honored (Paragraphs visibility, page-manager variants).
- Gate a whole View so it returns no results unless the current visitor's audience matches configured segments/tags.
- Branch a Twig template on `is_in_segment('vip')` or `has_tag('coupon:SUMMER')` without touching PHP.
- Pass an entity's audience field straight into `is_in_segment(node.field_audience)` for per-content targeting.
- Read the full resolved audience in Twig via `current_audiences()` (hash, counts, emptiness).
- Emit `[mautic-audience:in-segment-X]` / `[mautic-audience:has-tag-Y]` boolean tokens in token-aware fields.
- Insert an allowlisted `[current-user:mautic-segments]` joined-string token into a metatag pattern.
- Personalize client-side with `Drupal.mauticAudiences.hasSegment(name)` / `.hasTag(name)` returning Promises.
- Keep the page shell edge-cacheable while still varying fragments by audience via audience-shaped cache contexts.
- Map Drupal users to Mautic contacts by primary email out of the box.
- Map users to contacts through a custom user field storing a contact ID or an alternative email (SSO/shadow accounts).
- Add a site-specific identity strategy plugin without patching the module.
- Keep local audience data fresh from Mautic through the inbound webhook receiver.
- Reconcile drifted authenticated audiences automatically on cron, as a safety net for missed webhooks.
- Bulk-enqueue an audience resync for every active user with `drush mautic-audiences:sync-all`.
- Resync one user by email inline or via the queue with `drush mautic-audiences:sync-user`.
- Print a user's or contact's resolved audience from the CLI with `drush mautic-audiences:test`.
- Inspect what the resolver sees for the current viewer or an arbitrary user/email/contact on the debug report page.
- Force a fresh Mautic fetch for one lookup, and read operational counters, from the debug page.
- Preview the site as an arbitrary audience by appending `?ma_preview_segments=...&ma_preview_tags=...` to any URL.
- Add an audience field to content to record which segments/tags a piece of content is for (via the field submodule).
- Gate viewing of entities by their audience field, and follow through in Views and Search API (via the field submodule).
- Gate audience resolution on the visitor's Klaro consent state (via the Klaro submodule).
- Wire any consent manager as a `consent_callback` service so audiences resolve only when profiling is permitted.
