# Config Pages — manual setup guide

**Config Pages** (`config_pages`) lets you build fieldable "singleton" admin
pages for site-wide settings — without writing a single custom form or
controller. Instead of hand-coding a settings form (or creating a throwaway
content type just to hold one node for the homepage hero, the footer text, or a
set of social links), you define a **config page type**, add fields to it with
the normal Field UI, and then edit one shared page.

It solves a very common Drupal pain point: giving content editors a clean,
purpose-built control panel for things that appear across the whole site —
contact details, banners, API keys, footer content, a "call to action" — that
they can update themselves. Because each page is a real fieldable entity, you get
every field type and widget, view modes and display settings, Views integration,
Token support, and a Twig helper for free.

Config Pages is also **context-aware**: with a pluggable context system you can
store a different set of values per language (a Language context ships in the
box), per domain, or per any custom context you write, with fallback values when
a specific context has nothing saved.

The module does nothing visible until you create your first config page type — so
it needs configuration to be useful. It depends only on core's **Text** module,
and version 4.0 targets Drupal 10, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a config page type, add
   fields, mount it in the menu, and set up context.

## Where it lives in the admin menu

Config Pages adds a **Config pages** library at **Structure → Config pages**
(`/admin/structure/config_pages`, route `entity.config_pages.collection`). From
there you create and manage config page *types* and edit the stored values. Each
type can also be mounted at its own custom menu path (for example
`/admin/config/site-information/homepage-settings`) so it lands somewhere that
makes sense to site administrators.

## How to use it

The key distinction is between a **type** (the definition — the bundle and its
fields, which is configuration) and the **page** itself (the single stored set of
values, which is content). You build the type once, then editors update the page
as often as they like. Field values are read back in code through the
`config_pages.loader` service, rendered in templates with the
`config_pages_field()` Twig function, exposed as `[config_page:*]` tokens, and can
even be placed as a block. This makes Config Pages a flexible modern replacement
for older patterns like Nodequeue when combined with an entity-reference field and
Views.
