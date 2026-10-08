<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Clips — clip types, entities, routes, permissions, storage

## Install / enable

`drush en audio_clips`. Requires the **ffmpeg + ffprobe** CLI binaries (README shows the Alpine
`apk add --no-cache ffmpeg`). `hook_install()` (`audio_clips.install`) creates `public://audio_clip`.
Core `file` module is required in practice (the code uses `Drupal\file\Entity\File`).

## Entities

- **`audio_clip`** — content entity (`src/Entity/AudioClip.php`), `#[ContentEntityType]`.
  - Tables: `audio_clip` (base), `audio_clip_field_data`, `audio_revision`, `audio_field_revision`.
  - Keys: id `acid`, revision `vid`, bundle `type`, `langcode`, `uuid`. Revisionable + translatable.
  - Base fields: `original_id` (source file id), `target_id` (clip file id), `start_time`,
    `end_time` (unsigned int seconds, read-only), plus `revision_timestamp/uid/log`.
  - `preDelete()` loads the `File` at `target_id` and deletes it (clip file is cleaned up with the entity).
  - Uses core handlers only: `SqlContentEntityStorage`, `EntityViewBuilder`,
    `EntityAccessControlHandler`, core `ContentEntityForm`/`ContentEntityConfirmFormBase`.
    No route provider / no UI links are declared for `audio_clip` itself — it is managed via the API.
- **`audio_clip_type`** — config bundle entity (`src/Entity/AudioClipType.php`), `#[ConfigEntityType]`,
  `config_prefix: type`, `bundle_of: audio_clip`. Exported keys: `id, label, description,
  min_duration, max_duration`. Config objects are named `audio_clips.type.<id>`
  (schema: `config/schema/audio_clips.schema.yml`, type `config_entity` with `min_duration` /
  `max_duration` integers).
  - `postSave()` creates `public://audio_clip/clip_<id>`; `preDelete()` `deleteRecursive()`s it.
  - Static helpers: `getAllClipType()` (loadMultiple), `getClipTypeNames()` (bundle-info labels),
    `getMinDuration()` / `getMaxDuration()` / `getDescription()`.

## Routes (`audio_clips.routing.yml`) — all under `/admin/config/media/audio-clips`

| Route | Path | Access |
|---|---|---|
| `audio_clip.overview_types` | `/types` (entity list) | `_permission: administer content types` |
| `audio_clip.type_add` | `/types/add` | `_permission: administer content types` |
| `entity.audio_clip_type.edit_form` | `/manage/{audio_clip_type}` | `_permission: administer audio clip types` |
| `entity.audio_clip_type.delete_form` | `/manage/{audio_clip_type}/delete` | `_entity_access: audio_clip_type.delete` |

Menu link `audio_clip.overview_types` sits under Configuration → Media (`system.admin_config_media`);
local action `audio_clip.type_add` appears on the overview. `configure` in the `.info.yml` points at
`audio_clip.overview_types`.

## Permission (`audio_clips.permissions.yml`)

- `administer audio clip types` — "Administer audio clip types". (This is the one defined
  permission. The `admin_permission` values on the entity annotations — `administer audio clip`,
  `administer clip types` — are **not** declared anywhere, so they grant to no one and fail closed.)

## Managing types

- **Form** `Form\AudioClipTypeForm` (add/edit): fields `label`, machine `id` (locked after create),
  `description` (textarea), `min_duration`, `max_duration` (number, seconds). `validateForm()`
  errors if both set and `min_duration > max_duration`. `save()` trims values, shows a status
  message, logs new types to the `audio_clip` channel, redirects to the overview.
- **Delete** `Form\AudioClipTypeDeleteForm` (`EntityConfirmFormBase`): if any `audio_clip` uses the
  type it blocks deletion with a "used by N pieces of content" message (entity query with
  `accessCheck(TRUE)`); otherwise standard confirm-delete.
- **List** `AudioClipTypeListBuilder`: table of Name / Description / Min / Max duration; empty text
  links to add a type. (Description rendered via `#markup`; input is admin-only config.)

## hook_help

`src/Hook/Help.php` (`#[Hook('help')]`, dispatched from `audio_clips.module` via `#[LegacyHook]`)
returns the module help on `help.page.audio_clips`.
