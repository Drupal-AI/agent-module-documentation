<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Comment Guard (ai_comment_guard) — agent index

AI moderation of **new Drupal comments** via the **Anthropic Claude Messages API**. On presave each
comment body is sent to Claude, which returns a JSON verdict; on insert the module flags, redacts, or
blocks the comment. Package `Content moderation`. Depends on core **`comment`** and **`system`**.
Core `^10 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later. Version 1.1.0.

- **Settings, config keys, permissions, the moderation flow, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service `ai_comment_guard.sanitizer` = `AiCommentGuardService`
  (`src/Service/AiCommentGuardService.php`). All AI logic lives here. It calls Anthropic directly
  with `@http_client` (Guzzle) — it does **not** use the contrib `drupal/ai` abstraction and has no
  drupal/ai dependency.
- One config form `AiCommentGuardSettingsForm` (`src/Form/`), route
  **`ai_comment_guard.settings_form`** at `/admin/config/content/comment-sanitizer`, permission
  **`administer comment sanitizer`** (`restrict access: TRUE`). This is the only route.
- Two permissions (`ai_comment_guard.permissions.yml`): `administer comment sanitizer`,
  `bypass comment sanitizer`.
- Config object **`ai_comment_guard.settings`** (schema + install defaults present).
- No entities, no plugin types, no Drush commands, no REST/AJAX endpoints. `hook_mail()` sends the
  optional author notice. `src/Plugin/Mail/AiCommentGuardMail.php` is an empty stub (the real
  `hook_mail` is in the `.module`).

## Hooks / mechanism (from `ai_comment_guard.module` + service)

- `hook_comment_presave` → `sanitize()`: skips programmatic saves (`isNew()` guard) and users with
  the bypass permission; extracts `comment_body`, calls Claude, and stores intent in the private
  temp store (`pending_flag`). It does **not** modify the entity (the form would overwrite it).
- `hook_comment_insert` → `applyStoredModeration()`: reads `pending_flag` and writes directly to the
  `comment__comment_body` / `comment_field_data` tables (bypassing `$comment->save()`), then resets
  the entity cache and stores `message_flag`. Modes: `flag` (unpublish), `replace` (overwrite body
  with `cleaned_text`), `block` (overwrite with `replacement_text` + unpublish).
- `hook_form_comment_form_alter` appends `ai_comment_guard_comment_form_submit_last`, which deletes
  core's status messages and shows the correct held/edited/posted notice.
- `hook_requirements` warns on the Status Report when the API key is empty; `hook_install` shows a
  configure-your-key message; `hook_uninstall` deletes the config.

## Model / API details

- Constants in the service: `API_URL = https://api.anthropic.com/v1/messages`,
  `MODEL = claude-sonnet-4-6`, `API_VERSION = 2023-06-01`. Request uses `x-api-key` header,
  `max_tokens: 1024`, 15s timeout. Response text is JSON-decoded (markdown fences stripped) into
  `{is_harmful, severity, reason, cleaned_text}`.
