<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AddEvent

Route `addevent.settings` → `/admin/config/services/addevent/settings`, permission `administer addevent settings`.

- Single field **token** (`AddEventSettings` form) → stored in `addevent.settings:token`.
- The token authenticates outbound calls to the AddEvent API as `Authorization: Bearer <token>`.
- After saving, place the **Add to Calendar** or **Subscribe to Calendar** block via Block Layout, or add an `addevent` field to an entity and choose the Button/Link formatter on Manage display.
