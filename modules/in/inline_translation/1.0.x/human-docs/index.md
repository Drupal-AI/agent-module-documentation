# Inline Translation — manual setup guide

**Inline Translation** (`inline_translation`) lets editors translate an entity into
multiple languages from a **single form**. Normally, translating content in Drupal
means saving the primary language, then switching to a separate *Translate* tab and
editing each language version on its own form. This module brings those translated
fields onto the entity's own **add/edit page** in the primary language, so an editor
can fill in the other languages right there — a real time‑saver when you are
translating a lot of content or want to keep the language versions in sync as you
write.

It builds directly on Drupal core's **Content Translation** configuration: it reads
which entity types, bundles, and fields you have marked as translatable and simply
presents their translations inline on the main edit form. In other words, it is a
**UI convenience** layered on top of the translation setup you already have — it
does not introduce a new way to control who may translate what. Translation
capability continues to be governed by core's content‑translation permissions, and
this module adds no access‑control role beyond its own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm your core multilingual setup.

The module has **no standalone settings page**: it works from your existing core
Content Translation configuration. See "How to set it up" below for the core steps
it relies on.

## Where it lives in the admin menu

Inline Translation does not add its own Configuration page. It relies on core's
multilingual configuration — **Configuration → Regional and language → Languages**
(`/admin/config/regional/language`) for the site's languages, and **Configuration →
Regional and language → Content language and translation**
(`/admin/config/regional/content-language`) for choosing which entity types,
bundles, and fields are translatable. Once that is in place, the inline translation
fields appear on the relevant entities' add/edit forms.

## How to set it up

1. Make sure core's **Language** and **Content Translation** modules are enabled
   (see [Installation](installation/index.md)).
2. Add the languages you need at **Configuration → Regional and language →
   Languages**.
3. At **Configuration → Regional and language → Content language and translation**,
   enable translation for the entity types and bundles you want, and tick the
   individual fields that should be translatable.
4. Grant the appropriate core content‑translation permissions (for example, the
   *Translate …* permissions) to the roles that will do the translating, plus the
   permission this module provides.
5. Edit a piece of translatable content — the translated fields now appear inline on
   the main edit form, so you can enter multiple languages in one place.
