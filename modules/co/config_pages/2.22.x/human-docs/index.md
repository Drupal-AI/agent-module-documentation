# Config Pages — manual setup guide

**Config Pages** (`config_pages`) gives you fieldable "singleton" pages for
site‑wide settings. Instead of hand‑coding a custom settings form every time you
need somewhere to store a phone number, a hero image, or a set of social links,
you build a **config page type** with Field UI — text, images, entity references,
multi‑value drag‑and‑drop lists, anything Field API offers — and then edit the one
shared page it produces.

Under the hood, each config page *type* is a configuration entity that acts as a
bundle, and the stored values live in a single `config_pages` content entity — one
per type (per context). You create a type at **Structure → Config pages**,
optionally mount it at a friendly admin menu path so clients can find it, add
fields to it via Field UI, and then edit the stored page. It replaces the common
hack of creating a throwaway content type just to hold one node of settings, and
makes a flexible nodequeue replacement when paired with an entity‑reference field
and Views.

Config pages are **context‑aware**: a pluggable context system lets one settings
page store a distinct set of values per language, per domain, or per any custom
context, with fallback values when a specific context has nothing saved. A
**Language** context ships in the box. You read values in code through the
`config_pages.loader` service or the `config_pages_config()` helper, render them in
Twig with a `config_pages_field()` function, expose them to Token as
`[config_page:…]` tokens, and get or set field values from the command line with
the module's Drush commands. It depends only on core's **Text** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating a config page type, adding
   fields, editing the page, setting up context, and permissions.

## Where it lives in the admin menu

Config pages are managed at **Structure → Config pages**
(`/admin/structure/config_pages`, route `entity.config_pages.collection`). Types
are listed under **Structure → Config pages → Types**, and a type with a custom
menu path also appears wherever you mounted it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Config pages** and create a **type** — see
   [Configuration](configuration/index.md).
3. Add fields to the type with Field UI, just like any content entity bundle.
4. Edit the resulting page and fill in your values.
5. Read those values wherever you need them — in Twig with `config_pages_field()`,
   as tokens, in code via the loader service, or via Drush.
