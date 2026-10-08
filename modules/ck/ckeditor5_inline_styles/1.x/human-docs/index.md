# Ckeditor 5 Inline Styles — manual setup guide

**Ckeditor 5 Inline Styles** (`ckeditor5_inline_styles`) is a CKEditor 5 plugin
for applying inline styles to selected content. It gives editors a controlled set
of style classes they can apply from a toolbar control, so formatting stays
consistent with your design system rather than being hand-typed.

An important scope note from the module's own documentation: **currently this
module works only with the Media Library** — it adds a "Media Inline Styles"
toolbar control for styling embedded media, and it relies on an accompanying
**Inline Style filter** that must run *before* the Embed media filter in the text
format's filter processing order. Applied styles become CSS classes in the saved
markup, so the text format's allowed tags and attributes must permit those classes
for them to survive filtering.

It's a content-editing feature only — no admin pages, no permissions, no
access-control role. It depends on Drupal core's CKEditor 5 and runs on Drupal 10
and 11. The module is maintained by developers at Digital Polygon and is covered
by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. Setup happens entirely
on your text format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`) and click **Configure** on the
   CKEditor 5 format you want.
2. In the CKEditor 5 toolbar drag-and-drop area, drag the **Media Inline Styles**
   icon into your active toolbar.
3. Scroll down to **Enabled filters** and tick the **Inline Style** filter.
4. Under **Filter processing order**, drag the **Inline Style** filter so it runs
   **before** *Embed media*.
5. Click **Save configuration**.

Once configured, editors can apply the available inline styles to media in the
editor. Because styles are stored as classes, confirm your format's allowed-HTML
settings permit the class attribute on the affected elements.
