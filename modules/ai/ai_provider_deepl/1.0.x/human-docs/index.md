# DeepL Provider — manual setup guide

**DeepL Provider** (`ai_provider_deepl`) connects Drupal's AI module to
**DeepL**, the machine-translation service. Unlike the general-purpose LLM
providers in this family, this one is aimed squarely at **translation**: it lets
the AI module (and translation workflows built on it) produce translated text
using DeepL's engine. DeepL is widely regarded as the strongest general-purpose
engine for European language pairs, and it is a **German** company processing in
the **EU** — which can matter for data-residency reasons.

The most important thing to decide before turning it on is how the output is
used. Machine translation as a **first draft** for a human translator to review
is a fast, defensible workflow. Machine translation published raw, in a language
nobody on the team reads, is a commitment to whatever the model produced under
your organisation's name. Treat translated content as content: give it the same
review and ownership as anything else.

Two practical notes. The content you translate **leaves the site** to DeepL, so
unpublished material and personal data in what you send is a disclosure to a
processor. And DeepL supports **glossaries** — an organisation's own terms,
product names and legal phrasing are exactly where a general engine goes wrong,
so a serious translation programme should use glossaries rather than the default
vocabulary. The DeepL API key is stored via the **Key** module, env-backed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — supply your DeepL API key on the
   provider settings form, and choose Free vs Pro.

## Where it lives in the admin menu

This provider has its own settings form
(`ai_provider_deepl.settings_form`), reached from the AI module's provider
settings under **Configuration → AI** (`/admin/config/ai`).

## How to use it

Sign up for a DeepL API plan (Free or Pro), enable this module, store your DeepL
API key as a Key entity, and enter it on the DeepL provider settings form. Then
use DeepL through the AI module's translation features — ideally as a reviewed
first draft, with a glossary configured for your organisation's terms. This is an
**alpha** release; requires Drupal 10.2 or 11.
