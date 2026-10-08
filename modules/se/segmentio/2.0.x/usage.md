<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates Segment's analytics.js so a site can pipe events to any analytics/marketing service configured in Segment, using only a write key — no per-service code.

Segment lets you send `identify`, `page`, `track`, `group`, and `alias` calls to many downstream tools from one snippet. This module attaches Segment's library (`segmentio/segmentio`) via `hook_page_attachments()` and passes the configured **write key** and a `variables` payload into `drupalSettings`. The payload is assembled from pluggable callbacks discovered through `hook_segmentio_info()`: built-ins `segmentio_segmentio_user` (adds `identify.userId` and traits **name and email** of the current user) and `segmentio_segmentio_node` (adds page category/name and node properties on node routes). Which callbacks run is controlled by the `segmentio_track` config (list of `module:hook` entries). Per-request `track` events can be queued from code with `segmentio_set_track_event()` (stored in `$_SESSION`, which triggers the page-cache kill switch so that response isn't cached). A privacy option (`segmentio_privacy`, on by default) disables tracking when the browser sends a `DNT` header.

Configuration is at `/admin/config/system/segmentio` (route `segmentio.admin_settings_form`, permission `administer segmentio`) where you set the write key and enable additional tracking hooks. Config lives in `segmentio.settings` (`segmentio_write_key`, `segmentio_privacy`, `segmentio_track`). Developers extend tracking by implementing `hook_segmentio_info()` plus a callback that mutates the `$variables` array (see `segmentio.api.php`). Operational note: when the user callback is enabled, the authenticated **user's name and email are emitted into the page as drupalSettings** (client-visible) and sent to Segment — a privacy consideration for GDPR/PII, and the write key itself is public client-side by design.
---
Adds Segment (analytics.js) to a site via a write key, with pluggable identify/page/track data.
---
- Configure the Segment write key at `/admin/config/system/segmentio`.
- Send analytics to any Segment-connected destination without code.
- Identify the logged-in user (userId + name/email traits).
- Track node page views with category/name/nid properties.
- Enable or disable specific tracking callbacks via settings.
- Respect the browser Do-Not-Track header to suppress tracking.
- Queue a custom `track` event from code with `segmentio_set_track_event()`.
- Add custom identify/page/track data via `hook_segmentio_info()`.
- Implement a `{module}_{hook}` callback to mutate the tracking payload.
- Group users into accounts with Segment `group` calls from a callback.
- Alias anonymous and identified users via a callback.
- Send event properties (e.g. downloaded PDF name) to Segment.
- Restrict configuration access with the `administer segmentio` permission.
- Avoid caching pages that queue per-request track events (kill switch).
- Push page metadata to marketing tools connected in Segment.
- Add product/analytics tools by changing only the Segment config.
- Fire a conversion `track` event after a form submit in code.
- Provide user traits to downstream CRMs via Segment identify.
- Toggle privacy handling with the `segmentio_privacy` setting.
- Log an emergency when no write key is configured but tracking runs.
- Extend tracking per content type via a custom node callback.
- Review which callbacks are active in `segmentio_track` config.