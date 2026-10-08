<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Event installs a ready-made Event content type with a date-range field, an event-type taxonomy, a faceted /events listing, and role permission grants — all as shipped configuration.

---

Drutopia Event is a config-only "base feature" from the Drutopia distribution. It ships no PHP, routes, services, or permissions of its own; everything is YAML config imported at install time. It creates an `event` node type whose defining field is `field_event_date`, a required datetime **range** (start/end) field, plus an `event_type` taxonomy reference for categorization. Around that it provides summary, body, a paragraph body, a media image (and a deprecated legacy image field), tags, topics, and meta-tag fields, a form display and seven view displays (default, full, teaser, card, simple_card, micro, search_index). A Search API index (`event`, database server) feeds a Views listing that publishes an `/events` page (in the main menu), an "Upcoming events" block filtered to events dated now-or-later, and exposes "Event type" and "Event Topics" facets. Two pathauto patterns give clean URLs (`events/[node:title]` for events, `[term:vocabulary]/[term:name]` for event-type terms). Config actions grant event-editing permissions to the existing Drutopia contributor, editor, and manager roles. It is normally installed with the full Drutopia distribution rather than standalone; on a plain site its long dependency chain must be present first.

---

- Add an out-of-the-box Event content type to a Drutopia site without building fields by hand.
- Capture event start and end times with the required `field_event_date` datetime-range field.
- Default a new event's date to "now" and its end to "+3 hours", so editors mostly adjust rather than enter from scratch.
- Categorize events with the `event_type` taxonomy vocabulary and let visitors filter by it.
- Publish a public events listing at `/events` (added to the main menu as "Events").
- Show an "Upcoming events" block that lists only events dated now-or-later, sorted soonest-first.
- Let site visitors narrow the events listing with checkbox facets for Event type and Event Topics.
- Provide clean, token-based URLs for events (`events/<title>`) and event-type terms via pathauto.
- Index events in Search API for keyword search and faceted browsing.
- Attach a summary field shown on event teasers and cards across the site.
- Use Paragraphs (text/image/file) for rich event body content via `field_body_paragraph`.
- Attach a responsive, focal-point-aware media image to events (`field_media_image`).
- Tag events with free-tagging Tags and structured Topics vocabularies shared across Drutopia.
- Add per-event meta tags for SEO through the metatag field.
- Grant contributors permission to create events and edit their own.
- Grant editors and managers permission to create events and edit any event.
- Offer an "Add event" action button on the events listing page for quick content creation.
- Drive block placement on the events page through the `event_listing` block visibility group.
- Provide multiple render contexts (full page, teaser, card, simple card, micro, search index) for reuse across the theme.
- Serve as the standard event feature within a Drutopia distribution build.
- Extend or override the shipped config (fields, displays, view, facets) to fit a specific site's event needs.
