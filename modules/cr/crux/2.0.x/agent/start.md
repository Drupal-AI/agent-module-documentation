<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crux - The AI Mention Bot (crux) — agent index

Summon an AI bot by @mentioning a designated bot **user** inside CKEditor content or comments;
Crux queues a background job that generates a context-aware AI reply and posts it back to the
thread. Package `AI`. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 2.0.0.

**Dependencies (info.yml):** `ckeditor_mentions:ckeditor_mentions`, `ai:ai`, `drupal:user`,
`drupal:system`. **Composer:** `drupal/ai ~1.2.0||~2.0.0`, `drupal/ckeditor_mentions ~3.0.0`,
`league/commonmark ~2.7.0`.

## What it provides (from source)

- **1 config form / route:** `crux.settings` → `/admin/config/ai/crux`, form
  `Drupal\crux\Form\CruxSettingsForm`, requirement `_permission: 'administer crux settings'`
  (menu link under `ai.admin_settings`).
- **1 permission:** `administer crux settings` (`restrict access: true`).
- **1 event subscriber:** `CruxMentionSubscriber` (service `crux.event_subscriber.mention`),
  listens to `ckeditor_mentions` `CKEditorEvents::MENTION_FIRST`, enforces daily limits, enqueues.
- **1 queue worker plugin:** `CruxMentionsResponse` (id `crux_mentions_response`, cron time 30s) —
  builds the chat context, calls the AI provider, saves the reply comment.
- **2 module events + event objects:** `CruxEvents::GLOBAL_DAILY_LIMIT_EXCEEDED` /
  `USER_DAILY_LIMIT_EXCEEDED` (`CruxGlobalDailyLimitExceededEvent`,
  `CruxUserDailyMentionLimitExceededEvent`).
- **1 config object + schema:** `crux.settings` (bot_uid, limits, throttle, AI provider/model,
  provider config, delete_on_uninstall, default_system_prompt).
- **Hooks (crux.module):** `hook_entity_access` + `hook_entity_predelete` guard the bot user from
  edit/delete. **Install (crux.install):** auto-creates the `crux` bot user; optional cleanup on
  uninstall. No Drush commands. No new plugin *types*. No submodules.

## Solution docs

- **Install, the bot user, settings form, config keys & schema** →
  [config/settings.md](config/settings.md)
- **Mention → queue → AI reply pipeline (subscriber, worker, threading, context)** →
  [queue/mention-response.md](queue/mention-response.md)
- **Rate-limit events you can subscribe to** → [events/limit-events.md](events/limit-events.md)
