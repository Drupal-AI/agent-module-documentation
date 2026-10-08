# CKEditor5 Label Fix — manual setup guide

**CKEditor5 Label Fix** (`ckeditor5_label_fix`) is a lightweight plugin that
stops CKEditor 5 from mangling `<label>` markup and the way anchors are nested
inside it. Out of the box, CKEditor 5 can rewrite valid `<label>` structures on
save — splitting text, breaking nested links, and losing the semantics — which is
a nasty surprise for sites that rely on that markup. This module restores support
for the original label structure so it round-trips through the editor unchanged.

It's especially useful on sites **upgraded from CKEditor 4**, which happily
accepted label markup that CKEditor 5 does not, as well as government, enterprise,
and accessibility-focused sites that depend on semantic, WCAG-compliant `<label>`
elements. The plugin works with any text format that uses CKEditor 5 on Drupal
10, 11, and 12.

To make it easy to switch on, the module provides a **faux CKEditor button**
("Label Fix Dummy") that you add to the toolbar of the text format you want to
protect. No visible button appears in the editing UI — the plugin simply loads
silently in the background once the button is present in the toolbar
configuration. The module has no settings form of its own and requires no contrib
dependencies. It is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You activate it per text
format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the text format whose label markup you want to
   preserve.
3. In the CKEditor 5 toolbar drag-and-drop area, find the **Label Fix Dummy**
   button and drag it into your active toolbar.
4. Click **Save configuration**.

The plugin is now active for that format. You won't see a new button while
editing — it works silently — but your full `<label>` markup is preserved on
save. Repeat for any other CKEditor 5 formats that need the same protection.
