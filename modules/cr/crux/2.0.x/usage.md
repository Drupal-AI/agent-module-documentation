Crux is an AI "mention bot": summon it by @mentioning a designated bot user inside CKEditor content or comments, and it queues a background job that generates a context-aware AI reply and posts it back to the thread.

---

Crux wires the `ckeditor_mentions` module, the `ai` provider abstraction, and `league/commonmark` together into a small mention-driven assistant. When a user mentions the configured bot user for the first time in a rich-text field, an event subscriber (`CruxMentionSubscriber`) records the mention, enforces per-user and global daily limits, and enqueues a `crux_mentions_response` queue item with a throttle timestamp. A queue worker (`CruxMentionsResponse`) later loads the source comment and its parent entity, assembles a chat context (primary entity title, a ~200-character body excerpt, up to three ancestor thread comments or the previous flat comment, and the mention text), calls the selected AI provider/model through the `ai` module, converts the returned Markdown to HTML, injects an inline @mention anchor for the original author, and saves the answer as a new comment (a threaded child when the field is threaded). Configuration lives at `/admin/config/ai/crux` (`administer crux settings`): AI provider and model, per-user and global daily mention limits, a throttle delay, the default system prompt, and an optional "delete bot content and user on uninstall" cleanup toggle. An install hook auto-creates the `crux` bot user; `hook_entity_access`/`hook_entity_predelete` protect that user from edit/delete while configured.

---

- Add an on-demand AI helper to threaded forum or comment discussions by mentioning `@crux`.
- Answer community Q&A questions inline where users summon the bot in a comment.
- Summarize a long node body when a user mentions the bot on the content.
- Provide context-aware follow-ups that reference up to three ancestor comments in a thread.
- Translate or rephrase a comment on demand by mentioning the bot with a request.
- Auto-reply to a mention as a properly threaded child comment (`pid`) in threaded comment fields.
- Reply as a flat comment on entities whose comment field is not threaded.
- Automatically @mention the original commenter at the start of the bot's reply.
- Throttle bot responses (default 5 minutes) so rapid edits are batched before the AI runs.
- Cap how many times one content author can summon the bot per day (`user_daily_mention_limit`, default 3).
- Cap total bot responses site-wide per day (`global_daily_limit`, default 50).
- Choose any configured `ai` module provider and model (OpenAI, Anthropic, etc.) for replies.
- Customize the bot's tone, formatting, and safety rules via the editable default system prompt.
- Run responses off the request via Drupal's queue/cron so posting stays fast for end users.
- Process pending replies manually with `drush queue-run crux_mentions_response`.
- React to abuse/limit conditions by subscribing to the `crux.user_daily_limit_exceeded` and `crux.global_daily_limit_exceeded` events.
- Dedicate a bot Drupal user account that can be pointed at any content type where comments are enabled.
- Preserve or purge all bot-authored nodes and comments (plus the bot user) at uninstall via a config toggle.
- Protect the bot user account from accidental edit/deletion while the module is configured.
- Mark prior bot-authored comments as `assistant` turns so the AI keeps conversational role continuity.
- Integrate with the `ai` module's provider form helper so provider-specific settings appear dynamically in the settings form.
