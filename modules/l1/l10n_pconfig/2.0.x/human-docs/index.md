# Localization Plural Config — manual setup guide

**Localization Plural Config** (`l10n_pconfig`) lets you set the correct
**plural formula** for each language on your site. Many languages form plurals in
ways English speakers don't expect: some have one plural form, some have several,
and the rule for *which* form applies to a given number varies from language to
language. When the plural rule stored for a language is wrong, translated plural
strings (the ones that read differently for "1 item" versus "5 items") render
incorrectly. This module fixes that.

It does two things. When you add a new language it fills in a sensible default
plural formula for you, and it exposes the plural formula for editing on the
language interface — something Drupal core deliberately hides because getting a
formula wrong is easy and the consequences are subtle. It depends only on core's
**Interface Translation** (`locale`) and **Language** (`language`) modules and
lives in the Multilingual package.

Because a bad formula quietly breaks plural rendering across the whole site, treat
the ability to edit these values as a privileged task. Only grant language‑editing
permissions to people who understand plural forms and won't accidentally scramble
them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings page** for this module. Once enabled, it works by
adding the plural‑formula fields directly to Drupal's own language screens, so you
configure formulas per language from there — see "How to use it" below.

## How to use it

1. Go to **Configuration → Regional and language → Languages**
   (`/admin/config/regional/language`).
2. Add a language, or edit an existing one. With Localization Plural Config
   enabled, the language add/edit form now includes the **plural formula** fields.
   For a newly added language the module pre‑fills a sensible default.
3. Adjust the number of plural forms and the formula only if you know the correct
   rule for that language, then save. The updated formula takes effect for plural
   translations of that language immediately.
