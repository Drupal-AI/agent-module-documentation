# Printjs — manual setup guide

**Printjs** (`printjs`) adds a print button backed by the
[Print.js](https://printjs.crabbly.com/) JavaScript library, so visitors can print
**just one region** of a page — a view's results, a node's content, an invoice
block — rather than the whole page with its navigation, sidebars, and footer.

The browser's own print command prints everything on the page. The usual fix is a
print stylesheet that hides the chrome, which is the better long‑term foundation but
requires theme work. Print.js takes the other route: it collects the target content
(identified by a CSS **id**) and hands the browser a document containing only that —
which is why this module can offer printing as a button without touching your theme.
By default it prints the element with `id="print"`, and that id is configurable.

Packaged under **Views**, its primary use is printing a **view's results** — a
report, a schedule, a filtered list someone wants on paper. You place the Printjs
**block** to show the button (it prints the configured id plus the page's CSS), and
you can also add print buttons in a view's header or footer. The module is
extensible via hooks such as `hook_preprocess_printjs`, which advanced users can use
to customise the output (e.g. produce PDFs or images).

> **Three things worth knowing (true of any client‑side highlighter/printer):**
> 1. A **print stylesheet is still the better foundation** where you can change the
>    theme — it works with the browser's own dialog, Save‑as‑PDF, and keyboard
>    shortcuts, and without JavaScript.
> 2. **Print.js doesn't carry the page's stylesheets by default** — output can
>    arrive unstyled unless it's told which CSS to include. This is the most common
>    complaint about it.
> 3. **It prints what's in the DOM** — anything lazy‑loaded, in an unopened tab, or
>    behind "show more" is absent from the printout, which surprises people printing
>    long listings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the id of the element to print.

## Where it lives in the admin menu

The settings form (`printjs.settings`) lives under **Configuration** at
`/admin/config/…/printjs`, where you set the id of the region to print. See
[Configuration](configuration/index.md).

## How to use it

1. Wrap the content you want printable in a div with the configured id, e.g.
   `<div id="print"> … </div>`.
2. Place the **Printjs** block to show the **Print** button. Clicking it sends the
   content inside that id (plus the page CSS) to the printer.
3. Optionally, add print buttons in a view's **header or footer** to print the
   view's results.
