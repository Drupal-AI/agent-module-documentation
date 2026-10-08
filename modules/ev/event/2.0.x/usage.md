<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a first-class `event` content entity (with an `event_type` config bundle) for managing events as their own entity type instead of as nodes.

---

Event (part of the Conference Organizing Distribution ecosystem) defines a dedicated, fieldable, revisionable, translatable and publishable `event` content entity plus an `event_type` config bundle, so a site can model events without overloading the node system. Each event carries base fields for name, a unique machine name, an `event_date` date range (stored as datetime with timezone), author, published status and revision metadata, and a `description` text field is attached to every bundle when the bundle is created. Routes are generated from the entity's link templates by a custom `EventHtmlRouteProvider` (there is no `event.routing.yml`), CRUD is gated by `EventAccessControlHandler`, and nine event permissions control add/edit/delete/view/administer and revision operations. The only enabled dependency is core `datetime_range`; the module ships an example admin listing view, an `event` display template, menu/task/action links, and a menu-link deriver that adds toolbar links when Admin Toolbar is present. This documented release is 2.0.0-rc3 (pre-release), requiring Drupal `^10.3 || ^11 || ^12`.

---

- Model events as a dedicated content entity rather than a `node` content type.
- Create multiple event bundles via the `event_type` config entity, each with its own fields.
- Store an event's start/end as a timezone-aware `event_date` date range field.
- Give each event a unique, validated machine name alongside its human-readable name.
- Add per-bundle fields (the `description` text field is attached automatically at bundle creation).
- Track full revision history for events (revisionable entity with revert/delete revision operations).
- Translate events into multiple languages (the entity is translatable).
- Control who can add, edit, delete, view published, and view unpublished events via dedicated permissions.
- Manage event types at `/admin/structure/event` and browse events at `/admin/content/events`.
- Publish and unpublish events using the entity's published status.
- Attach media, references, or other fields to events through the standard Field UI.
- Theme event output with the provided `event` template (`event.html.twig`).
- Surface event management links in the toolbar when Admin Toolbar is installed.
- Build custom Views reports over event data using the module's Views integration.
- Use events as the content backbone for a conference or event-management site (COD ecosystem).
- Replace ad-hoc "event" node types with a purpose-built entity that has its own access model.
- Reference events from other entities using standard entity reference fields.
- Keep event authoring separate from general content for cleaner editorial workflows.
