# TOC API — manual setup guide

**TOC API** (`toc_api`) is a developer framework for building a hierarchical,
numbered **table of contents** out of the heading tags (`h1`–`h6`) in a chunk of
HTML. It reads a document, finds the headings you asked for, gives each one a
unique anchor `id`, works out the numbering (1, 1.1, 1.2…), and hands back both a
navigation menu and a rewritten copy of the body with jump anchors and optional
"Back to top" links.

The important thing to understand up front: **TOC API does nothing to your
content on its own.** It is the engine, not the feature. Enabling it does not add
a table of contents to any page. Instead, other modules build on it — TOC filter,
TOC Twig Filter, and Footnotes are contrib examples — or you call its services
from a small custom module. The bundled **TOC API Example** submodule
(`toc_api_example`) shows exactly how that is done. If you are looking for a
"add a table of contents to my body field" feature with no code, you probably
want one of those downstream modules rather than TOC API by itself.

What you *can* set up through the admin UI are **TOC types** — reusable presets
that decide how a table of contents looks and behaves (which heading levels to
include, the numbering style, the anchor-id strategy, "Back to top" links, and so
on). Five come pre-installed and you can add your own. TOC API has no third-party
Composer or PHP dependencies, ships one permission
(*administer table of contents types*), and provides no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the service API,
the `Toc` value object, and the theme hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the example submodule.
2. [Configuration](configuration/index.md) — the **TOC types** admin screen and
   what each preset option controls.

## Where it lives in the admin menu

Once enabled, TOC API adds a **TOC types** collection at **Structure → TOC types**
(`/admin/structure/toc`, route `entity.toc_type.collection`). That is the only
screen the module exposes. Everything else — actually rendering a table of
contents onto a page — happens in code or through a downstream module.

## How to use it

TOC API is meant to be *called*. A typical flow in a small custom module: load a
TOC type preset, hand its options plus your HTML to the `toc_api.manager` service,
and if the result is "visible" (it has at least the minimum number of top-level
headings), render the navigation with `toc_api.builder`. Common uses include:

- Building an "On this page" jump menu for long documentation or policy pages.
- Auto-numbering headings as `1)`, `1.1)`, `1.2)`, or with roman/alpha styles.
- Giving every heading a stable, slugified anchor so sections are directly
  linkable, and adding "Back to top" links after each top-level section.
- Presenting a responsive table of contents: a tree outline on desktop, a
  select/jump menu on mobile.

The exact service calls, the `Toc` object accessors, and the `TocBlockBase` class
for exposing a TOC as a block are all documented in the
[`agent/`](../agent/start.md) references.
