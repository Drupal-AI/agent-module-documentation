# Responsive Table Filter — manual setup guide

**Responsive Table Filter** (`responsive_table_filter`) makes wide tables behave on small
screens. It adds a **text-format filter** that, at render time, wraps every `<table>` in
your content with a scrollable container (a `<figure>` by default). Instead of a wide
data table stretching the page or spilling off the edge on a phone, the table sits inside
a wrapper that scrolls horizontally on its own.

The wrapper is also made accessible: it gets `tabindex="0"` and an `aria-label` of
"Scrollable table" so keyboard and screen-reader users can focus and scroll it. A tiny CSS
file the module attaches to every page is what actually enables the scrolling
(`max-width:100%; overflow-x:auto`), so you don't have to write any CSS or Twig yourself.

Because it's a filter, it works purely on **output** — your stored HTML is never changed —
and you switch it on **per text format**. That means you can enable responsive tables for,
say, Full HTML while leaving other formats alone, and every table authored in CKEditor (or
pasted from a spreadsheet) is wrapped automatically with no per-node work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You turn the filter on (and adjust its two options)
per text format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and click
   **Configure** next to the format you want (for example *Full HTML*).
2. Under **Enabled filters**, tick **Responsive Table filter**.
3. If the format also uses **Limit allowed HTML tags and correct faulty HTML**, place this
   filter **after** it in the processing order so the wrapper isn't stripped.
4. (Optional) In the filter's settings you can change:
   - **Wrapper element** — the HTML tag placed around each table. The default is `figure`;
     you could use `div` instead.
   - **Wrapper classes** — the CSS class(es) on that wrapper. The default is
     `responsive-figure-table`, which is the class the module's built-in CSS targets.
     **If you change this class, add matching CSS yourself**, since the bundled styling
     only applies to `responsive-figure-table`.
5. Click **Save configuration**.

From then on, any table in content using that format is wrapped in a scrollable,
accessible container when the page is rendered.
