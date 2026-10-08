# Crux - The AI Mention Bot — manual setup guide

**Crux - The AI Mention Bot** (`crux`) lets you summon an AI assistant in Drupal
simply by mentioning it in content or comments — think of X's "Grok", but on your
own site. When a user `@`-mentions the bot (for example `@crux`) in a comment or a
piece of content, Crux reads the surrounding context, sends it to an AI model, and
posts the bot's reply back into the conversation. The result is smarter, more
interactive discussions: on-demand answers, summaries of long threads, or
translations.

Crux is **thread-aware** — in threaded comments, its reply appears in the right place
in the conversation, and when used in top-level content the reply comes back as a new
comment. It reads the comment thread or node body for context, so its answers are
relevant rather than generic. To keep things performant and avoid slowing down live
posting, the bot doesn't reply instantly: mentions are queued and processed on a
schedule (via cron or a Drush queue-runner command).

Because every mention triggers a call to a large language model, two things matter.
First, Crux relies on the **AI** module (`ai`) to talk to your chosen AI provider
(such as OpenAI), and that provider's credentials are stored securely — backed by an
environment variable through a Key entity, never committed. Second, **each mention
costs an API call**, so keep the permission to mention/comment and any rate limiting
tight to control cost. Crux also builds on **CKEditor Mentions**
(`ckeditor_mentions`) for the `@`-mention experience, and core **User** and
**System**. It supports Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — the full setup: the mentions text
   filter, the AI provider, the Crux settings, and the queue runner.

## Where it lives in the admin menu

Crux's own settings are at **Configuration → AI → Crux**
(`/admin/config/ai/crux`). Related setup lives on the AI module's configuration and
on your text formats at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).
