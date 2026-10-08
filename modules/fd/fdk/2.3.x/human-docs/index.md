# Field Display Kit — manual setup guide

**Field Display Kit** (`fdk`) gives you fine‑grained control over how any field is
rendered, beyond what core's *Manage display* offers. Once enabled, it adds extra
display options to **every field on every entity** in your site, and those options
apply whether the field is displayed normally or through Layout Builder.

With FDK you can:

- change a field's **title (label)** independently in each display / view mode;
- change the label's **HTML element tag** and add classes and other attributes to
  it;
- change the field's **wrapper element**, with its own classes and attributes;
- change the **wrapper of each individual field item**, again with classes and
  attributes;
- **link any field item**, using tokens such as `[node:url]` to build the link.

FDK only affects how fields are *displayed* — the field content and its access are
unchanged, so fields still respect their own access rules. There is no central
settings page; you configure everything per field on the display screens.

> **Theme note:** FDK ships its own version of `field.html.twig`. If one of your
> themes overrides `field.html.twig`, that override must be based on **FDK's**
> template, not core's — otherwise you may not get the output your FDK settings ask
> for.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no standalone configuration page** — you set FDK's options on each
field's display, as described below.

## How to use it

1. Go to the display you want to tune — for example **Structure → Content types →
   *(type)* → Manage display** (`/admin/structure/types/manage/<type>/display`), and
   pick the relevant view mode. Fields in a Layout Builder layout are configured from
   the field's settings there.
2. Open a field's formatter settings. Alongside the usual options you will find the
   FDK controls for the label text and tag, the field wrapper, the per‑item wrapper,
   and item linking (with token support).
3. Set the label, tags, classes/attributes, and any item link you need, then save
   the display.

Repeat per view mode to give the same field different treatment in, say, the teaser
versus the full display.
