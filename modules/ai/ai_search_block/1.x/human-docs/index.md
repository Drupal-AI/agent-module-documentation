# AI Search Block — manual setup guide

**AI Search Block** (`ai_search_block`) provides a ready-made **block** for
AI-powered, natural-language site search. Where [AI Search](https://www.drupal.org/project/ai_search)
supplies the semantic-search backend, this module gives visitors somewhere to type
a question and see an answer drawn from your site's content — without you having to
build the search interface yourself.

It builds on the AI ecosystem, so the same governance points apply: the AI
provider key is a credential (keep it out of plain configuration), and queries —
along with the content being searched — are sent to the AI provider, which is a
data-governance consideration.

The module ships several optional submodules: **Extras** (`ai_search_block_extras`)
and **Header** (`ai_search_block_header`) extend the block's presentation, and the
**Log** / **Log Tag** submodules (`ai_search_block_log`, `ai_search_block_log_tag`)
record searches. Search queries can be sensitive, so if you enable logging, restrict
access to the log and set a retention approach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — place the block and point it at your
   AI provider and search index.

## Where it lives in the admin menu

The module provides a block, so you configure it where blocks are managed: **Block
layout** at **Structure → Block layout** (`/admin/structure/block`). Its behaviour
depends on a configured AI provider and an AI Search index.

## How to use it

With AI Search set up and indexing your content, enable this module, place the **AI
Search** block in a region (for example a sidebar or the header), configure which
provider and index it uses, and — if you need it — enable a logging submodule with
access restricted appropriately.
