<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Comment Guard — settings, permissions & moderation flow

## Install & enable

```bash
composer require drupal/ai_comment_guard
drush en ai_comment_guard -y
drush cr
```

Dependencies: core **`comment`** and **`system`** only. No sub-modules. `hook_install` prints a
"configure your Anthropic API key" message; until a key is saved, `hook_requirements` shows a
`REQUIREMENT_WARNING` on the Status Report (`/admin/reports/status`).

## Configure

Route **`ai_comment_guard.settings_form`** → `/admin/config/content/comment-sanitizer`
(menu link `ai_comment_guard.settings` under *Configuration → Content authoring*; note the actual
path is `comment-sanitizer`, not `ai-comment-guard`). Permission
**`administer comment sanitizer`** (`restrict access: TRUE`). Form class
`AiCommentGuardSettingsForm` writes config object **`ai_comment_guard.settings`**.

`validateForm()` requires the key to start with `sk-ant-` (a format check only). The key field is a
plain `textfield` with `autocomplete => off`.

### Config keys (`ai_comment_guard.settings`, from `config/install` + `config/schema`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `anthropic_api_key` | string | `''` | Anthropic Claude API key (`sk-ant-…`). Stored in this config object. |
| `sanitize_mode` | string | `flag` | Action for harmful comments: `flag`, `replace`, or `block`. |
| `auto_unpublish` | boolean | `true` | In `flag` mode, unpublish the flagged comment. |
| `replacement_text` | string | `[This comment has been removed for violating community guidelines.]` | Body used in `block` mode. |
| `sensitivity_level` | string | `medium` | `low` / `medium` / `high` — controls the prompt's strictness instructions. |
| `notify_author` | boolean | `false` | Email authenticated authors when their comment is actioned. |
| `log_violations` | boolean | `true` | Write flagged comments (severity + reason) to watchdog. |
| `custom_rules` | string | `''` | Plain-language rules appended to the AI system prompt. |

## Permissions (`ai_comment_guard.permissions.yml`)

- **`administer comment sanitizer`** (`restrict access: TRUE`) — access the settings form.
- **`bypass comment sanitizer`** — intended to let trusted roles skip moderation.

Operational note: `hook_comment_presave` checks `hasPermission('bypass ai comment guard')`, but the
permission actually defined is `bypass comment sanitizer`. The two strings do not match, so the
bypass check never returns TRUE and **every** user's comments are moderated regardless of the granted
permission. (This makes the module moderate more, not less.) To make bypass work, the permission
name in the hook and in `permissions.yml` must be aligned.

## Moderation flow (three hooks, one temp store)

1. **`hook_comment_presave`** → `AiCommentGuardService::sanitize()`
   - Runs only for new comments (`$comment->isNew()`) and only if the user lacks the bypass
     permission (see note above). Requires a configured API key and a non-empty body.
   - Calls `analyseWithAI()`; only a `is_harmful: true` verdict proceeds.
   - `storeIntent()` writes a `pending_flag` array (mode, auto_unpublish, cleaned_text,
     replacement, severity, reason) to `tempstore.private` namespace `ai_comment_guard`, and (if
     `log_violations`) logs a watchdog warning. The entity is intentionally **not** modified here —
     `CommentForm::save()` runs after presave hooks and would overwrite it.

2. **`hook_comment_insert`** → `applyStoredModeration()`
   - Consumes `pending_flag` (deletes it immediately to avoid double-fire).
   - Writes **directly to the database** (bypassing `$comment->save()`):
     - `replace`: updates `comment__comment_body` with `cleaned_text` (keeps the existing text
       format), stays published.
     - `block`: updates `comment__comment_body` with `replacement_text` and sets
       `comment_field_data.status = 0` (unpublished).
     - `flag` (default): body untouched; unpublishes if `auto_unpublish`.
   - Calls `resetCache([$cid])` so the next load reflects the DB change; stores a `message_flag`.
   - If `notify_author` and the author is authenticated → `notifyAuthor()` sends the
     `violation_notice` mail (`hook_mail` in the `.module`).

3. **`ai_comment_guard_comment_form_submit_last`** (appended in `hook_form_comment_form_alter`)
   - Reads `message_flag`, deletes all status messages, and adds the correct notice
     (edited / held-for-review / posted).

## The AI call (`analyseWithAI()`)

- POSTs to `https://api.anthropic.com/v1/messages` via `@http_client` (Guzzle), model
  `claude-sonnet-4-6`, `anthropic-version: 2023-06-01`, `max_tokens: 1024`, `timeout: 15`.
- System prompt = base moderation instruction + a sensitivity clause chosen by `match($sensitivity)`
  + optional `custom_rules`, then a fixed instruction to reply with a strict JSON object.
- User message = `"Evaluate this comment:\n\n{$text}"`.
- Response `content[0].text` is de-fenced (regex strips ```` ```json ```` blocks) and
  `json_decode`d into `{is_harmful, severity, reason, cleaned_text}`, which drives the action mode.

## Operating notes

- **Cost / egress:** every new comment triggers a paid Anthropic call and sends the comment body to
  Anthropic. Confirm this is acceptable for your content and privacy policy.
- **Text format:** in `replace`/`block` modes the new body is written with the comment's existing
  text format; output filtering still applies at render time as normal.
- **Change the model:** edit the `MODEL` constant in `AiCommentGuardService` (e.g. a Haiku model for
  lower cost). No config setting exists for the model.
- **Held comments** appear in the standard unpublished-comment admin list
  (`/admin/content/comment/approval`); pair with core `content_moderation` if you want a workflow.
