# Drush language negotiation — manual setup guide

**Drush language negotiation** (`drush_language_negotiation`) fixes a specific,
annoying problem on multilingual sites: when you run Drush from the command line,
Drupal sometimes resolves the *wrong* language. The classic symptom is importing
configuration (say, a Webform config file) on a site whose default language is
Dutch, only to find Drush behaving as though the site were English. This module
forces the site's default language whenever code runs under the CLI, so Drush
imports, cron, content generation, and translation tasks all use the language you
intended.

It works by adding one language-negotiation method. That method returns the site
default language id when the code is running under the command line
(`PHP_SAPI === 'cli'`) and does nothing otherwise — so ordinary web and browser
requests keep their normal language negotiation and are completely unaffected. The
method is given a very high priority so that it wins for CLI runs once you enable
it.

The module has no routes, permissions, services, or configuration of its own —
it is purely a negotiation plugin, and it has no security surface. You do have to
turn its method on and prioritise it, but that happens on Drupal core's existing
language detection page, not on a settings form of the module's own. It supports
Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and turn on its negotiation method.

There is **no settings form** of the module's own — you activate it on core's
language detection page, described under "How to enable the method" below.

## Where it lives in the admin menu

You configure it on Drupal core's **Configuration → Regional and language →
Languages → Detection and selection** page
(`/admin/config/regional/language/detection`).

## How to enable the method

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Regional and language → Languages → Detection and
   selection** (`/admin/config/regional/language/detection`).
3. Enable the **Drush Language Switching** method that this module adds.
4. Make sure it is prioritised (ordered high enough) so that it wins for CLI runs,
   then save.

From then on, Drush operations resolve to the site's default language instead of
falling back to English, while your website's front-end language negotiation
continues to work exactly as before.
