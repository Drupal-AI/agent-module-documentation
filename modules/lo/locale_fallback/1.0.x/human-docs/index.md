# Locale fallback — manual setup guide

**Locale fallback** (`locale_fallback`) lets you configure **inheritance between
languages** for interface (locale) translations. When a UI string has no
translation in the language a visitor is viewing, Drupal falls back to another
language; this module gives you finer control over that fallback chain than
core's default behaviour.

The practical effect is that a regional language can inherit from its base
language before finally falling back to English — for example `de-AT` (Austrian
German) can fall back to `de` (German), which in turn falls back to English. That
way, strings you have translated once for German are reused across all German
variants instead of dropping straight to English wherever a variant‑specific
translation is missing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module ships a config schema and a permission for managing the fallback
settings; the fallback relationships themselves are configured in the site's
language administration (see "How to use it").

## Where it lives in the admin menu

Locale fallback works within Drupal's core language and interface‑translation
systems, under **Configuration → Regional and language**. Once enabled, it lets
you define which language each language inherits from, so that untranslated
strings resolve up the chain you have set rather than jumping directly to the
default language.

## How to use it

1. Make sure the languages you want to relate are already added under
   **Configuration → Regional and language → Languages**.
2. Configure each language's fallback (the language it should inherit from),
   building the chain you need — for instance `de-AT` → `de` → English.
3. Test with a string that is translated in a base language but not in its
   regional variant: viewing the site in the variant should now show the base
   language's translation instead of English.
