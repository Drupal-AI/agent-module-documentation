# CKEditor5 horizontal line — manual setup guide

**CKEditor5 horizontal line** (`ckeditor5_horizontal_line`) adds a
horizontal-line (horizontal rule) button to the CKEditor 5 toolbar. Clicking it
drops a horizontal line — the classic `<hr>` rule — into your content, giving
editors a quick, visual way to divide a piece of writing into sections or to
signal a change of topic.

It's a small, focused CKEditor 5 plugin. It adds no admin pages, no permissions,
and no settings form of its own — the only thing you do to "configure" it is
drag its button onto the toolbar of whichever text format you want it in. It
depends only on Drupal core's CKEditor 5, and works on Drupal 9, 10, and 11.

Note that this module is not covered by Drupal's security advisory policy, which
is common for small editor-plugin modules. That has no bearing on whether it
works — it simply means security issues are not handled under the official
advisory process.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Once it's enabled you turn
the button on per text format, described below.

## How to use it

The button becomes available in every text format that uses CKEditor 5, but you
have to place it on the toolbar before editors can see it:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want (for example *Full HTML*).
3. In the CKEditor 5 toolbar drag-and-drop area, find the **Horizontal line**
   button in *Available toolbar items* and drag it into your active toolbar.
4. Click **Save configuration**.

Now, when editing content with that format, place your cursor where you want a
divider and click the Horizontal line button to insert a rule.
