# Analyze AI Sentiments — manual setup guide

**Analyze AI Sentiments** (`analyze_ai_sentiments`) is a submodule of the
[Analyze](https://www.drupal.org/project/analyze) content-analysis framework. It uses a
configured AI provider to assess the **sentiment** — the emotional tone — of your
content, and surfaces that assessment inside the Analyze report so editors can gauge how
a piece of content or feedback reads.

The module sends content to your site's AI provider for analysis, so two things are
worth keeping in mind. First, the provider's API key is a credential — keep it out of
plain configuration. Second, the content you analyze leaves your infrastructure and is
sent to the provider, which matters for confidential material. The sentiment output is
advisory, and each analysis is an API call, so keep an eye on cost.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — connect an AI provider, enable the analyzer
   per content type, and the privacy points to weigh first.

## Where it lives in the admin menu

Sentiment results appear on the **Analyze** report tab of an entity, alongside other
Analyze plugins. The AI provider is configured at **Configuration → AI → Providers**
(`/admin/config/ai/providers`), and the analyzer is enabled per content type from the
Analyze settings at **Configuration → Content → Analyze settings**
(`/admin/config/content/analyze-settings`).

## How to use it

Once an AI provider is configured and the analyzer is enabled for a content type, open a
node of that type and look at its **Analyze** report to see the AI's sentiment
assessment. Enable it only where AI sentiment analysis is genuinely useful, and keep it
disabled elsewhere to avoid unnecessary API calls.
