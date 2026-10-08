# AI Translate — manual setup guide

**AI Translate** (`ai_translate`) adds one-click, AI-powered translation of your
content. On any translatable content entity, its **Translate** tab gains an **AI
translate** link next to each missing translation — click it and the module
sends the entity's field text to a large language model (through the **AI**
module's provider layer) and writes the result back as a proper Drupal
translation. It can translate the whole set of translatable fields, follow
entity references (paragraphs, referenced nodes) to a configurable depth, and it
also offers AI translation of interface (locale) strings.

The actual model, endpoint, and API key are **not** configured here — they live
in the AI module's provider configuration (for example, an OpenAI or Anthropic
provider you have already set up). AI Translate simply drives that provider for
the `translate_text` operation. Its own settings let you pick a default
translation prompt, override the model or prompt per target language, decide
whether new translations are created published or as drafts for review, and
control how deeply referenced entities are translated.

For bulk work there are two Drush commands (`ai:translate-entity` and
`ai:translate-text`), and for developers a `text_extractor` plugin type so custom
field types can define how their text is pulled out and put back. Three separate
permissions gate content translation, interface translation, and prompt
management.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the settings
keys, prompt entities, and Drush commands — read the sibling
[`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and configure an AI provider.
2. [Configuration](configuration/index.md) — the settings form, prompts,
   per-language overrides, permissions, and the Drush commands.

## Where it lives in the admin menu

The settings form sits at **Configuration → AI → AI Translate**
(`/admin/config/ai/ai-translate`) and needs the **Manage AI translation
prompts** permission. Day-to-day translation happens on each entity's
**Translate** tab.
