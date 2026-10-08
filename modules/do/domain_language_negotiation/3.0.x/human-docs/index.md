# Domain Language Negotiation — manual setup guide

**Domain Language Negotiation** (`domain_language_negotiation`) adds a language
detection method that picks the site language from the
[Domain](https://www.drupal.org/project/domain) module's **domain record**, so
each domain in a Domain Access installation serves its own language.

Drupal can already negotiate language from a URL prefix, a domain, the session,
the user or the browser, and its built-in domain method matches on a hostname list
you maintain in the language settings. On a Domain Access site, though, the domains
are *already* modelled as entities with their own configuration — so duplicating
the hostname list in the language settings just gives you two places to update and
one to forget. This module negotiates directly from the domain record instead, so
adding a domain and setting its language is a single operation and the language
settings stay in step automatically.

A worked example from the module's own documentation: say you have English and
Dutch enabled, and two domains — Domain 1 set to English only and Domain 2 set to
Dutch only (using the domain language settings). Without a detection method tied to
those settings, Domain 2 could still come up in English. This module supplies the
missing detection step so each domain resolves to its intended language.

The single thing that decides whether it works well is **negotiation order**.
Drupal applies detection methods in a configured sequence and the first that
resolves wins, so this method must sit *above* session and browser detection —
otherwise a returning visitor's saved session language overrides the domain, and a
French domain ends up serving English. That is the first thing to check if the
behavior ever looks wrong. It is also worth checking how it interacts with the
`domain_language` functionality, which operates on the same axis (from release
3.0.0 that module's capabilities are integrated here, so it is no longer a separate
dependency).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside core
   Language and the Domain module) and enable it.
2. [Configuration](configuration/index.md) — enabling the negotiation method and,
   crucially, getting its order right.

## Where it lives in the admin menu

There is no dedicated settings page. You enable and order the detection method on
Drupal's core language page at **Configuration → Regional and language → Languages
→ Detection and selection** (`/admin/config/regional/language/detection`), and you
set each domain's language on the domain records under **Configuration → Domain**.
