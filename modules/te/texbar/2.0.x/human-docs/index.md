# LaTeX Toolbar — manual setup guide

**LaTeX Toolbar** (`texbar`) adds a point-and-click LaTeX toolbar to textareas on
your site. Can't remember the LaTeX code for infinity? Click the button in the
toolbar and the code is inserted straight into the textarea for you. It is built
on the **markItUp!** JavaScript library and gives authors a set of buttons that
drop common LaTeX/TeX math markup into a field without them having to memorise
the syntax.

The module works by attaching its markItUp and texbar JavaScript libraries to
your pages along with a single setting — a **jQuery selector** — that decides
which textareas get the toolbar. The client-side script then binds the LaTeX
button set to every textarea matching that selector. Because the libraries load
on all pages, you should keep the selector narrow, targeting only the fields
that actually need math input (a body field, a comment field, a custom form's
textarea, and so on). The button sets themselves live in the module's `sets/`
folder, and a Drush command is available to fetch and build the third-party
editor assets.

One thing to be clear about: the toolbar only *inserts* LaTeX source text into a
field — it changes the editing experience, not how anything is stored, and it
does not render the math. If you want the entered LaTeX to display as typeset
mathematics, pair it with a separate renderer such as MathJax or KaTeX. The
module has a single admin setting and one permission (`administer texbar`) that
guards it; there are no anonymous or data-changing endpoints, and the toolbar
only touches fields the author is already editing.

LaTeX Toolbar runs on Drupal 8, 9, 10 and 11 and has no other module
dependencies.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the jQuery selector that
   decides which textareas get the toolbar.

## Where it lives in the admin menu

The single settings form sits at **Configuration → Content authoring → LaTeX
Toolbar** (`/admin/config/content/texbar`), reachable by users with the
`administer texbar` permission.
