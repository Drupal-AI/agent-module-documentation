# Language Fallback Fix — manual setup guide

**Language Fallback Fix** (`language_fallback_fix`) is a small piece of
multilingual infrastructure. On a Drupal site where content is not translated
into every language, Drupal falls back to another language so the visitor still
sees something — but core's fallback logic is limited in how far it can reach.
This module exposes the **Language Fallback API** extension so that other systems
can make smarter decisions about which language to show when a translation is
missing.

The module does nothing visible on its own. Its purpose is to make the Language
Fallback API available for other modules to use — most notably Search API, which
can then index content entities even where not every language has a fallback. It
is best thought of as a compatibility shim: the maintainers expect it to become
unnecessary once the corresponding Drupal core issue is resolved.

Because it is infrastructure with no settings and no security surface, there is
very little to do beyond installing and enabling it. The one thing worth
confirming is that your site's language fallback *order* matches your intent,
since that order governs which language a visitor sees for untranslated content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## Where it lives in the admin menu

Language Fallback Fix adds no admin page and no menu items. Once enabled, it
simply makes the Language Fallback API available to other modules. Your language
fallback order itself is managed by Drupal core under **Configuration → Regional
and language → Languages**.
