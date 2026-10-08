# AI Content Assistant — manual setup guide

**AI Content Assistant** (`ai_content_assistant`) provides AI‑powered content
generation built around **reusable prompt patterns**. Rather than writing a fresh
prompt every time, editors work from prepared patterns to generate content
consistently, on top of Drupal's [AI](https://www.drupal.org/project/ai) module.

Use it to speed up authoring: draft, expand, or generate content for nodes with
the help of the AI provider, guided by the prompt patterns you set up.

Because generation sends your content and prompts to the configured AI provider,
it uses your provider credentials, incurs a per‑request cost, and is external data
egress — confirm that is acceptable. AI output should always be **reviewed** before
you publish it. Access is limited by the module's own permission; it has no
access‑control role beyond that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm an AI provider is configured.

## How to use it

With the module enabled and an AI provider configured, grant the AI Content
Assistant permission to the editors who should use it. They can then generate
content with the reusable prompt patterns while working on nodes, and review the
output before saving or publishing.

Depends on core **Node** and the **[AI](https://www.drupal.org/project/ai)** module
(`ai`). Works on Drupal 11.
