<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sightengine — configuration & usage

## 1. Get API credentials
Create a Sightengine account and obtain the app **API user** (`client_id`) and **API secret**
(`client_secret`).

## 2. Configure the module
Navigate to `/admin/config/people/sightengine` (permission `administer sightengine`). Form:
`Drupal\sightengine\Form\SightengineSettingsForm` writing to config `sightengine.settings`.

Fields:
- **Client ID** → `client_id`, **Client Secret** → `client_secret` (both required).
- **Text validator URL** → `validator_url.text` (required), **OPT country** → `opt_country`,
  **Mode** → `mode` (`standard`|`username`).
- **Text › Ignore models** → `models.text_ignore.profanity` / `.personal` / `.link`
  (checkboxes; matched detections in these lists are NOT flagged).
- **Image validator URL** → `validator_url.image`, **Image Models** → `models.image`
  (`nudity`, `wad`, `gore`, `offensive`).
- **Video validator URL** → `validator_url.video`, **Video Models** → `models.video`.

## 3. Enable moderation per field
Edit any string/text/image/file/entity_reference field
(`/admin/structure/types/manage/<bundle>/fields/...`). The module adds a **"Sightengine validate"**
checkbox (`sightengine_form_field_config_edit_form_alter`). Saving stores the flag at
`fields.<entity>.<bundle>.<field_name>` in `sightengine.settings`
(submit handler `sightengine_config_field_submit`).

## 4. How validation runs
- `hook_entity_bundle_field_info_alter` → `SightengineManager::addConstraintForFields()` inspects the
  saved `fields` flags and attaches a constraint based on the field type
  (`getValidationType()`): text/string → `sightengine_text`, image → `sightengine_image`,
  file/entity_reference → `sightengine_file`.
- On entity validation the validator builds params and posts to the matching `validator_url` via
  `SightengineManager::getValidateResponse()` (`\Drupal::httpClient()->post()`, JSON-decoded;
  `ClientException`/`RequestException` are caught and surfaced as an error message).
- **Text** (`SightengineTextValidator`): sends `text`, `mode`, `opt_countries`, current `lang`;
  timeout 100s. Flags each match whose `type` is not in the corresponding ignore list.
- **Image** (`SightengineImageValidator`): sends the file as `CurlFile`, `models` CSV; timeout 10s.
  Flags `nudity.raw > 0.5`, `gore.prob > 0.5`, otherwise scalar score `> 0.5`.
- **File** (`SightengineFileValidator`): for `file` fields loads the file; for media/entity_reference
  loads the `Media` entity, pulls its file, and routes by MIME to image or video moderation
  (`SightengineManager::getImageModeration()` / `getVideoModeration()`).
- Any issue → `$context->addViolation()` with a message naming the offending category, so the entity
  save fails validation.

## Notes
- Validation is synchronous and blocking on every save of a moderated field — mind API latency/quota.
- Detection threshold is hardcoded at `0.5`; tune behaviour by toggling models, not editing code.
- Endpoint URLs are admin-set; keep them pointed at the official Sightengine API hosts.
- No Drush commands; config is exportable via `sightengine.settings`.
