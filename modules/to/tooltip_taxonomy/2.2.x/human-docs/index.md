# Tooltip Taxonomy — manual setup guide

**Tooltip Taxonomy** (`tooltip_taxonomy`) turns your taxonomy terms into
glossary‑style tooltips. Wherever a term's name appears in your content's text —
say the acronym "CMS" turns up in an article body — the module quietly wraps it
so that hovering (or keyboard‑focusing) it reveals the term's description in a
little pop‑up bubble. Your editors write the definitions once, as ordinary
taxonomy term descriptions, and the tooltips appear automatically across the
site.

You control where and how this happens with **filter conditions** — small rules
you create in the admin UI. Each rule picks one or more vocabularies and then
scopes them: only on certain paths, only for certain content types, only in
certain view modes, only in specific fields, and only for chosen text formats.
Rules also carry a weight, so you can give a term a broad definition site‑wide
and override it with a narrower one on specific pages (handy for ambiguous
terms). There is no JavaScript — the tooltips are pure CSS and work on hover and
keyboard focus.

The module also ships a **field formatter** called *Tooltip Taxonomy*. If you
have an entity‑reference field pointing at taxonomy terms, you can choose this
formatter on the field's *Manage display* tab to render each referenced term as
a tooltip. Term descriptions are sanitized before display, so editor‑supplied
markup cannot inject scripts.

Tooltip Taxonomy depends only on Drupal core's **Filter** and **Field** modules.
One thing to remember: for the automatically injected tooltips to survive
text‑format filtering, the text format used by your content must allow the
tooltip markup (`<span class="tx-tooltip tx-tooltip-text">`) in its Allowed HTML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — creating filter conditions, scoping
   them, the field formatter, and the text‑format allowance you need.

## Where it lives in the admin menu

The tooltip rules live at **Configuration → Content authoring → Tooltip
Taxonomy** (`/admin/config/content/tooltip_taxonomy`), where you list, add, edit,
delete, and re‑order your filter conditions. The pages are open to anyone with
either **Administer site configuration** or **Administer filters**.

## How to use it

1. Enable the module and make sure the vocabulary you want to use has terms with
   descriptions filled in.
2. Create a filter condition (see [Configuration](configuration/index.md)),
   choosing the vocabulary and the text formats it applies to, plus any path,
   content‑type, view‑mode, or field scoping.
3. Make sure the relevant text format allows the tooltip markup.
4. View a piece of content that mentions one of your terms and hover over it —
   the definition appears.
