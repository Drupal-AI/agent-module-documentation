<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification Message lets site admins compose and broadcast site-wide notification messages (announcements, banners, alerts) that display for a configurable date window in a block, optionally gated by Drupal Condition plugins and dismissible by visitors.

---

The module defines a `notification_message` content entity with configurable bundles (`notification_message_type` config entity). Each message has a `label`, a `message` (text_long) body, an `Authored by` (uid) reference, and two required datetime fields — `publish_start_date` and `publish_end_date` — that form the display window. "Published" is computed purely from that window (`isPublished()` returns true when now is between start and end); there is no boolean status field. A `Notification messages` block (plugin id `notification_message`) queries messages whose window is current, optionally filtered to selected types, renders each in a chosen view mode, and evaluates any per-message Condition plugins (roles, paths, etc.) before showing them — with an "all conditions required" toggle. Message types can enable a cookie-based **dismiss** control (JS in `assets/js/notification-message.dismiss.js`, library `notification_message/notification.dismiss`). Because message types are Field UI bundles, you can attach extra fields (image, link, etc.) to a type. The block exposes messages via a custom `route.entity_uuid` cache context so per-route/per-entity variations cache correctly, and `hook_cron` invalidates cache tags of messages whose end date has just passed. Access is broadcast-oriented: any user may view a message while it is within its window; out-of-window (unpublished) messages are visible only to the author (with `view own unpublished notification message`) or holders of `view any unpublished notification message`, and full management requires the `administer notification message content` / `administer notification message types` permissions.

---

- Show a site-wide maintenance or outage announcement for a fixed time window.
- Publish a promotional banner that automatically appears and disappears on set dates.
- Create separate message types (e.g. "Alert", "Promo", "Info") with different styling/templates.
- Target a message to specific user roles using a Role condition.
- Restrict a message to certain paths/pages using a Request Path condition.
- Combine multiple conditions and require all (AND) or any (OR) to match.
- Let visitors dismiss a message, remembered across sessions via a cookie.
- Place the notification block in any region via Block layout, filtered to chosen types.
- Render messages in a custom view mode (e.g. compact vs full) per block instance.
- Attach an extra field (icon, CTA link, severity) to a message type through Field UI.
- Schedule several announcements in advance, each with its own start/end date.
- Show "all valid messages" by leaving the block's type filter empty.
- Provide multilingual announcements (the entity is translatable).
- Author a draft message that only the author can preview before its start date.
- Grant an editor `view any unpublished notification message` to review upcoming messages.
- Theme a single message by id or bundle using the generated template suggestions.
- Style the message queue container via the `notification-messages` wrapper template.
- Use a "global" default type for generic site-wide notices (shipped in config/install).
- Auto-expire notices without manual unpublishing by relying on the end date + cron.
- Add a dismiss button with custom label text per message type.
- Display context-aware banners (e.g. only on a section) without writing code.
- Keep the block cache-correct across routes via the `route.entity_uuid` cache context.
- Broadcast an emergency notice that every visitor sees immediately once its start date passes.
