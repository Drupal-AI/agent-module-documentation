# AI Content Advisor — manual setup guide

**AI Content Advisor** (`ai_content_advisor`) runs a piece of content through an
AI model and returns recommendations for improving it — suggestions about
readability, SEO, tone, and completeness. It gives editors AI‑powered writing and
SEO advice without leaving Drupal.

The advice is exactly that: advisory. The module surfaces the AI's suggestions and
the editor decides what to act on; it does not change your content automatically.

Because it sends the content being analysed to your configured AI provider, it
uses your provider credentials, incurs a per‑request cost, and constitutes
external data egress — confirm that is acceptable for the content you'll be
analysing. Access is limited by the module's own permission; it has no
access‑control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm an AI provider is configured.

## How to use it

With the module enabled and an AI provider configured, grant the AI Content
Advisor permission to the editors who should use it. They can then run a piece of
content through the advisor and review the AI's recommendations (readability, SEO,
tone, completeness), applying whichever suggestions they judge worthwhile.

Depends on the **[AI](https://www.drupal.org/project/ai)** module (`ai`) and a
configured provider. Works on Drupal 10.3+ and 11.
