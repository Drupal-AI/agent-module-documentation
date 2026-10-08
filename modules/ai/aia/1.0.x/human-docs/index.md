# AI Assistant (AIA) — manual setup guide

**AI Assistant (AIA)** (`aia`) is an AI‑powered Drupal configuration generator. You
describe the structure you want in natural language and it creates the
configuration for you — content types, fields, taxonomy, block content, Views,
and menu links — so a site builder can scaffold a site's shape by describing it
rather than clicking through the UI piece by piece.

Because it writes real configuration and structure onto your site, this is a
powerful, trusted‑builder tool rather than an everyday editor feature. Its
administration is gated by the `administer aia` permission — keep it to trusted
site builders and administrators. Every generation runs through the AI module's
configured provider, so it carries that provider's per‑call cost.

Treat its output as a first draft: review the generated content types, fields,
and Views before building content on top of them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

AIA's generation and administration are gated by the `administer aia` permission
(set under **People → Permissions**). The AI provider it uses is configured in
the **AI** module. Because it produces core configuration, its results appear in
the usual places — **Structure → Content types**, **Structure → Taxonomy**,
**Structure → Views**, and so on.

## How to use it

1. Make sure the **AI** module has a working provider.
2. Enable AIA and grant `administer aia` only to trusted site builders /
   administrators.
3. Describe the structure you want (for example a content type with specific
   fields, or a Views listing) and let AIA generate the configuration.
4. Review the generated content types, fields, taxonomy, blocks, Views, and menu
   links before relying on them.

> **This changes your site's structure.** Generation creates real configuration —
> use it on a development or staging environment first, and keep the permission
> restricted.
