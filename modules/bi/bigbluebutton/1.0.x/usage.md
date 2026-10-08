<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Big Blue Button adds a configurable "bigbluebutton" field that turns any content entity into a BigBlueButton web-conferencing room, with meeting creation, a role-based join button, and recording playback/download.

---

Big Blue Button integrates BigBlueButton — the open-source web-conferencing / virtual-classroom system — into Drupal as a single-cardinality field type (`bigbluebutton`). Add the field to any entity bundle (node, etc.); when the field is enabled on an entity, the module lazily creates the BBB meeting through the `bigbluebutton/bigbluebutton-api-php` library (all API calls signed with the site's BBB shared secret) and stores the returned attendee/moderator passwords and meeting id back on the field. The default formatter renders a "Join meeting" button whose role — moderator vs. viewer — is derived from the current user's `update`/`view` access to the host entity, and a recordings formatter lists, plays, downloads and deletes the meeting's recordings. Configure the BBB server hostname and secret at `admin/config/system/bbb-settings`; a default presentation and per-button labels have their own admin forms. Optional Token integration lets you template the welcome/moderator messages, logout URL and the display name shown in the meeting. Two REST resources expose the join link and live meeting info for headless/JS front-ends.

---

- Add a BigBlueButton meeting room to any content type via the `bigbluebutton` field.
- Configure the BBB server host and shared secret once at `admin/config/system/bbb-settings`.
- Auto-create the BBB meeting when the field is enabled on an entity (lazy, on first join).
- Render a role-aware "Join meeting" button on the entity display (moderator vs. viewer).
- Map an entity's PDF file field as the meeting's uploaded presentation.
- Set a site-wide default presentation (`admin/config/bigbluebutton/default-presentation`).
- Customise the join-button label (`admin/config/bigbluebutton/button-labels`).
- Auto-start recording when the first participant joins.
- Auto-mute all participants on meeting start.
- Set a guest policy (e.g. breakout / waiting-room style `ASK_MODERATOR`).
- Define per-meeting welcome and moderator-only chat messages.
- Template those messages and the logout URL with tokens (with the Token module).
- Show a custom display name for participants using a token pattern (per user or per registration entity from the query string).
- List a meeting's recordings as links, thumbnails, embedded video, or download-only.
- Play recordings inline (iframe/video) via the recording view route.
- Download MP4 recordings to the browser.
- Delete recordings from the BBB server (permission-gated).
- Redirect users to a configured logout URL after they leave a meeting.
- Pass Drupal context (entity id/uuid/label, origin server) to BBB as meeting metadata.
- Receive a meeting-end callback from the BBB server at a generated Drupal route.
- Fetch a live join link over REST at `/api/bigbluebutton/join-meeting-link/{entity_type_id}/{entity_uuid}`.
- Fetch live meeting info (state + BBB data) over REST at `/api/bigbluebutton/meeting-info/{entity_type_id}/{entity_uuid}`.
- Alter the computed meeting role for a user via `hook_bigbluebutton_meeting_role_alter()`.
- Run on Drupal 10 or 11 with the bundled BBB PHP API library as the only external dependency.
