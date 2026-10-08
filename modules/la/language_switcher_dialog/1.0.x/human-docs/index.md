# Language Switcher Dialog — manual setup guide

**Language Switcher Dialog** (`language_switcher_dialog`) is a modern replacement
for the default language‑switcher block. Instead of printing a plain list of
language links, it places a compact **trigger button** showing the current
language; clicking it opens a **modal dialog** that loads the language‑switch
links. The dialog is built on the browser's native HTML `<dialog>` element and
Drupal 11's core HTMX integration — so there is no jQuery UI, no custom
focus‑trap library, and no JavaScript framework involved. The dialog's contents
are lazy‑loaded as a server‑rendered HTML fragment.

Accessibility is a first‑class concern: the native `showModal()` gives you focus
trapping, Escape‑to‑dismiss, and background inertness for free, and the module
ships with proper ARIA attributes, `hreflang`/`lang` on links, and support for
`prefers-reduced-motion` and forced‑colors mode, aimed at WCAG 2.2 AA compliance.
It ships **no CSS by default** — you bring your own theme styles, though an
optional "classic dialog" stylesheet is included for quick prototyping. Language
switching itself follows core's normal language negotiation; the module has no
access‑control role beyond its own permission.

The module is designed to be extended. Dialog **content‑provider plugins** decide
how the language links are rendered — drop a plugin class in the right namespace
and it is auto‑discovered in the settings form — and documented alter hooks let
you customise trigger‑button formats, world regions, GeoIP bot patterns, and the
dialog content. Optional submodules add country/region awareness and a first‑visit
GeoIP suggestion popup (see [Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the optional submodules.

There is **no standalone admin configuration page** with its own menu item — you
place the module's block and choose its options in the block configuration, as
described below.

## Where it lives in the admin menu

Language Switcher Dialog works through a **block**. Place and configure it under
**Structure → Block layout** (`/admin/structure/block`). The block's own
configuration form is where you select which dialog content provider renders the
links and choose the trigger‑button format.

## How to use it

1. Ensure core's **Language** module is enabled with **two or more languages**
   configured.
2. Under **Structure → Block layout**, place the **Language Switcher Dialog**
   block in a visible region (a header is typical).
3. In the block's configuration, pick the dialog **content provider** (the
   built‑in one, or one added by a submodule) and, if offered, the trigger‑button
   format.
4. Add your own theme CSS for the dialog and trigger — or enable the bundled
   "classic dialog" stylesheet while prototyping.
5. View the site as a visitor: the trigger button shows the current language, and
   clicking it opens the accessible modal with the language links.
