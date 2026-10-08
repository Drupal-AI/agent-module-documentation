# Entity Translation Unified Form — manual setup guide

**Entity Translation Unified Form** (`entity_translation_unified_form`), often
called **ETUF**, places every language's translatable fields **inline on a single
add/edit form** instead of Drupal's usual one‑form‑per‑language workflow. Drupal's
default is architecturally clean but editorially awkward: translating a page means
opening the source in one tab, the target in another, and copying between them —
and a field added later is easy to miss in some languages. A unified form puts them
together, so the translator sees the source alongside the field they're filling and
nothing is missed because everything is on one screen.

It offers two shapes, chosen per bundle. The **inline** mode (recommended when your
content has three or more languages) lists all translatable fields for all enabled
languages on one form. An optional **side‑by‑side** mode (recommended for exactly
two languages) shows source and translation columns next to each other, and a
**tabbed** mode is also available (see the project README for tabbed setup). It
supports several entity types — nodes, media, and paragraph entities (paragraphs
are partially supported).

There's no dedicated settings page of its own: you switch it on from Drupal's core
**content language** settings page, per entity type (see *How to use it* below). It
depends on core's **Content Translation** module.

Two things are worth checking on a real content model. First, saving becomes a
single operation across several translations, so validation, moderation state, and
revisioning apply to the *set* rather than to one language — test what happens when
one language fails validation and the others don't. Second, the form gets large:
thirty translatable fields across four languages is a hundred and twenty widgets on
one page, which is slow to render and hard to navigate. ETUF suits a small number
of languages and a moderate field count; beyond that the per‑language form it
replaces starts to look reasonable again. Also note it is **incompatible with the
Autosave Form module** — uninstall Autosave Form before using ETUF.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Content Translation.

There is **no separate settings form** for this module — you turn it on from
Drupal's core content language page, described in *How to use it* below.

## Where it lives in the admin menu

ETUF is switched on from the core **content language** page at **Configuration →
Regional and language → Content language and translation**
(`/admin/config/regional/content-language`). It adds checkboxes there for each
content‑translatable entity type.

## How to use it

1. Make sure the entity type is translatable and you have the languages you need
   enabled.
2. Go to **Configuration → Regional and language → Content language and
   translation** (`/admin/config/regional/content-language`).
3. Next to a content‑translatable entity type, enable **"Place all
   content‑translatable fields for all enabled languages inline on the node
   add/edit form."**
4. Also enable **"Replace node edit"** so that all fields remain accessible while
   editing in other languages.
5. If you prefer the two‑column layout for a two‑language site, enable the optional
   **side‑by‑side** editing for that bundle (and consult the README for the tabbed
   mode). When using side‑by‑side, put non‑translatable fields into details/groups
   to keep the layout tidy.

Now the add/edit form for that entity type shows all languages' translatable
fields together on one screen.
