# AI SEO/GEO analyzer — manual setup guide

**AI SEO/GEO analyzer** (`ai_seo`) sends a node's rendered page to a large language
model and returns an actionable, on-page SEO audit — plus a **GEO** (Generative
Engine Optimization) audit that assesses how likely the page is to be found and
cited by AI search tools like Google's AI Mode, ChatGPT, and Perplexity. Each report
is saved against the node so you can revisit it and compare before and after edits.

It works through the [AI](https://www.drupal.org/project/ai) module: you configure
an AI provider (OpenAI, Anthropic, and so on) in the AI module, then choose which
provider and model powers SEO analysis here. The analyses themselves are defined by
**report type** config entities — eight ship by default (a full SEO analysis, plus
focused ones for topic authority, natural language/readability, link analysis,
headings and structure, Schema.org markup, AI citability, and agentic readiness) —
and you can edit their prompts, disable ones you don't want, or add your own custom
report type, all without writing code.

Editors trigger an analysis from a node's **"Analyze SEO"** operation link or from
an **"AI SEO/GEO Analysis"** sidebar on the node edit form, which can run a live
streaming analysis of unsaved draft content, analyze an individual text field inline
(when field buttons are enabled), or queue a background job to run on cron. Completed
reports are viewable at `/node/{node}/seo`. Four permissions separate who may *view*
reports from who may *generate* them.

> **Cost note.** Generating a report calls your configured AI provider's API, which
> **incurs usage costs**. The `create seo reports` permission gates who can trigger
> those paid calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the AI module with
   Composer, and enable it.
2. [Configuration](configuration/index.md) — configure the AI provider, pick the
   model, set permissions, and manage report types.

## Where it lives in the admin menu

The settings form sits at **Configuration → AI → AI SEO/GEO analyzer**
(`/admin/config/ai/seo`, permission **Administer ai seo**). Report types are managed
at `/admin/config/ai/seo/report-types` (permission **Administer ai seo settings**).
Saved reports for a node are at `/node/{node}/seo`.
