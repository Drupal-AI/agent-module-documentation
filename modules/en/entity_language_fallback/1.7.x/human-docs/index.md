# Entity Language Fallback — manual setup guide

**Entity Language Fallback** (`entity_language_fallback`) lets you define, per
language, a prioritised list of *fallback* languages that Drupal falls back to when
an entity has no translation in the requested one. Out of the box, a page with no
translation in the visitor's language drops straight to the site default. With this
module you can instead say, for example, "for Norwegian, try Danish first, then
English" — so a missing translation is shown in the next best language rather than
an abrupt jump to the default.

Configuration isn't on a page of its own: for each language you set "Priority 1, 2,
3…" fallback languages directly on the **language edit form**. The module then
applies that chain whenever an entity is viewed or upcast from a route, replacing
Drupal core's fallback candidate list with yours. Because the translation that
actually renders may differ from the page's language, the module also re-checks
access against the fallback entity so core access handlers behave correctly.

It depends only on core's **Language** module and has no permission or settings
route of its own (editing languages already requires *Administer languages*). It
also ships optional **Search API** integration — a fallback datasource plus index
tracking — so untranslated content still gets indexed and can be found under a
fallback language. A programmatic service (`language_fallback.controller`) is
available for custom code that needs the best available translation of an entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Language.
2. [Configuration](configuration/index.md) — setting per-language fallback chains
   on the language edit form, and when they apply.

## Where it lives in the admin menu

There is no dedicated settings page. Fallbacks are configured **per language**
under **Configuration → Regional and language → Languages**
(`/admin/config/regional/language`) — edit a language and use the **Entity fallback
language** section that the module adds to that form.
