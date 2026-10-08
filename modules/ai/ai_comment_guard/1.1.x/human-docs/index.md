# AI Comment Guard — manual setup guide

**AI Comment Guard** (`ai_comment_guard`) uses AI to detect and handle abusive,
offensive, or harmful language in Drupal comments. When a comment is submitted, it
is screened through an AI moderation step, and the module can act on anything the
AI flags — blocking it, holding it for review, or sanitising it — so sites with
open commenting see fewer toxic comments.

The result is automated first‑line moderation of your comment stream. Trusted
users can be exempted from screening, and administrators control how the module
behaves.

**Privacy matters here.** Screening works by sending the text of each submitted
comment to your configured AI provider — that is external data egress, and it
costs a request each time. Make sure sending user‑submitted comment text to a
third‑party AI service is acceptable for your site before you turn this on, and
tell your users if your policies require it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm an AI provider is configured.

## How to use it

Once the module is enabled and an AI provider is configured, incoming comments are
screened automatically and acted on (block / hold / sanitise) according to the
module's settings. Two permissions govern access:

- **Administer comment sanitizer** (`administer comment sanitizer`) — manage the
  moderation settings. Grant this only to trusted administrators.
- **Bypass comment sanitizer** (`bypass comment sanitizer`) — let a trusted role
  post comments without going through AI screening.

Depends on core **Comment** and **System**, and relies on a configured AI
provider. Works on Drupal 10 and 11.
