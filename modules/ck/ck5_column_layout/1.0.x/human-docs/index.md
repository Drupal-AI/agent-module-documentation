# CKEditor 5 Column Layout — manual setup guide

**CKEditor 5 Column Layout** (`ck5_column_layout`) adds a modern, flexbox-based grid
system directly inside the Drupal editor. It gives content creators a WYSIWYG way to
build responsive, multi-column content without writing any HTML or CSS: select your
content, use the **Columns** tool, and wrap it in resizable columns that stack
sensibly on smaller screens.

The module solves the everyday problem of laying out content in columns. A modal lets
you define stacking behaviour per breakpoint (Mobile, Tablet, Laptop, Desktop),
editor-side buttons let you add or remove columns with a click, and you see the
layout live in the CKEditor 5 workspace. A dedicated filter cleans up the editor-only
UI so configuration buttons never leak onto the public-facing page, and the module
includes XSS hardening that validates its data attributes. It depends on core
**CKEditor 5** (no external JavaScript libraries) and supports Drupal 10 and 11.

Setup is per text format: add the Columns button to the toolbar, enable the module's
cleanup filter, and grant the settings permission to the right roles. The column
markup passes through the text format, so make sure the format allows and sanitises
that HTML — the bundled filter is designed to work alongside core's *Limit allowed
HTML tags* filter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no standalone settings page. You configure the tool per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and grant its permission at **People →
Permissions**.

## How to enable the Columns tool in a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format your editors use (for example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the **Columns** icon up into the
   active toolbar.
3. In **Enabled filters**, enable the **CKEditor 5 Column Layout Asset Loader &
   Cleaner** filter.
   - **Order it *after* the "Limit allowed HTML tags" filter** so the cleanup runs
     correctly.
4. Save the format.
5. At **People → Permissions**, grant the **`ck5 column layout settings`** permission
   to the roles that should be able to use the tool.

Editors using that format can now select content and wrap it in responsive columns,
adjusting the per-breakpoint stacking in the modal.
