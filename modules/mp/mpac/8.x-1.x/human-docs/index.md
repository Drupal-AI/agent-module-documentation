# Multi-Path Autocomplete — manual setup guide

**Multi-Path Autocomplete** (`mpac`, formerly "Menu path autocomplete") replaces
plain path-entry text fields with **autocomplete** fields, so editors don't have
to know Drupal's internal system paths. Instead of typing something like
`/node/42`, they start typing the **title** of the page they want to link to and
pick it from a live list of matching results — and the module inserts the correct
internal link for them.

On Drupal 8 and later it enhances the path field when **adding or editing a menu
item**. (The module's Drupal 7 version also covered URL aliases and shortcut
items; on Drupal 8+ the menu-item field is the section it alters.) As you type,
you get a list of matching node titles — and, if the core Path module is enabled,
matching URL aliases too — and selecting one inserts the internal link to it.

A nice detail: the autocomplete reuses Drupal core's entity-reference **selection
plugins**, which means it respects **entity access**. Results are limited to
content the current user is allowed to see, so an anonymous request would only
surface public content. The module depends on core's **Path** module and supports
**Drupal 8.8 through 11**.

There is **no settings form** — Multi-Path Autocomplete works simply by being
enabled; it transparently upgrades the relevant path fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Once enabled it works automatically, described in "How to use it" below.

## Where it lives in the admin menu

Multi-Path Autocomplete adds no admin page of its own. Its effect appears
wherever you enter a path for a menu link — for example at **Structure → Menus →
*(a menu)* → Add link** — where the **Link** path field becomes an autocomplete.

## How to use it

1. Go to add or edit a **menu link** (**Structure → Menus → *(your menu)* → Add
   link**, or edit an existing link).
2. In the **Link** field, start typing the **title** of the page you want to
   point to instead of its internal path.
3. Pick the matching page (or URL alias) from the autocomplete suggestions — the
   module fills in the correct internal path for you.

Because suggestions are access-checked, editors only see content they're allowed
to reference.
