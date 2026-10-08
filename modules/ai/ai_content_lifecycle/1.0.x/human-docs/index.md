# AI Content Lifecycle — manual setup guide

**AI Content Lifecycle** (`ai_content_lifecycle`) helps you keep a site's content
fresh. Over time articles go stale — facts change, links rot, guidance is
superseded — but on a large site it is hard to know what needs revisiting. This
module uses AI to assess content and automatically **mark outdated content** for
review or refresh, giving editors a governance signal instead of relying on
memory.

It is an editorial-governance tool: rather than generating content, it watches the
content you already have and flags what looks stale, so your team can prioritize
updates. It builds on the Drupal **AI** module and provides its own permission to
control who can use it.

Because assessing content means sending it to the configured AI provider, the text
being evaluated leaves your infrastructure — and that content can be unpublished
or sensitive, so confirm this is acceptable before turning it on. The AI provider
credentials are managed as secrets by the AI module, never in plain config. The
module works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI module and a provider are in place.

## How to use it

The module adds its own permission; grant it to the editors or content managers
responsible for content freshness, and keep it away from roles that should not
trigger AI calls. Once enabled and pointed at a configured AI provider, the module
assesses content and marks items it judges outdated so they surface for review.
Treat the "outdated" flag as advice: a human decides whether to refresh, rewrite,
or leave the content as-is. Remember that every assessment is a billed AI call and
sends the content to the external provider.
