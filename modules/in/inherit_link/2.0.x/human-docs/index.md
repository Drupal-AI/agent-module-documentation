# Inherit Link — manual setup guide

**Inherit Link** (`inherit_link`) solves a common front-end problem: making a
whole element — a teaser, a card, a title block — clickable so it leads to its
detail page, *without* wrapping everything in one big `<a>` tag. Nesting content
inside a single link is invalid HTML and breaks any other links inside (tags,
"read more" buttons). Inherit Link instead lets a container **inherit** the link
that already exists inside it: a small jQuery plugin finds the first real link in
the element and extends its click behaviour to the whole container, while any
other links inside keep working normally.

A classic use is a teaser whose title links to the full node: enable Inherit Link
and the entire teaser becomes clickable, yet the tag links and secondary buttons
inside it stay independently functional.

The project comes in two parts:

- The **main module** integrates the jQuery *InheritLink* plugin as a Drupal
  library. If you only want to wire it up in code, enable just this module,
  attach the library where you need it, and use it.
- The **Inherit Link UI** submodule (`inherit_link_ui`) adds a management screen
  and ships sensible default configuration, so you can create and edit
  "inheritance" rules through the admin interface instead of writing code.

By default (with the UI submodule and its defaults installed) the behaviour
applies to the `.inherit-link` and `.node--view-mode-teaser` selectors.

Note one external requirement: the module depends on the third-party jQuery
**InheritLink** plugin, which you download and place in your site's libraries
folder — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the required jQuery plugin, and enable it (with the UI submodule).
2. [Configuration](configuration/index.md) — create and edit inheritance rules on
   the Inherit Link admin screen.

## Where it lives in the admin menu

With the **Inherit Link UI** submodule enabled, the management screen lives at
`admin/config/inherit_link`, where you add, edit, and delete inheritance rules
(config entities). Without the UI submodule there is no admin page — you use the
library directly from code.
