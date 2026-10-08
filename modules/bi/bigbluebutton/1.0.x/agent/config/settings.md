<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Server settings, admin forms, permissions & routes

## Install & enable

```bash
composer require drupal/bigbluebutton   # pulls bigbluebutton/bigbluebutton-api-php:2.0.13
drush en bigbluebutton -y
```

No Drupal module dependency. You need a **BigBlueButton server** you control; get its API URL and
shared **secret** from the server (`bbb-conf --secret`).

## Configure the server (`SettingsForm`)

Route **`bigbluebutton.settings`** → `/admin/config/system/bbb-settings`, permission
`administer site configuration`, form `src/Form/SettingsForm.php`. Writes config object
**`bigbluebutton.settings`**:

| Key | Meaning |
|---|---|
| `hostname` | BBB API base URL. Required. `validateForm()` calls `BigBlueButtonHelper::isValidExternalURL()` which validates the URL and does a live `GET` to confirm reachability. |
| `secret` | BBB shared secret used by the library `UrlBuilder` to sign every API request. Required. Stored as a plain string in config. |
| `user_display_name` | Optional token pattern for the name shown in the meeting (resolved per user, or per registration entity taken from a `?entity_type=uuid` query param). Needs the Token module. |

Config **schema** in `config/schema/bigbluebutton.schema.yml` (`bigbluebutton.settings` is a
`config_object` with `hostname`, `secret`, `presentation_default`, `user_display_name`).

## Default presentation & button labels

- **`bigbluebutton.default_presentation`** → `/admin/config/bigbluebutton/default-presentation`
  (`DefaultPresentationForm`, `administer site configuration`). Stores the default presentation FID in the
  **key-value** collection `bigbluebutton` under `default_presentation` (moved out of config by
  `bigbluebutton_update_8002`). `BigBlueButtonHelper::getPresentationDefault()` reads it and
  `createMeeting()` uploads it as the meeting's presentation when the entity supplies none.
- **`bigbluebutton.button_labels`** → `/admin/config/bigbluebutton/button-labels`
  (`ButtonLabelsForm`, `administer site configuration`). Writes config object
  `bigbluebutton.button_labels` (`join_meeting`, translatable). Config-translation enabled via
  `bigbluebutton.config_translation.yml`.

All three admin forms appear as tabs under the settings route (`bigbluebutton.links.task.yml`,
`bigbluebutton.links.menu.yml`).

## Permissions (`bigbluebutton.permissions.yml`)

| Permission | Gates |
|---|---|
| `access bigbluebutton recording` | Recording view route + whether recordings are listed by the recordings formatter. |
| `access bigbluebutton video download` | Download route + the per-recording download button/form. |
| `delete bigbluebutton recording` | The per-recording delete button/form. |

Meeting **creation and join** are *not* gated by a module permission — they follow the host entity's
Drupal `create`/`update`/`view` access (see [../fields/field.md](../fields/field.md)).

## Routes (`bigbluebutton.routing.yml`)

| Route | Path | Access | Controller/Form |
|---|---|---|---|
| `bigbluebutton.settings` | `/admin/config/system/bbb-settings` | `administer site configuration` | `SettingsForm` |
| `bigbluebutton.default_presentation` | `/admin/config/bigbluebutton/default-presentation` | `administer site configuration` | `DefaultPresentationForm` |
| `bigbluebutton.button_labels` | `/admin/config/bigbluebutton/button-labels` | `administer site configuration` | `ButtonLabelsForm` |
| `bigbluebutton.view_recording` | `/bigbluebutton/{entity_uuid}/view_recording/{recording_id}` | `access bigbluebutton recording` | `BigBlueButtonRecordingController::viewRecording` |
| `bigbluebutton.download_recording` | `/bigbluebutton/download/recording` | `access bigbluebutton video download` | `BigBlueButtonDownloadRecordingController::download` |
| `bigbluebutton.meeting_end` | `/bigbluebutton/meeting-end/{meeting_id}/{meeting_type}` | `access content` | `BigBlueButtonMeetingEndController` |

## Services (`bigbluebutton.services.yml`)

- `bigbluebutton.helper` → `BigBlueButtonHelper` (meeting create/info, join-link + role, callback URL).
- `bigbluebutton.dynamic_form_factory` → `BigBlueButtonDynamicFormFactory` (builds the per-entity join form
  instance the default formatter renders).

## Install/update notes (`bigbluebutton.install`)

- `bigbluebutton_update_8001` adds the `presentation_source` field column (via an address.install-style
  schema helper).
- `_8002` migrates `presentation_default` from config to the key-value store.
- `_8003` seeds `bigbluebutton.button_labels` (`join_meeting = "Join meeting"`).
