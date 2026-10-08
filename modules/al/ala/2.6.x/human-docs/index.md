# Advanced Link Attributes — manual setup guide

**Advanced Link Attributes** (`ala`) gives editors a richer way to build links.
It extends Drupal's core **Link** field with a smarter widget and formatter, so
that instead of just entering a URL and title, editors can also pick a CSS class
(for example a Bootstrap‑style `btn btn-primary`), choose where the link opens,
add an icon, set text and background colors, attach extra HTML attributes, and
even show or hide the link based on the visitor's role.

The class choices can come from a **global list** you maintain once for the whole
site (so every editor picks from the same approved set of button styles), or from
a **custom list** defined on an individual field when it needs its own options.
On the display side, the formatter applies the chosen class to the link (or its
wrapper), renders the icon, turns the colors into inline styles, and honors the
per‑link role visibility — while still inheriting core's Link formatter options
(trim length, `rel="nofollow"`, open‑in‑new‑window, and so on).

This makes it a good fit for design‑system call‑to‑action buttons, promotional
links limited to certain roles, or any situation where you want editors to style
links consistently without hand‑writing HTML or custom templates. It depends only
on core's **Link** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the site‑wide global settings form
   (the shared class list and the extra‑attribute names).

## Where it lives in the admin menu

The module's global settings form sits at **Configuration → Content authoring →
Advanced Link Attributes** (`/admin/config/ala`). The per‑field behavior, however,
is set on the field's *Manage form display* and *Manage display* tabs, not here
(see *How to use it* below).

## How to use it

1. **(Optional) Set up the global class list.** Visit
   [Configuration](configuration/index.md) and list the button/link classes you
   want editors to choose from, plus any extra HTML attribute names you want to
   expose.
2. **Turn on the widget.** On the content type (or other entity) that has a Link
   field, go to **Manage form display**, and set that field's widget to
   **Advanced Link Attributes**. In the widget's settings gear you decide which
   advanced controls appear — the class selector (Disabled / Global list / Custom
   list), an icon field, a color picker, a role‑visibility selector, a target
   selector, and the extra‑attribute fields.
3. **Turn on the formatter.** On the same entity's **Manage display** tab, set
   that field's format to **Advanced Link Attributes**. Its settings control
   whether the class goes on the link or its wrapper, how the icon is rendered
   (inside the link as an `<i>` tag, appended as a class, or as a data attribute)
   and on which side, and how role‑hidden links are treated — plus all the
   inherited core Link options like trim length and `rel="nofollow"`.

Once both are set, editors filling in that Link field will see an **Advanced
settings** section with exactly the controls you enabled.
