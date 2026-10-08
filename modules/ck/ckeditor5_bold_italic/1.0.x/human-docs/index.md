# CKEditor5 Bold and Italic — manual setup guide

**CKEditor5 Bold and Italic** (`ckeditor5_bold_italic`) changes what Drupal's
CKEditor 5 produces when an editor clicks **Bold** or **Italic**. By default, core
CKEditor 5 outputs the semantic tags `<strong>` and `<em>`. This module alters the
core Bold and Italic plugins so they output the presentational tags `<b>` and
`<i>` instead.

That difference matters on sites with a house markup standard, a design system, or
a downstream system that expects `<b>`/`<i>` rather than `<strong>`/`<em>`. Rather
than teaching editors to use Source editing or writing a filter to rewrite tags on
save, this module simply makes the toolbar buttons emit the tags you want in the
first place.

There is nothing to configure and no new button to enable — the module works the
moment it is turned on, transparently replacing the behavior of the existing Bold
and Italic buttons in every CKEditor 5 toolbar. It depends only on core's CKEditor
5 module and is covered by Drupal's security advisory policy. One thing to check:
if your text format uses the *Limit allowed HTML tags* filter, make sure `<b>` and
`<i>` are in the allowed list so they survive saving.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** and no button to add — enabling the module is
all it takes.

## How to use it

Once enabled, just use the Bold and Italic buttons as usual. Any text you make
bold is wrapped in `<b>`; any text you italicize is wrapped in `<i>`. If tags are
being stripped on save, edit the text format at **Administration → Configuration →
Content authoring → Text formats and editors** and confirm `<b>` and `<i>` are
allowed.
