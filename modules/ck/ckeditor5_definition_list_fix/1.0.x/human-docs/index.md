# CKEditor 5 Definition List Fix — manual setup guide

**CKEditor 5 Definition List Fix** (`ckeditor5_definition_list_fix`) improves how
Drupal's CKEditor 5 handles semantic HTML **definition lists** — the `<dl>`, `<dt>`
(term), and `<dd>` (description) elements. By default, CKEditor 5 can normalize
definition-list markup in unwanted ways: converting elements into paragraphs and
inserting stray `<p>` tags inside terms and descriptions, quietly breaking valid
semantic structure as you edit and save.

This lightweight plugin preserves proper definition-list markup while editing. It
keeps `<dl>`, `<dt>`, and `<dd>` intact and stops the unwanted paragraph wrappers
from being injected, so glossaries, dictionaries, FAQ layouts, and other
structured, accessibility-focused content keep their intended semantics. It needs
no external libraries.

The module works automatically once you enable its plugin on a text format — there
are no configuration pages to fill in. It depends only on core's CKEditor 5 and
runs on Drupal 10, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page**. You enable the plugin per text format,
described below, after which it works automatically.

## How to use it

This is a CKEditor 5 plugin module: you turn its plugin on per text format.

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5.
3. In the CKEditor 5 toolbar configuration, enable the **Definition List Fix
   Plugin**.
4. Make sure the format's allowed HTML tags permit `<dl>`, `<dt>`, and `<dd>` so
   the markup is not stripped by the filter.
5. Save the text format.

From then on the plugin works automatically: definition-list markup is preserved
during editing and saving, with no unwanted paragraph wrappers inserted. No
further configuration is required.
