# CKEditor TextIndent — manual setup guide

**CKEditor TextIndent** (`ckeditor_textindent`) integrates the third-party
**TextIndent** plugin for **CKEditor 4** into Drupal. It adds a toolbar button
(and an optional keyboard key) that toggles a first-line / text-indent style on
paragraphs — the classic "indent the first line of a paragraph" behaviour common
in long-form and print-style content.

This is a **CKEditor 4** integration. It depends on Drupal's contrib **CKEditor**
module (the CKEditor 4 editor), not on core's CKEditor 5. If your site uses
CKEditor 5, this module does not apply; look for a CKEditor 5 equivalent instead.
It supports Drupal 8, 9, and 10. There is no settings page — you enable the button
per text format on the editor's toolbar.

> **Maintenance note:** the project is currently marked *Seeking new maintainer*,
> and CKEditor 4 has reached end of life upstream. Factor that into any decision to
> adopt it on a new build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Setup is a single per-format
toolbar step, described below.

## Where it lives in the admin menu

CKEditor TextIndent adds no admin page. You enable its button per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`): edit a format that uses the CKEditor 4 editor
and drag the **Text Indent** button into the active toolbar, then save. Editors
place the caret in a paragraph and click the button to toggle the indent.
