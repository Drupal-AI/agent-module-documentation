<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Calendar Service integrates Google Calendar and related services into Drupal, importing calendar events via a Google service account.

---

Google Calendar Service integrates Google Calendar with Drupal — importing and surfacing calendar
events using a Google service account (with domain-wide delegation to read a user's calendar). It
depends on core Inline Entity Form, Text, User and Views, is configured at
`google_calendar_service.settings`, and provides its own permissions.

The client uses a service account with domain-wide delegation (`setSubject`). Store the
service-account secret file outside the web root and out of version control, and scope the delegation
minimally.

---

- Import Google Calendar events into Drupal.
- Integrate Google Calendar and related services.
- Use a Google service account.
- Configure at google_calendar_service.settings.
- Depend on inline_entity_form, text, user, views.
- Provide its own permissions.
- Store the service-account secret outside the web root.
- Keep the secret file out of version control.
- Scope domain-wide delegation minimally.
- Surface calendar events on the site.
- Read a user's calendar via delegation.
- Rotate the service-account key if exposed.
- Import events via the Calendar API.
- Display Google Calendar content.
- Handle Google credentials securely.
