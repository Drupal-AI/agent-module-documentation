# Menu Twig — manual setup guide

**Menu Twig** (`menu_twig`) lets menu administrators attach a snippet of HTML or
**Twig** markup to an individual menu link, which is then rendered in place of — or
alongside — the normal link. It adds a rich‑text (WYSIWYG) field to the menu link
edit form so you can author custom markup for a menu item: a badge, an icon, a
promo block, or a whole mega‑menu entry, without writing theme templates.

The snippet is rendered through a replacement Twig `link()` function the module
provides, with the link's `title`, `url`, and `attributes` available as context and
the output filtered through your chosen text format. A per‑link **override** option
lets you replace the standard link markup entirely, and an **exclude** option lets
you drop a menu item from rendering. The form also includes read‑only helper modals
listing the available Twig filters and functions plus some examples. Pairing Menu
Twig with the [Twig Tweak](https://www.drupal.org/project/twig_tweak) module unlocks
richer possibilities such as rendering blocks or views inside a menu item — useful
for mega menus.

The module depends on core's **Link** module and targets Drupal 10. It adds no
configuration screen and no settings form; the snippets live on each menu link.

> **Security — please read.** The Twig snippet you enter is *executed as a Twig
> template on the server*. That is the whole point of the module, but it means
> anyone who can edit menu links can effectively run arbitrary Twig (and, through
> it, PHP). Treat the core **Administer menus and menu links** (`administer menu`)
> permission as a trusted, admin‑only permission on any site using Menu Twig, and
> do **not** grant it to semi‑trusted editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings form. You author
snippets directly on each menu link, as described below.

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`) and edit a menu link (or
   add a new one).
2. Open the **Menu Twig** section on the menu link form.
3. Enter your HTML/Twig markup in the WYSIWYG text field, choosing an appropriate
   text format. Use the in‑form helper modals to browse the available Twig filters
   and functions and to view example snippets.
4. Tick the **override** option if you want your markup to *replace* the standard
   link entirely (rather than render alongside it).
5. Save the link. The menu now renders your custom markup wherever that link
   appears.
