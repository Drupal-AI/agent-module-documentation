# Advanced Language Selector — manual setup guide

**Advanced Language Selector** (`advanced_language_selector`) provides a single
configurable block — the **Advanced language selector block** — that renders a
polished language switcher with flag icons on your multilingual site. Instead of
the plain list of links that core's language switcher gives you, you get a choice
of **eight built‑in display styles**: a Bootstrap dropdown, navigation tabs, a
modal, an offcanvas slide‑in panel, a list‑group, a button‑group, plus two
plain‑HTML options (a native `<select>` and a simple `<ul>` list) for
non‑Bootstrap themes.

The module registers one block plugin whose settings form is generated
dynamically from the chosen style, so the options you see match the style you pick.
Across the styles you can show flag icons, the language code (EN, ES), and/or the
full language name; set the flag icon height and its alignment; apply text
transformations (upper/lower/capitalize); add custom CSS classes; and style the
selected item differently from the rest. Flags come from roughly 269 bundled SVGs,
mapped from language code to country, with a fallback for anything unmapped. Each
link points at the translated URL of the current page.

The block only appears on multilingual sites and is rendered fresh each time (it is
uncacheable), so it always reflects the current page and language set. It has no
module dependencies, no permissions, no routes, and no separate configuration page
— everything is configured in the block's own settings form when you place it. The
Bootstrap styles can optionally load Bootstrap 5 from a CDN if your theme isn't
Bootstrap‑based. There are no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including how the style YAML
and templates work — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the block, pick a style, and set
   the flag and label options.

## Where it lives in the admin menu

There is no dedicated settings page. You place and configure the block under
**Structure → Block layout** (`/admin/structure/block`); look for **Advanced
language selector block** in the *Language block* category.
