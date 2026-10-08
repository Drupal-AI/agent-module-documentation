# Asymmetric Menu Trees — manual setup guide

**Asymmetric Menu Trees** (`asymmetric_menu_trees`) lets a single menu have a
**different structure in each language**, instead of one shared tree whose labels
are merely translated.

Drupal's multilingual model assumes a menu is one structure and that each language
is a translation of the others — which holds only when the language versions of a
site really are translations of each other. Real multilingual sites often are not:
a university's English site serves international applicants while its
national‑language site serves domestic ones; a government site's minority‑language
version covers only the subset of services available in that language; a company's
regional sites carry different products. Forcing one tree then means either linking
to content that does not exist in a language, or dropping sections another language
needs. The usual workaround — a separate menu per language with a language
condition on each block — works but duplicates every shared item. This module lets
the tree differ where it must and stay shared where it can.

Two things follow that are worth keeping in mind. First, **a link to an
untranslated page is exactly the failure this module exists to prevent** — so the
value is realised only if the per‑language structures are actually maintained; an
uncurated asymmetric menu is just a symmetric menu with extra configuration.
Second, **navigation is part of what a site says it offers**: a section present in
one language and absent in another is a statement about who the site is for, so
each language's tree deserves an owner rather than being left to whoever last
edited the menu. It runs on Drupal 8 through 11 with no dependencies, and it has no
settings form of its own — it changes how the standard menu UI behaves.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. Asymmetric Menu Trees works through the normal
menu administration at **Structure → Menus** (`/admin/structure/menu`) — it changes
how menu links behave per language rather than adding a configuration screen.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)) on a
   site that already has multiple languages configured.
2. Edit your menus at **Structure → Menus** as usual. With the module enabled, the
   structure you build for one language no longer has to mirror the others — you
   can add, remove, or re‑parent links per language.
3. **Curate each language deliberately.** Give every language's tree an owner, keep
   shared items shared, and let the structures diverge only where the content and
   audience genuinely differ. That editorial discipline is what turns the feature
   into a benefit.
