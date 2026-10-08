<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Comment Moderation — settings & moderation flow

## Install & enable

```bash
composer require drupal/ai_comment_moderation
drush en ai_comment_moderation -y
drush cr
```

Only dependency is core **`comment`**. The `.install` file is empty (no schema/update hooks). There
is no `config/install` directory, so `openai_api_key` starts unset until you save the form.

## Configure

Route **`ai_comment_moderation.settings`** → `/admin/config/content/ai-comment-moderation`
(menu link under *Configuration → Content authoring*). Permission
**`administer site configuration`** (core's site-config permission — no dedicated permission is
defined). Form class `AiModerationSettingsForm` (form id `ai_moderation_settings_form`) writes config
object **`ai_comment_moderation.settings`**.

### Config keys (`ai_comment_moderation.settings`, from `config/schema`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `openai_api_key` | string | *(unset)* | OpenAI API key used as `Authorization: Bearer <key>`. Stored in this config object; the form field is a plain `textfield` (maxlength 256). |

The form is a minimal `ConfigFormBase` with just this one required field and a success message on
save. There are no options for model, categories, thresholds, or actions.

## Moderation flow

1. **`hook_comment_presave`** (`ai_comment_moderation_comment_presave`) fires on every comment save.
   It reads `$comment->get('comment_body')->value` and calls
   `AiModerationService::moderateText($body)`.
2. **`AiModerationService::moderateText()`**:
   - Loads `openai_api_key` from config.
   - POSTs to `https://api.openai.com/v1/moderations` via `@http_client` (Guzzle) with
     `Authorization: Bearer <key>`, `Content-Type: application/json`, body `{ "input": <text> }`.
     TLS verification uses Guzzle defaults (enabled).
   - Returns the boolean `results[0].flagged` from the API response. Exceptions are logged to
     `@logger.channel.default`.
3. Back in the hook: if the result is `TRUE`, `$comment->setUnpublished()` is called and a warning
   message ("This comment was flagged by the AI moderator and set to unpublished.") is shown.

## Operating notes

- **Configure the key first:** enter a valid OpenAI API key on the settings form before relying on
  moderation.
- **Endpoint type:** OpenAI's Moderation API is a *classification* endpoint (it returns category
  flags/scores), not a chat/completions model — there is no prompt to tune here.
- **Cost / egress:** each comment save sends the body to OpenAI and consumes an API call. Confirm
  this is acceptable for your content and privacy policy.
- **Scope:** the module only ever *unpublishes*; it never edits or deletes the body, and it adds no
  moderation queue of its own. Held comments appear in the standard unpublished-comment admin list
  (`/admin/content/comment/approval`).
- **README caveat:** the README says "Requirements: Drupal 10", but `info.yml`/`composer.json`
  declare `^10 || ^11`.
