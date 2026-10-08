# Search by current language — manual setup guide

**Search by current language** (`search_current_language`) fixes a common annoyance
on multilingual sites: Drupal core's node search returns results in every language at
once, regardless of the language the visitor is browsing in. This module forces core
node search to return only results in the visitor's **current interface language**
(plus language-neutral content), and it hides the language filter from the advanced
search form so users don't have to think about it.

It's a tiny, zero-configuration module — just two small alterations. It narrows the
core search query to the active language plus the "undetermined" (`und`) and "not
applicable" (`zxx`) neutral codes, so language-neutral content still appears in every
language's results. And it removes the "Languages" filter from the advanced node
search form. The current language comes from Drupal's language manager, so whatever
language negotiation your site uses (URL, session, interface) automatically drives
which results appear.

One important scope note: this affects **core Search only** (the core Search module's
node search) — it does **not** change Search API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page, no permissions, and nothing to configure. The
behaviour is automatic as soon as the module is enabled.

## How to use it

Just enable it. On a multilingual site with core Search, node search results are then
scoped to the current language (plus neutral content), and the language filter
disappears from the advanced search form. There is nothing else to set up. It's a
drop-in fix for the "core node search ignores current language" problem, and it works
alongside your existing language switcher and negotiation.
