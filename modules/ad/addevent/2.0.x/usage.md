<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AddEvent integrates the third-party AddEvent service so visitors can add events to their personal calendars or subscribe to a calendar feed.

---

The module wraps the AddEvent HTTP API and exposes its "Add to Calendar" and "Subscribe to Calendar" widgets to Drupal. Configuration is a single admin form at `/admin/config/services/addevent/settings` (permission `administer addevent settings`) that stores the AddEvent API **token**; the token is sent as a `Bearer` header on outbound requests to the AddEvent API (`src/Api/BaseApi.php`). A service factory `addevent.api.factory` builds an authenticated `AddEventCalendarApi` client from that config.

Content authors surface the widgets in three ways: two blocks (`Add to Calendar`, `Subscribe to Calendar`) placed through Block Layout, an `addevent` **field type** with a hidden widget, and two field formatters (`AddEventButtonFormatter`, `AddEventLinkFormatter`) that render the field as an AddEvent button or link. All configuration and the API token are admin-gated; there are no anonymous or mutating endpoints exposed by the module — visitor interaction happens client-side against AddEvent's own service.

---
- Install and enable the AddEvent module
- Obtain an AddEvent API token from your AddEvent account
- Enter the token at `/admin/config/services/addevent/settings`
- Place an "Add to Calendar" block in a region via Block Layout
- Place a "Subscribe to Calendar" block for calendar feed subscriptions
- Configure the block's event details for your use case
- Add an `addevent` field to a content type
- Render the field with the "AddEvent Button" formatter
- Render the field with the "AddEvent Link" formatter
- Use the hidden widget to store event data on the entity
- Let visitors add events to Google/Outlook/Apple calendars
- Offer a subscribe link for recurring/updated calendars
- Grant `administer addevent settings` only to trusted admins
- Rotate the AddEvent token by re-saving the settings form
- Integrate calendar buttons on event content types
- Use the API factory service in custom code for AddEvent calls
