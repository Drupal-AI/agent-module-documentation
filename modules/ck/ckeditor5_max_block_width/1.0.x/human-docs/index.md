# CKEditor 5 max block width — manual setup guide

**CKEditor 5 max block width** (`ckeditor5_max_block_width`) adds a dropdown to
the CKEditor 5 toolbar that lets editors set the width of a block — a table, an
image, or embedded media — to one of three presets: **regular**, **wide**, or
**full** width. It works by applying a CSS class to the selected block, and the
three widths are defined as CSS variables, so you (or your theme) control what
"wide" and "full" actually mean visually.

There's one requirement for it to render correctly: your content area needs the
`max-w-container` class. As the module notes, **add the `max-w-container` class to
your body field (or the wrapping element/class)** so the width presets have a
container to size against.

It's a compact CKEditor 5 plugin with no admin pages, no permissions, and no
settings form — you enable it and place its dropdown on the text formats where you
want it. It runs on Drupal 10 and 11. The module is minimally maintained
(maintenance fixes only) and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the dropdown on per
text format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the toolbar drag-and-drop area, drag the **block width** dropdown into your
   active toolbar.
4. Click **Save configuration**.
5. Make sure the field's rendered output carries the `max-w-container` class (add
   it to your body field or wrapping element) so the width presets have a
   container to work against.

When editing, select a table, image, or media block, open the width dropdown, and
choose **regular**, **wide**, or **full**. Adjust the CSS variables in your theme
if you want to change the actual pixel widths.
