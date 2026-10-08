# CKEditor 5 Lorem Ipsum — manual setup guide

**CKEditor 5 Lorem Ipsum** (`ckeditor5_lorem_ipsum`) adds a toolbar button to
CKEditor 5 that inserts *Lorem Ipsum* placeholder text with a single click. It's a
convenience for content creators and site builders who need to fill a body field
with dummy text quickly — while designing a layout, testing a template, or
mocking up a page — without leaving the editor to copy placeholder text from
elsewhere.

It's a small, single-purpose CKEditor 5 plugin: no admin pages, no permissions,
and no settings form. You enable it, drag its button onto the toolbar of the text
formats where you want it, and click to generate placeholder text. It depends only
on Drupal core's CKEditor 5 and works on Drupal 9, 10, and 11.

This module is in maintenance-fixes-only status and is not covered by Drupal's
security advisory policy, which is typical for a small editor-plugin module.

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
2. Click **Configure** next to the format you want.
3. In the CKEditor 5 toolbar drag-and-drop area, find the **Lorem Ipsum** button
   in *Available toolbar items* and drag it into your active toolbar.
4. Click **Save configuration**.

When editing content, place your cursor where you want filler text and click the
Lorem Ipsum button to insert placeholder text.
