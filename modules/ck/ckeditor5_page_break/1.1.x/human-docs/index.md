# CKEditor5 page break — manual setup guide

**CKEditor5 page break** (`ckeditor5_page_break`) adds a page-break button to the
CKEditor 5 toolbar. Clicking it inserts a page break into your content, giving you
control over where one printed or exported page ends and the next begins. It's
aimed at content that leaves the screen — documents printed from the browser or
exported to **PDF** or **Word** — where you want a clean break between sections.

It's a small, focused CKEditor 5 plugin: no admin pages, no permissions, and no
settings form of its own. You enable it and drag its button onto the toolbar of
whichever text formats need it. It depends only on Drupal core's CKEditor 5 and
works on Drupal 9, 10, and 11.

This module is not covered by Drupal's security advisory policy, which is common
for small editor-plugin modules and doesn't affect whether it works.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on per
text format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want (for example *Full HTML*).
3. In the CKEditor 5 toolbar drag-and-drop area, find the **Page break** button in
   *Available toolbar items* and drag it into your active toolbar.
4. Click **Save configuration**.

When editing content, place your cursor where you want a page to end and click the
Page break button. The break is honored when the content is printed or exported to
PDF or Word.
