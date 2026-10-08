<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Calendar Service — agent index

Integrates **Google Calendar** into Drupal (imports events) via a **Google service account** with
domain-wide delegation. Depends on core `inline_entity_form`, `text`, `user`, `views`. Config at
`google_calendar_service.settings`; provides permissions. Version **3.0.5**. Core `^10||^11`.

Store the service-account secret file outside the webroot; scope delegation minimally.
