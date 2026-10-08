# Canvas Multilingual — manual setup guide

**Canvas Multilingual** (`canvas_multilingual`) makes **Canvas**, Drupal's
Experience Builder page builder, work properly on a translated site. Page
builders and translations pull in different directions — a layout is stored on
one entity, but each translation is a separate entity — so a visual editor has to
decide what a layout means across languages, and several small things break along
the way. This module is the set of fixes for those rough edges.

The clearest way to understand it is to read its feature list as a list of the
problems it addresses: **language‑prefixed URLs** in the editor, an **autosave
fix** so saving in one language behaves correctly with translations, a **preview
title fallback**, **translation guards** against cross‑language edits, and a
**language switcher** inside the editor. Install it when you are putting Canvas on
a multilingual site; reach for it when a Canvas page is misbehaving in a second
language.

Be aware this is early, active work on a genuinely hard problem — it is marked
**experimental** and released as **1.0.0‑beta1**. Do not assume behaviour: on a
real multilingual project, verify the specifics you depend on — whether a layout
is shared across languages or held per‑language, what an autosave in one language
does to another, and what a translator actually sees in preview.

> **A note for local development.** During documentation, the required `canvas`
> module could not be kept enabled on a standard development image. Canvas checks
> every Single‑Directory Component on the site, and where a component's example
> data does not resolve, it hits a PHP assertion that aborts the container when
> `zend.assertions` is on — the default in DDEV and most dev images. Production
> PHP compiles assertions out, so this is a development‑environment issue, but it
> is worth knowing before you try to install Canvas locally.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Canvas plus core translation modules are required).

## Where it lives in the admin menu

Canvas Multilingual adds no settings form of its own. Its behaviour shows up
inside the Canvas editor (the language switcher, the corrected autosave and
preview behaviour, and the translation guards) and in how translated Canvas pages
are served (language‑prefixed URLs).

## How to use it

Set up multilingual as usual — enable core **Language** and **Content
Translation** and configure your languages and translatable entities — then
enable this module. From then on, edit and translate Canvas pages in the builder;
use the in‑editor language switcher to move between languages. Because it is
experimental, test your translation workflow end to end before relying on it.
