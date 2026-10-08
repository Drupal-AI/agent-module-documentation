# CKEditor5 Sup Fix — manual setup guide

**CKEditor5 Sup Fix** (`ckeditor5_sup_fix`) is a lightweight plugin that stops
CKEditor 5 from mangling `<sup>` (superscript) markup and nested anchors. Out of
the box, CKEditor 5 normalises certain valid superscript and anchor structures on
load or save — a footnote reference marked up as a superscripted link, for
example, can come out altered or stripped. This module restores support for that
markup so it survives editing intact.

It is especially useful on sites **upgraded from CKEditor 4**, which accepted this
markup happily, and on government, enterprise, or WCAG-focused sites that rely on
semantic `<sup>` elements. It depends only on core's CKEditor 5.

The plugin works through a "dummy" toolbar button: you add it to a text format's
toolbar to switch the fix on. No visible button appears in the editor UI and
there is nothing for editors to click — the plugin simply loads in the background
and preserves your markup. There is nothing to configure beyond enabling it per
format, and it has no content or access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You activate it per text
format by adding its dummy button, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on a format that uses CKEditor 5 and where you need
   superscript/anchor markup preserved.
3. In the CKEditor 5 toolbar configuration, drag the **Sup Fix Dummy** button
   into the *Active toolbar*.
4. **Save configuration**.

The plugin is now active for that format. You will not see a new button in the
editor — the fix runs silently — but your `<sup>` and nested-anchor markup will
be preserved through editing.
