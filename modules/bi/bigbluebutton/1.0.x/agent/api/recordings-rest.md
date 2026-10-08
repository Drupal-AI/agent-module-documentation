<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recordings, REST resources & meeting-end callback

## Recordings formatter — `bigbluebutton_recordings`

`src/Plugin/Field/FieldFormatter/BigBlueButtonRecordingsFormatter.php`. On a `bigbluebutton` field's
display it calls `BBB::getRecordings()` with `meetingID = entity->uuid()` and renders the meeting's
recordings. Settings (`field.formatter.settings.bigbluebutton_recordings`):

- `display_options`: `links` | `thumbnail` | `video` | `download_only` (chooses the twig theme:
  `bbb_recordings_links` / `_thumbnails` / `_video` / `_download_only`).
- `supported_formats`: checkboxes `presentation` / `screenshare` / `video` / `video_mp4` (empty = all).

Per-recording it conditionally attaches a **delete** form (if the user has
`delete bigbluebutton recording`) and a **download** form (video formats only, if the user has
`access bigbluebutton video download`), and lists the recording only if the user has
`access bigbluebutton recording`. `formatRecordingDate()` parses the JS timestamp embedded in the
record id. Templates in `templates/` output the BBB-provided playback URL into `href`/`src` (Twig
auto-escaped; no `|raw`).

## Recording view route

`bigbluebutton.view_recording` → `/bigbluebutton/{entity_uuid}/view_recording/{recording_id}`,
permission `access bigbluebutton recording`. `BigBlueButtonRecordingController::viewRecording()` fetches
the meeting's recordings (`getRecordings` with `meetingID = entity_uuid`), finds the one matching
`recording_id`, and returns `bbb_recordings_video_iframe` (presentation) or `bbb_recordings_video_video`
(video) with the playback `url`.

## Download route & form

- Form `BBBDownloadRecordingForm` (`src/Form/`) — a submit button gated by `access()` →
  `access bigbluebutton video download`. On submit it looks up the recording by id, fetches the playback
  page, extracts the MP4/webm source, and redirects to `bigbluebutton.download_recording` with a `url`
  query parameter.
- `bigbluebutton.download_recording` → `/bigbluebutton/download/recording` (`no_cache: TRUE`),
  permission `access bigbluebutton video download`. `BigBlueButtonDownloadRecordingController::download()`
  reads `?url=`, fetches it server-side with the HTTP client, and streams it back as a
  `BinaryFileResponse` attachment (MIME sniffed with `finfo`).

## REST resources

Core **REST** must be enabled and each resource configured (methods/formats/auth) plus its
`restful get …` permission granted. Both delegate to `bigbluebutton.helper`:

| Resource id | Canonical URI | Returns |
|---|---|---|
| `bigbluebutton_join_meeting_link_rest_resource` | `/api/bigbluebutton/join-meeting-link/{entity_type_id}/{entity_uuid}` | `generateJoinMeetingLink()` output `{link, role}` — role/password derive from the caller's entity `update`/`view` access (see [../fields/field.md](../fields/field.md)); throws 422 if the caller can't access the entity. |
| `bigbluebutton_meeting_info_rest_resource` | `/api/bigbluebutton/meeting-info/{entity_type_id}/{entity_uuid}` | `getMeetingInfo()` — `{state: RUNNING/IDLE/ERROR, bbb: <decoded getMeetingInfo XML>, drupal: {…ids}}`. |

`src/Plugin/rest/resource/BigBlueButtonJoinMeetingLink.php` and `…/BigBlueButtonGetMeetingInfo.php`.

## Meeting-end callback

`createMeeting()` registers an end-callback URL built by
`BigBlueButtonHelper::generateBBBMeetingEndCallback()` = route `bigbluebutton.meeting_end`
(`/bigbluebutton/meeting-end/{meeting_id}/{meeting_type}`, permission `access content`). The BBB server
hits it when the meeting ends; `BigBlueButtonMeetingEndController::__invoke()` calls
`setActionOnMeetingEndCallback()`, which validates the entity type, loads the entity by UUID, **logs**
that the callback fired, and renders "Thank you!". In this version it performs no entity mutation
(the state-writing branch is commented out).
