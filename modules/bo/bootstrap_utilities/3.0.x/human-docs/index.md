# Bootstrap Utilities — manual setup guide

**Bootstrap Utilities** (`bootstrap_utilities`) provides four text‑format filters
that automatically add Bootstrap CSS classes to the HTML your editors produce, so
rich‑text content styles correctly under a Bootstrap 4/5 theme without anyone
touching markup. It adds `.table` to tables (with optional striped/bordered/hover/
small variants), `.img-fluid` to images so they scale responsively, `.blockquote`
to block‑quotes, and `.figure` / `.figure-caption` to figures and their captions.

The point is to keep editor markup clean: authors write plain HTML in CKEditor,
and the theme classes are merged in at render time. The filters work with xPath
(not regular expressions) for good performance, and they **preserve** any classes
already on an element — the Bootstrap class is added, not substituted. Because they
are core Filter plugins, you enable each one **per text format**, so you can, say,
turn on the image filter for "Basic HTML" and the table filter for "Full HTML".

Three of the filters are simple on/off toggles. Only the **table** filter has its
own options, letting you choose which Bootstrap table variants to apply and whether
to strip hard‑coded `width`/`height` attributes from pasted tables so they render
responsively. There is no dedicated settings page — everything is configured inside
the text‑format editor. The module depends only on core's **Filter** module; it has
no permissions, services, or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no page of its own. You enable and configure the filters per text format
at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by editing a format
(`/admin/config/content/formats/manage/<format>`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and
   click **Configure** on the text format you want (for example *Full HTML*).
2. In the **Enabled filters** list, tick the Bootstrap Utilities filters you want:
   - **Bootstrap Utilities - Table Classes** — adds `.table` to `<table>`.
   - **Bootstrap Utilities - Responsive Image Class** — adds `.img-fluid` to `<img>`.
   - **Bootstrap Utilities - Blockquote Classes** — adds `.blockquote` to `<blockquote>`.
   - **Bootstrap Utilities - Figure Classes** — adds `.figure` / `.figure-caption`.
3. Check the **Filter processing order** tab. These filters transform the HTML on
   output, so place them **after** any tag‑limiting filter (such as "Limit allowed
   HTML tags") so the classes are not stripped again.
4. If you enabled the **Table Classes** filter, open the **Filter settings** tab to
   choose its options (see below).
5. Click **Save configuration**.

### Table filter settings

The table filter always adds the base `.table` class. Its settings let you add
variants and clean up pasted tables:

| Setting | Default | Effect |
|---|---|---|
| **Remove width/height** | On | Strips `width`/`height` attributes from table cells so the table is responsive. |
| **Row striping** | Off | Adds `.table-striped` for zebra striping. |
| **Bordered** | Off | Adds `.table-bordered` for cell borders. |
| **Row hover** | Off | Adds `.table-hover` to highlight rows on hover. |
| **Small** | Off | Adds `.table-sm` for a compact table. |

Because the filters run per format, you can give different formats different table
styling — striped on one, bordered on another.
