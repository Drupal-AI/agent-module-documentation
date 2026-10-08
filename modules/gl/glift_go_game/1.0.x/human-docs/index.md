# Glift Go Game — manual setup guide

**Glift Go Game** (`glift_go_game`) lets you embed **Go game records** directly in
your content. Go (also known as Weiqi or Baduk) game records are stored in the
**SGF** file format, and this module uses the bundled **Glift** JavaScript viewer
to turn an SGF file into an interactive board that readers can step through move by
move.

It works as a **text‑format filter**: enable the *Glift go game* filter on the
input format your content uses, then embed a game anywhere in that content with a
simple bracketed tag pointing at an SGF file. It's described by its author as "a
very basic attempt to enable embedding SGF files in Drupal using Glift" — small,
focused, and easy to use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. You "configure" it by
enabling its text‑format filter, described in "How to use it" below.

## Where it lives in the admin menu

Glift Go Game adds no settings page of its own. You enable its filter under
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on whichever input format you want to allow Go
records in.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format your content uses (for example *Basic HTML* or *Full
   HTML*) and enable the **Glift go game** filter, then save.
3. In your content, embed a Go game by wrapping the SGF file's URL in `[glift]`
   tags:

   ```
   [glift]http://www.example.com/mygame.sgf[/glift]
   ```

4. When the content is viewed, Glift renders the SGF as an interactive Go board.

> **Tip:** filter order matters. If other filters strip or alter the `[glift]…`
> markup, adjust the filter processing order on the same text‑format edit page so
> the Glift filter runs at the right point.
