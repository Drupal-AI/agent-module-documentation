# AI Translate Paragraph Asymetric — manual setup guide

**AI Translate Paragraph Asymetric** (`ai_translate_paragraph_asymetric`)
provides simple **one-click AI-powered translation for asymmetric paragraphs** —
paragraphs where the translated structure can differ from the source rather than
mirroring it exactly. With a single action it translates paragraph content,
which makes multilingual editing of paragraph-based pages much quicker.

It uses the **AI Translate** module's translate service (`ai_translate`) to do
the work, so there is no settings page of its own — the translate action appears
in the paragraph translation workflow once AI Translate is set up.

The privacy-relevant point is that paragraph content is **sent to the configured
AI provider** for translation, so treat that content as leaving the site — a
data-handling consideration for anything sensitive. Store the provider
credentials as secrets (via the AI / Key modules). Access is governed by
Drupal's normal translation permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside AI Translate.

## Where it lives in the admin menu

There is no dedicated configuration page. The one-click translate action appears
in the content **Translate** workflow for paragraph-based content, once AI
Translate has a provider configured. Who can use it is controlled by Drupal's
standard content-translation permissions.

## How to use it

With an AI provider configured in the AI module (credentials stored as secrets),
open the translation for a piece of paragraph-based content and use the
one-click AI action to translate the paragraphs into the target language.
Because the content is sent to the provider, confirm the egress is acceptable
for the content, and review the result before publishing.
