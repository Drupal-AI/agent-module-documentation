# CKEditor5 Table Fix — manual setup guide

**CKEditor5 Table Fix** (`ckeditor5_table_fix`) is a lightweight plugin that
restores fuller HTML table markup support in CKEditor 5. By default CKEditor 5
strips or simplifies several structural table elements — `<tfoot>`, table
captions, and various nested table tags and attributes — so richer, semantic
tables lose parts of their structure when edited. This module keeps that markup
intact.

It is especially useful on sites **upgraded from CKEditor 4**, and on government,
enterprise, or WCAG-focused sites with legacy or semantic data tables that need
footer rows and accessible structure preserved. It depends only on core's
CKEditor 5.

Like its sibling *Sup Fix*, the plugin works through a **"dummy" toolbar button**:
you add it to a text format's toolbar to switch the fix on. No visible button
appears in the editor UI — the plugin loads silently in the background and
preserves your table markup. There is one important extra step for this module,
though: you must **disable core's CKEditor 5 table plugin** on the same text
format first, so that Table Fix handles the tables instead. There is no
configuration form and no content or access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You activate it per text
format as described below.

## How to use it

For each text format that should preserve full table markup:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on the CKEditor 5 format you want.
3. **Remove the core Table button** from the *Active toolbar* (drag it back to
   the available tray) so core's table plugin is not active on this format.
4. Drag the **Table Fix Dummy** button into the *Active toolbar*.
5. Make sure the text format's allowed HTML (the *Limit allowed HTML tags* filter,
   if enabled) permits the table elements you need — `table`, `thead`, `tbody`,
   `tfoot`, `caption`, and the row/cell tags — so they survive filtering on save.
6. **Save configuration**.

The plugin is now active for that format. You will not see a new button while
editing — the fix runs silently — but your full table structure, including footer
rows and captions, will be preserved through editing.
