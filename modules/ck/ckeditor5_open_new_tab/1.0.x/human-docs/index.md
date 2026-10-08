# CKEditor5 Open New Tab — manual setup guide

**CKEditor5 Open New Tab** (`ckeditor5_open_new_tab`) adds a single, much‑requested
option to CKEditor 5's link dialog: an **"Open in new window"** checkbox. When an
editor links some text and ticks that box, the module writes `target="_blank"` onto
the anchor so the link opens in a new browser tab. It's a per‑link choice — editors
can open an external site or a big PDF in a new tab while keeping internal links
in‑page — without ever switching to the HTML source view.

The module is deliberately tiny. It has no settings form, no permissions, and no
schema of its own. Under the hood it extends Drupal core's Link plugin for CKEditor
5 and adds a standard CKEditor "manual link decorator," which is what puts the
checkbox in the link balloon. Because it builds on the core **Link** button, the
feature appears automatically on any CKEditor 5 text format that already has that
button — you just enable the module.

The one thing to watch is HTML filtering: if a text format restricts allowed HTML
tags, the format must permit the anchor to carry a `target` attribute, or the filter
will strip it back out on save. On unrestricted formats like *Full HTML* there's
nothing to change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. The feature shows up inside the CKEditor 5 link dialog on
text formats configured at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the text format you want uses **CKEditor 5** and has the **Link**
   toolbar button. No other setting turns the feature on — the checkbox appears
   wherever the Link button is present.
3. If that format has the **"Limit allowed HTML tags and correct faulty HTML"**
   filter enabled, make sure the anchor is allowed to keep a `target` attribute —
   for example include `<a href hreflang target>` in the allowed tags. Otherwise the
   `target="_blank"` gets filtered away on save and the link opens in the same tab.
4. When editing content, add or edit a link. In the link balloon you'll now see an
   **"Open in new window"** checkbox — tick it to make that link open in a new tab.

That's the whole feature. For security‑minded setups you can pair it with a module
or filter that adds `rel="noopener"` to `target="_blank"` links.
