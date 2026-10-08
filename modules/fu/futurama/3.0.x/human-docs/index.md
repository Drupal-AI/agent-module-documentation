# Futurama — manual setup guide

**Futurama** (`futurama`) is a small, cheerful novelty module. It provides a
single block that displays a random caption/title gag from the animated TV show
*Futurama* — the kind of one‑liner that flashes on screen under the show's
opening logo. Enable it, place the block, and each page load shows a different
quote.

There is genuinely nothing to configure. The module defines one block plugin
(admin label **"Futurama quote of the day"**, category **Futurama**) whose output
is picked at random from a hard‑coded list of about 110 captions baked into the
module. Some captions include a little inline formatting. There are no routes,
permissions, services, or settings.

Beyond adding whimsy to a footer, sidebar, or about page, it also works nicely as
a minimal, readable example of how a Drupal block plugin is written — handy if
you are learning to build blocks. (A `futurama_generate/` folder ships in the
codebase with some Form/Controller classes, but it has no `.info.yml` or routing,
so it is not an installable submodule in this release.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. You use it
entirely by placing the block, described below.

## Where it lives in the admin menu

Futurama adds no admin page. You use it from **Structure → Block layout**
(`/admin/structure/block`), where you place the **Futurama quote of the day**
block in a region.

## How to use it

1. Go to **Structure → Block layout**.
2. Next to the region where you want the quote (for example *Footer* or a
   sidebar), click **Place block**.
3. Find **Futurama quote of the day** in the list and place it.
4. Optionally set the usual block visibility conditions (pages, roles, content
   types) to control where it appears, then save the block.

Reload the page and a random caption appears; each fresh load rotates to a
different one. You can place multiple instances in different regions if you like.
