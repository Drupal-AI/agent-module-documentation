# AI Translator (ai_tmgmt) — manual setup guide

**AI Translator** (`ai_tmgmt`) makes any provider you have configured in the
**AI** module available to **TMGMT** — the Translation Management Tool — as a
translator. In other words, machine translation can be driven by a large
language model from *inside* Drupal's established translation-management
workflow: jobs, job items, review, and acceptance all stay exactly as they are.

The interesting part is the range of providers this opens up. Because the
translation goes through the AI module, you can use whichever LLM your site is
configured for — including a **locally hosted model through Ollama**. That
matters for confidentiality: the usual objection to machine-translating
unpublished content is that it leaves the building, and a local model removes
that objection entirely while keeping the same TMGMT workflow.

Three things are worth stating plainly. LLM translation is a **first draft for
review** — TMGMT's review/acceptance step is exactly where you enforce that, so
do not turn on auto-accept. Hosted providers **bill per token**, so the size of
a translation job is a direct cost. And quality **varies sharply by language
pair**, so evaluate it on the pairs you actually need rather than on a demo. The
provider, model, and credentials all live in the AI module (a secret, never in
plain config); this module contributes only the TMGMT translator plugin. Note
the release is a beta (`1.0.0-beta6`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside AI and TMGMT.
2. [Configuration](configuration/index.md) — add the AI translator inside
   TMGMT's translator collection and point it at your AI provider.

## Where it lives in the admin menu

There is no separate admin page for this module. You configure it as a
translator inside TMGMT, under **Administration → Translation → Providers**
(the TMGMT translator collection, `/admin/tmgmt/translators`).

## How to use it

Once the AI translator is added in TMGMT, create translation jobs the normal
TMGMT way and choose the AI translator as the provider. The LLM produces draft
translations that land in TMGMT's review step, where an editor checks and
accepts them before they go live.
