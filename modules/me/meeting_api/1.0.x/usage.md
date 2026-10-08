<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Meeting API is a framework that models a meeting as a revisionable content entity and delegates the actual conferencing technology to pluggable "backend" plugins, so a site can create, list and reference meetings without hard-coding one provider.

---

Meeting API supplies the missing abstraction between "a meeting exists in my site" and "a meeting happens on some platform". It defines three entity types — a `meeting_api_server` config entity (a named endpoint bound to one backend plugin), a `meeting_api_meeting_type` config bundle (which points at a server), and a `meeting_api_meeting` content entity (label, start/end via `datetime_range_timezone`, max attendees, owner, revisions, and an opaque per-backend `backend_settings` map). The conferencing technology itself is a `meeting_api_backend` plugin (attribute `#[Backend]`, interface `BackendInterface`, manager `BackendPluginManager`, namespace `Plugin/MeetingApiBackend`); each backend implements `joinMeeting(MeetingInterface, MeetingAttendeeInterface): string` and returns a join URL, and the `MeetingManager` service (`Drupal\meeting_api\MeetingManagerInterface`) is the single uniform entry point that resolves a meeting's server, instantiates its backend and calls join. Out of the box the only shipped backend is **`meeting_api_manual`** (id `manual`), which stores one URL per meeting and returns it verbatim — no external API, no credentials. A richer provider (Zoom, Teams, Jitsi, BigBlueButton, etc.) is expected to be a separate module implementing `BackendInterface` — and, when it talks to an API, the optional `BackendWithClientInterface::getClient()` contract that hands back a per-call configured client. The optional **`meeting_api_scheduler`** submodule adds availability logic: a `meeting_api_time_constraint` config entity + plugin type, a `server_capacity` constraint that blocks time slots once concurrent-attendee load exceeds a limit, a `SoftReservationManager` that temporarily holds capacity in a DB table (purged on cron), and a FullCalendar-backed `period_schedule` render element with a permission-gated, HMAC-signed JSON events endpoint. This is version **1.0.0-alpha3** on core `^10 || ^11`; the README states plainly that it "provides API features but does not implement any permission logic," so every entity type is gated only by broad `administer …` permissions — plan your own access model before exposing meetings to non-admins. Because the module is entity- and plugin-based, meetings appear in Views, carry revisions, and can be referenced like any other content.

---

- Model meetings as first-class content entities (label, time range with timezone, max attendees, owner, revisions).
- Reference a meeting from a node, block or Views listing like any other entity.
- Decouple a site from one conferencing provider by putting the provider behind a backend plugin.
- Paste a fixed join URL per meeting with the Manual URL backend (`meeting_api_manual`), no API needed.
- Define multiple meeting types, each bound to a different server/backend (e.g. "Webinar" vs "Consultation").
- Configure named servers as reusable endpoints for a backend technology.
- Write a custom backend for Zoom, Teams, Jitsi or BigBlueButton by implementing `BackendInterface`.
- Expose a configured API client from a backend via `BackendWithClientInterface::getClient()`.
- Join a user to a meeting through one uniform service call (`MeetingManager::joinMeeting()`).
- Store per-meeting backend settings (URL, room id, passcode) in the opaque `backend_settings` map field.
- Show meetings in a calendar or upcoming-sessions view via core Views (entity exposes `views_data`).
- Track who created a meeting and keep full revision history of changes.
- Support a training platform's session catalogue.
- Support a professional body's or community's event schedule.
- Support a clinic's or advisor's appointment slots.
- Limit concurrent server capacity so a backend is not overbooked (`server_capacity` time constraint, scheduler submodule).
- Show busy/free time slots in a FullCalendar widget and suggest an available slot (scheduler submodule).
- Temporarily "soft reserve" a slot while a user completes a booking form, auto-expiring on cron (scheduler submodule).
- Add custom availability rules (maintenance windows, opening hours) as `meeting_api_time_constraint` plugins.
- Build the data layer for a decoupled/front-end booking flow that reads meetings over Views or JSON:API.
- Migrate or swap conferencing providers by adding a new backend and repointing meeting types, rather than rewriting integrations.
