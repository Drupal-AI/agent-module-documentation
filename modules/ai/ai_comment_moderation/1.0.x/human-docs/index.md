# AI Comment Moderation — manual setup guide

**AI Comment Moderation** (`ai_comment_moderation`) moderates user comments with
AI (via OpenAI), flagging and filtering spam and abuse. It builds on Drupal's
[AI](https://www.drupal.org/project/ai) module to give a site AI‑assisted first‑
line defence against unwanted comments.

Use it wherever open commenting invites spam or abusive posts and you want an AI
step to catch them. The AI's judgement is assistive: you should review flagged
output rather than treat it as final, and decide how flagged comments are handled
on your site.

**Privacy matters here.** Moderation works by sending comment text to your
configured AI provider (OpenAI) over HTTPS — that is external data egress, and it
costs a request each time. Confirm that sending user‑submitted comment text to a
third‑party AI service is acceptable for your site before enabling it.

This module has no access‑control role of its own; its behaviour depends on how
you configure the AI provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** the upstream documentation for this module is thin, so this guide
> stays deliberately high‑level. Check the
> [project page](https://www.drupal.org/project/ai_comment_moderation) for the
> latest specifics before relying on it in production.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and configure the AI provider.

## How to use it

Once enabled and pointed at a configured AI provider, the module screens comments
through OpenAI and flags/filters spam and abuse. Because the AI output is
advisory, review flagged comments before acting on them. Configure the AI provider
(and its securely stored key) as described on the installation page.

Works on Drupal 10 and 11.
