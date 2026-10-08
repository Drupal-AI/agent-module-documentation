# Icons — manual setup guide

**Icons** (`icons`) is an *API* module for using icons in Drupal. Rather than
tying your site to one icon library, it defines the plumbing — a configuration
entity type for icon sets and an `IconProvider` plugin type — and then lets you
enable a small submodule for each library you actually want. Out of the box it
ships providers for Font Awesome, Fontello, IcoMoon, and a generic icon picker,
so you can start with one library today and add another later without changing
how icons are stored or rendered.

Because icons are handled through a shared abstraction, you can also switch icon
providers down the line without rewriting stored data, and a theme or custom
module can declare its own icon set against the same API. Its only dependency is
core's **Options** module.

One thing worth checking before you install: Drupal 11.1 introduced an icon API
in core itself. If you are on a current core release, core's own icon support may
already cover what you need, so it is worth confirming that first — the two
abstractions overlap.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and turn on the provider submodules you need.

Icons has **no single settings page** of its own. You work with it by enabling
provider submodules and then declaring/managing icon sets — see "How to use it"
below.

## Where it lives in the admin menu

The base module adds no top‑level admin page. Each provider submodule you enable
contributes the pieces you use: an icon set configuration entity for the library
(for IcoMoon/Fontello you point it at your exported icon assets), plus render
elements and a picker widget for placing icons on content and menu links. Icons
also registers its field types into Drupal's field‑type category system, so they
group sensibly in the field‑add UI.

## How to use it

1. Enable the base **Icons** module (below) together with the provider submodule
   for the library you use — for example `icons_icomoon` or `icons_fontawesome`.
2. Make the library's icon assets available to the site (for IcoMoon/Fontello,
   the icon set files you exported from those apps), then create/adjust the icon
   set configuration the submodule provides.
3. Use the icons where the submodule exposes them — for instance the icon picker
   for menu links, or the module's render elements in a theme or custom module.

> **Heads‑up:** using multiple icon sets on one site can lead to conflicting CSS.
> Use custom prefixing in your theme/module (IcoMoon and Fontello can set a
> prefix when you export) to avoid clashes.
