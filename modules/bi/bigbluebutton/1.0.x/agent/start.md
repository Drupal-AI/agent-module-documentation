<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Big Blue Button (bigbluebutton) — agent index

Integrates **BigBlueButton** web conferencing into Drupal as a single-cardinality **field type**
(`bigbluebutton`). Enabling the field on an entity lazily creates a BBB meeting through the
`bigbluebutton/bigbluebutton-api-php` library (v2.0.13, the only external requirement); API calls are
signed with the site's BBB **shared secret**. Package **Other**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version **1.0.0-beta5**. Optional **Token** integration; **REST** (core) for the two
REST resources.

- **Server config, forms, permissions, routes** → [config/settings.md](config/settings.md)
- **The field type, widget, formatters, and the join/meeting mechanism** → [fields/field.md](fields/field.md)
- **Recordings + REST resources + meeting-end callback** → [api/recordings-rest.md](api/recordings-rest.md)

## What it actually is

- One **field type** `bigbluebutton` (`Plugin/Field/FieldType/BigBlueButtonItem.php`, cardinality 1),
  storing per-meeting settings (`welcome`, `logout_url`, `guest_policy`, `moderator_only_message`,
  `record`, `mute_on_start`, `presentation_source`, `enabled`) plus generated state
  (`attendee_pw`, `moderator_pw`, `meeting_id`; the two password properties are `setInternal(TRUE)`).
- One **widget** `bigbluebutton_default` and two **formatters**: `bigbluebutton_default` (renders the
  role-aware "Join meeting" form) and `bigbluebutton_recordings` (lists recordings).
- A central service **`bigbluebutton.helper`** (`BigBlueButtonHelper`) that creates meetings, computes the
  join link + role, and generates the meeting-end callback URL. `BBB` (`src/BBB.php`) subclasses the
  library `BigBlueButton` client, wired with the configured secret + hostname.
- Two **REST resources**: `bigbluebutton_join_meeting_link_rest_resource`
  (`/api/bigbluebutton/join-meeting-link/{entity_type_id}/{entity_uuid}`) and
  `bigbluebutton_meeting_info_rest_resource` (`/api/bigbluebutton/meeting-info/{entity_type_id}/{entity_uuid}`).
- Three **permissions** (`bigbluebutton.permissions.yml`): `access bigbluebutton recording`,
  `access bigbluebutton video download`, `delete bigbluebutton recording`.
- One **hook** for integrators: `hook_bigbluebutton_meeting_role_alter()` (`bigbluebutton.api.php`).

## Config & routes (quick map)

- Config object **`bigbluebutton.settings`** (`hostname`, `secret`, `user_display_name`); key-value
  collection `bigbluebutton` holds `default_presentation`; config object `bigbluebutton.button_labels`.
- Admin forms (all `administer site configuration`): `bigbluebutton.settings`
  (`/admin/config/system/bbb-settings`), `bigbluebutton.default_presentation`,
  `bigbluebutton.button_labels`.
- Runtime routes: `bigbluebutton.view_recording`, `bigbluebutton.download_recording`,
  `bigbluebutton.meeting_end`. Details + permission gates in the solution docs.

## Dependencies

- Composer: `bigbluebutton/bigbluebutton-api-php:2.0.13` (auto-installed). No Drupal module hard deps.
- Optional: **Token** (message/name templating), core **REST** (the two resources), a running
  **BigBlueButton server** you own (hostname + secret from its config).
