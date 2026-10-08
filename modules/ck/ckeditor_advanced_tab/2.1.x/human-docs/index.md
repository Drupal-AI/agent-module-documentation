# CKEditor Advanced Tab — manual setup guide

**CKEditor Advanced Tab** (`ckeditor_advanced_tab`) integrates the CKEditor 4
`dialogadvtab` plugin into Drupal. That plugin restores the **"Advanced" tab**
inside element dialogs — the link, image, and table dialogs — giving editors
fields for an element's **id**, inline **style**, stylesheet **classes**, and
text **direction** (`dir`). It is a thin integration: enabling the module simply
tells CKEditor to load the plugin's JavaScript, so the advanced tab appears
wherever a dialog supports it, and other plugins no longer need to reimplement
those fields themselves.

An important caveat: this module is for the **legacy CKEditor 4 editor** (core's
`ckeditor` module), which is deprecated and removed in favour of CKEditor 5 in
newer Drupal. Reach for it only on sites still running CKEditor 4 text
formats — typically during a migration where some CKEditor 4 formats remain.

There is no settings form, route, permission, or service — enabling the module
and using a text format configured with CKEditor 4 makes the tab available. Its
security surface is limited to what CKEditor 4 already exposes: the id, class, and
style values an editor enters are still subject to the text format's normal
filtering when the content is saved.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. It applies automatically to
CKEditor 4 dialogs once enabled, as described below.

## How to use it

The module has no button of its own. Once enabled, edit a text format that uses
the **legacy CKEditor 4** editor (at **Administration → Configuration → Content
authoring → Text formats and editors**), and the **Advanced** tab will appear in
the relevant element dialogs. When an editor opens the link, image, or table
dialog, the Advanced tab lets them set the element's id, CSS classes, inline
style, and text direction without switching to source view. Just make sure the
text format's filters allow the attributes you want editors to be able to add.
