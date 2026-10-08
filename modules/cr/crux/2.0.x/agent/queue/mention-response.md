<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crux — mention → queue → AI reply pipeline

Two classes implement the flow: `CruxMentionSubscriber` (enqueue) and the `CruxMentionsResponse`
queue worker (generate + post).

## 1. Enqueue — `src/EventSubscriber/CruxMentionSubscriber.php`
Service `crux.event_subscriber.mention`; subscribes to `ckeditor_mentions`
`CKEditorEvents::MENTION_FIRST` → `onFirstMention(CKEditorMentionsEvent $event)`. Steps:
1. Read `crux.settings`; if `ai_provider_id` is empty, log a warning and return.
2. `$event->getMentionedEntity()` must be a `user` whose id equals `bot_uid` (else return — not
   the bot).
3. `$event->getEntity()` must implement `EntityOwnerInterface`; the author id is
   `$source->getOwnerId()`.
4. **Daily counters** live in Drupal `state` key `crux.daily_counts`
   (`['date' => Ymd, 'global' => n, 'users' => [uid => n]]`), reset when the stored date != today
   (`date('Ymd', request_time)`).
5. Enforce limits: if `global_daily_limit > 0` and reached → log + dispatch
   `CruxGlobalDailyLimitExceededEvent` + return. If `user_daily_mention_limit > 0` and reached for
   the author → log + dispatch `CruxUserDailyMentionLimitExceededEvent` + return.
6. Otherwise `createItem()` on queue `crux_mentions_response` with
   `['entity_type', 'entity_id', 'throttle_after' => request_time + throttle_response_time*60]`,
   then increment and persist the global + per-user counters.

## 2. Generate + post — `src/Plugin/QueueWorker/CruxMentionsResponse.php`
`@QueueWorker(id="crux_mentions_response", cron={time=30})`. `processItem($data)`:
1. **Throttle:** if `throttle_after > now`, throw `DelayedRequeueException` (retry later).
2. Load the source entity (`entity_type`/`entity_id`). Missing → warning + return. **Only
   `CommentInterface` is handled**; a non-comment entity is logged and skipped. The mention text
   is `strip_tags($comment->get('comment_body')->value)`.
3. Read `ai_provider_id`/`ai_model_id`; if either missing → error + return. Instantiate the
   provider via `AiProviderPluginManager::createInstance()` and
   `$provider->setConfiguration($config->get('ai_provider_configuration'))`.
4. **Primary context:** parent (commented) entity `label()` as "Primary content title" and a
   `mb_substr(strip_tags(body), 0, 200)` excerpt.
5. **Threading detection:** loads `field_config` `{entity_type}.{bundle}.{comment_field}`; threaded
   when `default_mode === CommentManagerInterface::COMMENT_MODE_THREADED`.
6. **Thread context messages:** if threaded, `buildParentThreadMessages()` walks up to 3 ancestors
   via `pid`, oldest-first, each a `ChatMessage` (`assistant` if the ancestor author is the bot,
   else `user`, body `mb_substr(...,0,400)`). If flat, `buildPreviousFlatCommentMessage()` adds the
   single previous comment on the same entity/field (entity query, `created < current`,
   `accessCheck(FALSE)`, range 1).
7. Append a final `user` `ChatMessage` with primary context + "Mention content:".
8. Build `ChatInput($messages)`, `setSystemPrompt($config->get('default_system_prompt'))`, call
   `$provider->chat($input, $model_id, ['crux'])->getNormalized()` (errors caught + logged).
9. **Render:** `(new League\CommonMark\CommonMarkConverter())->convert($response->getText())` →
   HTML, then `addAuthorMentionInline()` prepends a `ckeditor_mentions`-style `<a class="mention">`
   anchor for the original author (display name run through `Html::escape`, a fresh UUID, the
   author's canonical URL) — inserted inside the first `<p>` when present, else prepended. Skipped
   if the author is missing or is the bot.
10. **Post:** `createReplyComment()` creates a `comment` on the parent entity, same
    `field_name`/`comment_type`, `uid = bot_uid`, subject `"Re: <subject>"`, body
    `['value' => $reply_html, 'format' => 'full_html']`, status 1, and `pid = original id` when
    threaded, then `save()`.

## Notes
- The AI call goes through the `ai` module's provider abstraction (no direct HTTP/TLS handling in
  Crux); API-key/credential management belongs to the selected `ai` provider, not this module.
- Reply generation is asynchronous: run cron or `drush queue-run crux_mentions_response`.
- The bot only auto-replies to **comment** mentions; a mention on non-comment content is queued but
  skipped by the worker with a notice.
