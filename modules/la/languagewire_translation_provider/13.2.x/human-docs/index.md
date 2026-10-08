# LanguageWire Translation Provider — manual setup guide

**LanguageWire Translation Provider** (`languagewire_translation_provider`) adds a
**TMGMT translator plugin** that connects your site to **LanguageWire**, a
professional (human) translation service. With it, content you queue in the
Translation Management Tool (TMGMT) can be sent to LanguageWire for translation and
returned into your site — so your editors work in the familiar TMGMT
"job / basket / checkout" flow while the actual translation is handled
professionally by LanguageWire.

It is an integration module. It depends on **TMGMT** and **Ultimate Cron** (which
processes the translation jobs), requires **PHP 8.1**, and lives in the Translation
Management package. It has no access‑control role of its own.

Two things matter for data handling, and they are the reason to set this up
deliberately. First, using it means the **content to be translated leaves your
site** and is sent to LanguageWire — external data egress that you should confirm
is acceptable for the content in question (especially anything sensitive or
personal). Second, it authenticates with **LanguageWire API credentials**, which
are secrets: store them via an environment variable rather than committing them,
and make sure the connection is over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it and
   its dependencies.
2. [Configuration](configuration/index.md) — create the LanguageWire provider,
   enter and safely store its credentials, and translate content.

## Where it lives in the admin menu

Once enabled, the provider is created and managed inside TMGMT at **Translation →
Providers** (`/admin/tmgmt/translators`). You then translate content from
**Translation → Sources** and manage jobs from **Translation → Jobs**.
