# AI Translate LB Asymmetric — manual setup guide

**AI Translate LB Asymmetric** (`ai_translate_lb_asymmetric`) adds one-click AI
translation for **asymmetric Layout Builder** translations — the case where a
translated page can have a *different* layout per language, not just translated
text in the same layout. It lets editors translate that Layout Builder content
through the **AI Translate** module.

It depends on **AI Translate**, core's **Content Translation**, and the **Layout
Builder Asymmetric Translation** module (`layout_builder_at`) that provides the
per-language layouts. There is no settings page of its own; the translation
action appears in the Layout Builder / translation workflow once everything is
enabled.

The data-handling point is the same as for any AI translation: the content being
translated is **sent to the configured AI provider** — an external call, so
confirm it is acceptable, and note the provider key lives in the AI module's
configuration as a secret. Treat the result as a draft and **review AI
translations before publishing** rather than pushing machine output live
unchecked. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside AI Translate and Layout Builder Asymmetric Translation.

## Where it lives in the admin menu

There is no dedicated configuration page. The translation action appears where
you translate content that uses Layout Builder — in the node's **Translate** tab
and Layout Builder interface — once AI Translate and Layout Builder Asymmetric
Translation are set up.

## How to use it

With an AI provider configured in the AI module (key stored as a secret) and
asymmetric Layout Builder translation enabled on your content type, translate a
page and use the one-click AI action to fill in the target-language layout.
Because the content is sent to the provider, confirm the egress is acceptable,
and **review each translation before publishing** it.
