<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bigbluebutton` field: type, widget, formatters & join mechanism

## Field type — `BigBlueButtonItem`

`src/Plugin/Field/FieldType/BigBlueButtonItem.php`, id **`bigbluebutton`**, `cardinality = 1`,
default widget `bigbluebutton_default`, default formatter `bigbluebutton_default`. Add it to a bundle
under *Manage fields* (category "bbb").

Properties / columns (`propertyDefinitions()` + `schema()`):

| Property | Type | Role |
|---|---|---|
| `enabled` | boolean | Master switch — meeting logic only runs when TRUE. |
| `welcome` | varchar(255) | Welcome chat message (token-templatable). |
| `moderator_only_message` | varchar(255) | Moderator-only chat message (token-templatable). |
| `logout_url` | varchar(255) | Redirect after leaving (token-templatable). |
| `guest_policy` | varchar(255) | BBB guest policy (e.g. `ALWAYS_ACCEPT`, `ASK_MODERATOR`). |
| `record` | tinyint | Auto-start recording on first join. |
| `mute_on_start` | tinyint | Mute all on start. |
| `presentation_source` | varchar(255) | Machine name of a **PDF** file field to upload as the presentation. |
| `meeting_id` | varchar(255) | BBB meeting id (the entity **UUID** is used as the meeting id). |
| `attendee_pw` | varchar(255) | Viewer password returned by BBB. `setInternal(TRUE)`. |
| `moderator_pw` | varchar(255) | Moderator password returned by BBB. `setInternal(TRUE)`. |

**Field overrides** (`defaultFieldSettings()` / `fieldSettingsForm()`): each generic property
(welcome, logout_url, guest_policy, moderator_only_message, record, mute_on_start, presentation_source)
can be forced **Hidden / Optional / Required** per field instance via `FieldOverride` constants
(`src/Utility/`). `getProperties()` unsets hidden properties. Field settings schema:
`field.field_settings.bigbluebutton`.

## Widget — `bigbluebutton_default`

`src/Plugin/Field/FieldWidget/BigBlueButtonDefaultWidget.php`. Edit form for the meeting settings above
(honouring the field overrides). The password/meeting-id columns are generated at runtime, not entered
by the editor.

## Default formatter — the "Join meeting" button

`BigBlueButtonDefaultFormatter` (id `bigbluebutton_default`). For an enabled field it uses
`bigbluebutton.dynamic_form_factory` to build a per-entity form (`BBBLinkForm`) rendered as the join
button; settings `link_title` (default "Join meeting") and `link_classes`. Schema
`field.formatter.settings.bigbluebutton_default`.

## Meeting lifecycle (`BigBlueButtonHelper`)

`src/BigBlueButtonHelper.php` is the core. It reads `hostname`/`secret` from `bigbluebutton.settings`
and builds a `BBB` client (`src/BBB.php`, subclass of the library `BigBlueButton`, wired with
`UrlBuilder($secret, $host)` — every API call is checksum-signed with the secret).

- **`createMeeting($entity)`** — guarded by `isValidExternalURL($host) && !empty($secret)`. Builds
  `CreateMeetingParameters($entity->uuid(), $entity->label())`: welcome/moderator messages (token-replaced
  when Token is enabled), theme logo, presentation (from the mapped PDF field via
  `getSupportedPresentationSources()`, else the default presentation), logout URL, `duration=0`,
  `record=TRUE`, `allowStartStopRecording=TRUE`, plus `autoStartRecording`/`guestPolicy`/`muteOnStart`
  from the field, an **end-callback URL** (`generateBBBMeetingEndCallback()`), and `bbb-*` metadata
  (origin, server name, context id/uuid/label). On success it saves the returned `attendee_pw`,
  `moderator_pw`, `meeting_id` back on the entity.
- **`checkMeeting($entity)` / `getMeetingInfo($type,$uuid)`** — call `getMeetingInfo` with the stored
  moderator password to see if a meeting is RUNNING/IDLE.
- **`generateJoinMeetingLink($entity=NULL,$uuid=NULL,$type=NULL)`** — the access-defining method:
  1. Loads the entity (by UUID when called from REST).
  2. If no live meeting, `createMeeting()`; else reads stored passwords via
     `getSettingsFromExistingMeeting()`.
  3. **Role is derived from Drupal entity access**: `$entity->access('update')` → `moderator`
     (moderator password); else `$entity->access('view')` → `viewer` (attendee password). If the user has
     neither, `$role`/`$password` stay NULL, no `JoinMeetingParameters` is built, and the method throws
     `UnprocessableEntityHttpException` — i.e. **you cannot get a join link for an entity you cannot at
     least view.** The role can be adjusted by `hook_bigbluebutton_meeting_role_alter($role,$entity,$account)`.
  4. Display name comes from `user_display_name` token (per user, or per `?entity_type=uuid` registration
     entity), falling back to `currentUser->getDisplayName()`.
  5. Returns `['link' => $bbb->getJoinMeetingURL($params), 'role' => $role]` (redirect enabled), or
     `['link' => 'disabled']` when the field is not enabled.

The join URL BBB requires is a signed URL containing a checksum (SHA over the query + secret); the raw
secret is not part of the URL.

## Integrator hook

`hook_bigbluebutton_meeting_role_alter(?string &$role, EntityInterface $entity, AccountInterface $account)`
(`bigbluebutton.api.php`) — override the computed `moderator`/`viewer` role, e.g. to grant moderator to a
group role. Returning a role changes which password (and thus which BBB privileges) the join link carries.
