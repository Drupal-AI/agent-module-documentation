<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Image Studio

## Settings form
**Configuration > AI > AI Image Studio** (`/admin/config/ai/image-studio`, `administer ai image studio`). Key `ai_image_studio.settings` groups:

- **Storage:** `file_scheme` (default `private`), `file_directory` (`ai-image-studio`; regex-validated, blocks `..`).
- **Limits:** `max_prompt_length` (4000), `max_turns` (25 per session), `max_source_image_size_mb` (20), `max_video_duration` (15).
- **Defaults:** `default_output_type`, `default_aspect_ratio`, `default_image_resolution`, `default_video_resolution`, `default_video_duration`, `default_image_file_type`, `default_transparent_background`, and default models per operation (`default_text_to_image_model`, `default_image_to_image_model`, `default_text_to_video_model`, `default_image_to_video_model`).
- **AI badge:** `default_show_ai_badge`, `default_ai_badge_text`.
- **Cost display/warnings:** `show_costs`, `show_token_usage`, `show_request_metadata`, `show_session_report`, `request_cost_warning`, `session_cost_warning`.
- **Media publishing:** `media_bundle` (image) + `media_source_field` (`field_media_image`), `require_image_alt` (true), `video_media_bundle` + `video_media_source_field`.

## Using it
1. Grant `access ai image studio` to the roles that may generate. Optionally grant `publish ai image studio image`/`video`, and `view any` / `delete any` for moderators.
2. Users create a session at `/admin/content/ai-image-studio/new`, enter a prompt, and each submission runs a turn synchronously through the selected AI provider/model.
3. A completed turn can be published to the configured Media bundle/field; an AI badge can be burned into the derivative (GD for images, ffmpeg for video).

## Notes
- Generated files default to `private://` and are re-authorized on download by `hook_file_download` (owning Media or session `view` access), so they are not publicly guessable.
- There is no built-in rate limiting beyond `max_turns` per session; session creation is unbounded. For spend control, add **AI Budget Control**.
- All model I/O is delegated to `drupal/ai`; this module makes no direct HTTP calls and does not disable TLS or handle provider keys.
