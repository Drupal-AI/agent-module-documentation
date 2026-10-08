# AI Auto-reference — manual setup guide

**AI Auto-reference** (`ai_auto_reference`) uses AI to fill in your entity
reference fields for you. It analyses a piece of content and proposes — or
automatically sets — references to other related content on your site: related
articles, related topics, and the like. Instead of hand‑picking cross‑links every
time you publish, you let the AI suggest the connections.

It builds on Drupal's **AI** module and core's **Node** module. The AI module
supplies the provider that reads the content and works out which other entities are
relevant, and the results populate an ordinary reference field, which behaves as it
always does.

Because it **sends your content to the configured AI provider** to compute the
references, data leaves your site when the provider is cloud‑based — confirm that is
acceptable for the content involved. The provider credentials are handled by the AI
module as secrets, and the module adds its own permission so you control who may use
the feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

AI Auto-reference works on your content's reference fields rather than through a
single central screen, and it adds its own permission to gate who can use the
AI‑assisted referencing. It relies on a provider configured in the AI module.

## How to use it

1. Set up an AI provider in the AI module, with its key stored via the Key module.
2. Enable AI Auto-reference and grant its permission to the roles that should use
   it.
3. On content that has a reference field, let the module suggest or set the related
   entities. Because the suggestions still flow through the reference field's normal
   handling, you keep the usual control over what ends up saved.
