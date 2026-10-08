# Language Neutral URL Aliases — manual setup guide

**Language Neutral URL Aliases** (`language_neutral_aliases`) makes your URL
aliases global on a multilingual site. Out of the box, Drupal ties every path
alias to a language and picks the alias that matches the visitor's current
language — which surprises a lot of site owners who simply expect `/about` to be
`/about` no matter what language the page is being viewed in. This module removes
that coupling so a single alias applies to a page in every language.

There is nothing to set up. The moment you enable it, every *new* alias is saved
as language‑neutral (`langcode` = `und`, Drupal's "not specified" value), all
alias lookups ignore the active language, and Drupal stops auto‑creating a
separate alias each time you add a translation. The URL aliases admin list also
narrows to show only the neutral aliases that actually apply.

One thing to be aware of: aliases that already exist in your database with a
specific language become effectively hidden — they no longer resolve, no longer
appear on the node edit form, and drop off the admin list — but they are **not**
deleted. Uninstalling the module brings them straight back. If you are keeping
the module permanently, the maintainers suggest cleaning up those legacy rows by
bulk‑converting them to neutral:
`UPDATE path_alias SET langcode = 'und' WHERE langcode <> 'und';`. Also, on
translatable content the built‑in **URL alias** field must *not* be marked
translatable — a single shared alias can't be expressed as per‑translation
values.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings form, no permission, and no configuration page.
The module works purely by changing how aliases are stored and looked up, so the
only "using it" step is enabling it.

## How to use it

Enable the module and carry on managing aliases exactly as you normally would
(by hand on the *URL alias* field, or via Pathauto). Every alias you create from
that point on is automatically language‑neutral, so the same clean URL is served
to every visitor regardless of their chosen language. Because aliases no longer
need to vary by language, Pathauto patterns can drop any language tokens too. If
you are converting an existing multilingual site, run the bulk `UPDATE` shown
above once so your older aliases become neutral as well.
