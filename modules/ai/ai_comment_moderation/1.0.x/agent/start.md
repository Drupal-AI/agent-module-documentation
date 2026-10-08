<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Comment Moderation (ai_comment_moderation) — agent index

Moderates **new Drupal comments** with **OpenAI's Moderation API**. On comment presave the body is
POSTed to `https://api.openai.com/v1/moderations`; if OpenAI returns `flagged: true` the comment is
set unpublished and the author gets a warning. Package `Custom`. Depends on core **`comment`**.
Core `^10 || ^11`. PHP `>=7.4`. License GPL-2.0-or-later. Version 1.0.0.

- **Install, the API key setting, the moderation flow, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service `ai_comment_moderation.service` = `AiModerationService`
  (`src/Service/AiModerationService.php`), method `moderateText(string $text): bool`. Calls OpenAI
  directly with `@http_client` (Guzzle); it does **not** use the contrib `drupal/ai` abstraction.
- One config form `AiModerationSettingsForm` (`src/Form/`), route
  **`ai_comment_moderation.settings`** at `/admin/config/content/ai-comment-moderation`, permission
  **`administer site configuration`**. This is the only route.
- Config object **`ai_comment_moderation.settings`** with one key `openai_api_key` (schema present;
  no `config/install` defaults dir).
- No entities, no plugin types, no Drush commands, no custom permissions, no REST/AJAX endpoints,
  no `.install` logic (empty install file).

## Hook / mechanism

- `ai_comment_moderation_comment_presave(CommentInterface $comment)` (`.module`): reads
  `comment_body`, calls `moderateText()`; on a flagged result runs `$comment->setUnpublished()` and
  adds a warning message. It fires on comment presave.
- `AiModerationService::moderateText()`: POSTs `{ "input": text }` with header
  `Authorization: Bearer <openai_api_key>` and returns the boolean `results[0].flagged` from the
  response; exceptions are logged to the default logger channel.
