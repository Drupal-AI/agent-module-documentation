# CKEditor 5 Inline Quote — manual setup guide

**CKEditor 5 Inline Quote** (`ckeditor5_inline_quote`) adds a toolbar button to
CKEditor 5 that wraps a text selection in an inline quotation element — the HTML
`<q>` tag. Unlike a block quote, which sets a whole paragraph apart, an inline
quote marks up a short quoted phrase *within* a sentence, so it stays in the flow
of your text while carrying proper quotation semantics.

The button also lets editors add a custom **class** and a **cite** attribute
through the CKEditor UI, so you can style particular quotes or point them at the
source of the quotation. It's a self-contained CKEditor 5 plugin: no admin pages,
no permissions, and no settings form — you simply place its button on the text
formats where you want it.

It depends only on Drupal core's CKEditor 5 and runs on Drupal 9.3, 10, and 11.
This release is covered by Drupal's security advisory policy.

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
2. Click **Configure** next to the format you want (for example *Basic HTML*).
3. In the CKEditor 5 toolbar drag-and-drop area, find the **Inline Quote** button
   in *Available toolbar items* and drag it into your active toolbar.
4. Click **Save configuration**.

When editing content, select the phrase you want to quote, click the Inline Quote
button, and — if you like — supply a class or a cite URL in the UI. The selection
is wrapped in a `<q>` element.

> **Tip:** If your text format uses *Limit allowed HTML tags*, make sure the `<q>`
> tag (with any `class` or `cite` attributes you plan to use) is permitted, or the
> filter will strip it on save.
