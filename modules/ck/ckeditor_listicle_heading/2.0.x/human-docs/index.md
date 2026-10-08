# CKEditor Listicle Heading — manual setup guide

**CKEditor Listicle Heading** (`ckeditor_listicle_heading`) is a **legacy
CKEditor 4** plugin that inserts stylised, numbered "listicle" headings — the
kind you see in "10 tips for…" articles, where each section is introduced by a
number followed by a title ("1. First tip", "2. Second tip").

Behind the scenes it produces a tidy, themeable structure: a
`div.listicle-heading` wrapper containing a heading tag of your choice (h1–h6)
whose parts are split into spans — `span.number` for the number,
`span.separator` for the ". " separator, and `span.title` for the heading text.
That lets your theme style the number independently of the title. When a number
is present the wrapper also carries a `has-number` class.

You insert a heading through a small dialog: pick the heading level (h2 by
default), type a number, and type the title (the title is required). Editing an
existing listicle heading re‑opens the dialog with the number and title read back
from the spans. A context‑menu entry is registered too, for quick access inside
`div` elements. The module stores no server‑side data beyond the HTML it
produces, and the actual look of the numbered heading is left entirely to your
theme's CSS.

Two things are worth knowing up front. First, this targets **CKEditor 4**, the
editor Drupal core has removed in favour of CKEditor 5 — so it is only relevant on
sites still running CKEditor 4 (for example via the CKEditor 4 LTS bridge).
Second, the module is *minimally maintained* and **not covered by Drupal's
security advisory policy**, so weigh that before relying on it for a new build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, add
   the toolbar button, and allow the produced markup in your text format.

There is **no settings page** for this module — the whole workflow happens
through the toolbar button and its dialog, described below.

## Where it lives in the admin menu

Listicle Heading adds no admin configuration page. You enable its toolbar button
per text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), on formats that use the CKEditor 4
editor. Add the **Listicle Heading** button (it belongs in the *insert* toolbar
group), and make sure the format's allowed HTML permits the markup it generates —
`div`, the heading tags you use (`h2`, etc.), and `span[class]` — otherwise the
text‑format filter will strip the structure on output.

## How to use it

Once the button is on the toolbar, place your cursor where the heading should go,
click **Listicle Heading**, and fill in the dialog: choose the heading level,
enter the number, and type the title. Save the dialog and the numbered heading is
inserted. To change one later, click into it and re‑open the dialog — it reloads
the current number and title for editing. Styling the number, separator, and
title is a job for your theme's stylesheet.
