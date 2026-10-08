# RUA — Remove Uppercase Accents — manual setup guide

**RUA — Remove Uppercase Accents** (`rua`) fixes a typography rule that catches out
non‑Greek developers. In modern Greek, a lowercase word carries a *tonos* (accent)
on its stressed vowel — for example *Ελλάδα* — but the uppercase form drops it:
*ΕΛΛΑΔΑ*, not *ΕΛΛΆΔΑ*. When a site uppercases text with CSS
(`text-transform: uppercase`), the browser doesn't know this rule, so every
uppercase Greek heading, button, and menu item comes out visibly wrong to a Greek
reader — with accents that shouldn't be there.

This module adds a small JavaScript script that runs when the page is ready. It
finds text uppercased through CSS (rules using `text-transform: uppercase` and
`font-variant: small-caps`) and strips the incorrect accents from the Greek
characters. It works out of the box once enabled, with nothing to configure. The
script is written for Greek but, as the project notes, can be adapted to other
languages.

Two things worth knowing: the fix happens **in the browser**, so it doesn't change
what is stored in the database, what search indexes, or what a reader copies out of
the page (the original, correctly accented text is preserved underneath). And where
you can, the more durable fix is to declare the language correctly with
`lang="el"` and let the browser apply its own Greek casing rules — this module
covers the common Drupal cases where per‑string `lang` isn't present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. It works automatically once
enabled, described in "How to use it" below.

## How to use it

There's nothing to set up beyond enabling the module. Once it's on, its JavaScript
loads on the front end and, on page ready, removes the stray accents from Greek text
that your theme or CSS has uppercased. To see it, visit a page with uppercase Greek
headings or menu items and confirm the accents are gone from the capitalised words.
