# Styles Combo Plus — manual setup guide

**Styles Combo Plus** (`stylescomboplus`) is a **CKEditor 4** plugin that gives
editors a *Styles +* drop-down in the toolbar — much like core's built-in Styles
combo, but with one important improvement: styles that target images actually
apply to images. In stock Drupal, the Styles drop-down cannot add CSS classes to
images inside CKEditor, and this module works around that limitation.

The problem is a long-standing CKEditor issue: when the editor turns an `<img>`
into an image "widget", the ordinary Styles combo can no longer attach a class to
it. Styles Combo Plus uses a modified version of CKEditor's StylesCombo JavaScript
so that when a style rule targets `img`, it additionally emits an image-widget
variant of that rule. The result is that "Rounded image" or "Full-width image"
style you defined finally sticks to the picture. You configure it almost exactly
like the core Styles combo — a textarea of style definitions, one per line — so it
is a near drop-in replacement wherever image styling matters.

You enable the module, then add and configure the *Styles +* button on the text
formats where you want it; it does not do anything until you place the button and
list some styles. The module also ships a small stylesheet that is loaded both
inside the editor (so styled classes preview as you write) and on the front end
(so the output matches). It depends on core's **CKEditor** (CKEditor 4 — note, not
CKEditor 5). Because the style list is administrator-configured text-format
settings, there is no untrusted-input surface here.

> **Heads-up:** this is a CKEditor **4** plugin. It has no effect on CKEditor 5,
> which became Drupal's default rich-text editor from Drupal 10. Also, the
> maintainer notes that enabling the *"Limit allowed HTML tags and correct faulty
> HTML"* filter can stop the *Styles +* drop-down from working — a CKEditor
> limitation with no known workaround at the time of writing.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the *Styles +* button to a text
   format and define your styles, line by line.

## Where it lives in the admin menu

Styles Combo Plus has no page of its own in the admin menu. You configure it from
the text-format editor settings at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`) — pick a format that uses
CKEditor, drag the *Styles +* button into the toolbar, and fill in its settings.
See [Configuration](configuration/index.md).
