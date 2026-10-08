<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Image Studio (ai_image_studio) — agent index

**Conversational image/video generation via Drupal AI providers, with owner-scoped sessions/turns and publishing to Media.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Requires:** ai:ai, file, media, user
- **Entities:** `ai_image_studio_session` (owner-scoped) + `ai_image_studio_turn` (prompt/image/video/provider/model/cost/status).
- **Routes:** collection/new/canonical(delete) under `/admin/content/ai-image-studio` (`access ai image studio` / `_entity_access`), settings `/admin/config/ai/image-studio` (`administer ai image studio`).
- **Permissions:** `access ai image studio`, `view any`, `delete own`, `delete any` (restrict), `publish ai image studio image`/`video`, `administer ai image studio` (restrict).
- **Service:** `ai_image_studio.generator` (`ImageGenerator` -> `ai.provider`), `ai_image_studio.compact_media_form`.

**Security:** No anonymous/unauthenticated generation — every entry point requires `access ai image studio`; `SessionAccessControlHandler` scopes view/update/delete to the owner (correct), private files re-authorized via `hook_file_download`. No disabled TLS, no API keys logged, no user-controlled file paths (integer session/turn ids), no raw SQL/unserialize. Residual (not a defect): `access ai image studio` is not restrict-access and there is no rate limit beyond `max_turns` per session — cost-abuse risk if broadly granted; pair with ai_budget_control.

See [configure/settings.md](configure/settings.md).
