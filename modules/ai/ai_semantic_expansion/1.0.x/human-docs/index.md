# AI Semantic Expansion — manual setup guide

**AI Semantic Expansion** (`ai_semantic_expansion`) makes your site search
smarter without building a whole vector-database stack. When content is indexed,
it asks an AI model to generate extra terms — semantic **synonyms** and likely
**search intents** — and folds those into the Search API index alongside the
original words. The upshot: a visitor who searches for "car" can still match a
page that only ever says "automobile", because the AI-derived synonyms were added
to the index.

Because the enrichment is just extra text stored in a normal Search API index,
you get semantic-style matching while staying **database-agnostic** — it works
with the standard Search API backends you already use, with no embeddings service
or vector database to run. It builds on two modules: Drupal's **AI** module
(which talks to your chosen AI provider) and **Search API** (which owns the
index).

The trade-off to keep in mind is cost and timing: the AI generation happens while
content is being indexed, so each reindex makes calls to your configured AI
provider, and those calls are billed by that provider. It supports Drupal 10.4
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside AI and Search API.
2. [Configuration](configuration/index.md) — turn the expansion on for a Search
   API index and reindex.

## How to use it

There is no site-wide switch to flip. The expansion is applied **per Search API
index**: on the index you want to improve, enable the AI Semantic Expansion
enrichment, save, and reindex so the AI-generated synonyms and intents are
written into the index. See [Configuration](configuration/index.md) for the
steps, and remember every reindex spends AI-provider credit.
