# None Title — manual setup guide

**None Title** (`none_title`) hides a node's title from display when an editor
types the literal string **`<none>`** into the title field. It gives editors a
per‑node way to suppress the visible heading without a theme override or an extra
"display title" field.

The need is real and recurring: a landing page whose headline lives inside a hero
component, a page whose first paragraph already carries the heading, or a node used
purely as a container for referenced content. Drupal requires a node title — it is
the entity's label — so you can't simply leave it blank. The usual alternatives
are a per‑content‑type theme override or a "display title" boolean field a site
builder has to add and wire up. None Title offers a blunter but simpler route: a
sentinel value in the title field, decided per node by the editor. It depends only
on core's **Node** module and works on Drupal 9.1, 10 and 11.

There is **nothing to configure** — no settings form and no admin page. Once the
module is enabled, any editor can type `<none>` in a title to hide that node's
heading on display.

Three consequences are worth understanding before you adopt it, because the
sentinel is **stored data** and travels further than the display:

1. **`<none>` becomes the node's actual label.** Unless something intervenes, that
   literal string can show up in the admin content listing, in autocomplete
   results, in a reference field's rendered label, in breadcrumbs and in search.
   Check each of those places.
2. **The `<title>` element and Open Graph title are built from the label too.** A
   page that hides its on‑screen heading may still be telling browsers, search
   engines and social platforms that its title is `<none>`.
3. **An accessible page needs a heading.** Hiding the `<h1>` because your design
   puts the words in a hero is fine only if those words are still marked up as a
   heading somewhere on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. Setup is just
installing and enabling it (see below), after which editors use the `<none>`
sentinel in the title field.

## How to use it

1. Edit (or create) the node whose heading you want to hide.
2. In the **Title** field, type `<none>` exactly.
3. Save. The title will be suppressed from the node's display.

Because the label is still stored as `<none>`, review the places listed above —
especially the admin content listing, the page `<title>`/SEO metadata, and page
accessibility — to make sure the hidden title doesn't leak somewhere it shouldn't.
