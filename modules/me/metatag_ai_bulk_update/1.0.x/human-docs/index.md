# Bulk Metatag AI Generator — manual setup guide

**Bulk Metatag AI Generator** (`metatag_ai_bulk_update`) generates SEO meta tags —
title, description, keywords, and abstract — for many nodes at once using AI.
Where the [Metatag AI](https://www.drupal.org/project/metatag_ai) module fills in
meta tags one node at a time, this module runs a **single bulk operation** across
your whole content library, so you don't have to open and edit each node by hand.
It works with any provider configured in the **AI Core** module — OpenAI,
Anthropic, Ollama, and others.

It is built for oversight and scale. By default it uses a **human approval
workflow**: AI suggestions are stored for review, and you can approve, reject,
edit, or delete them individually or in bulk before they touch your content. Large
libraries are processed safely in chunks via Drupal's Batch API, and you can filter
by content type, target a specific language (or all languages on a multilingual
site), cap how many nodes run per batch, and skip nodes that already have meta tag
values. A results dashboard shows successes and errors, and you can export a CSV
report. Optionally an auto-apply mode writes tags directly, with a second AI pass to
validate them first.

It depends on the **Metatag AI** and **AI Core** modules. Because it sends node
content to your AI provider to generate the tags, mind the privacy and cost
implications: this is external egress, generation runs can cost money, and the AI
provider key must be stored as a secret through the AI/Metatag AI configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Metatag AI / AI Core dependencies.
2. [Configuration](configuration/index.md) — set up the AI provider, configure
   Metatag AI, then run and review the bulk update.

## Where it lives in the admin menu

The bulk update runs from **Administration → Configuration → Content → Metatag AI →
Bulk Metatags Update Using AI** (`/admin/metatag-ai-bulk-update`). See
[Configuration](configuration/index.md) for the prerequisites you must set up first
and a field-by-field walk-through of the run form.
