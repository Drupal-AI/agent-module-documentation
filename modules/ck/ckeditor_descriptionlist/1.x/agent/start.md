<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Description List (ckeditor_descriptionlist) — agent index

Adds a **Description List (`dl`/`dt`/`dd`) plugin to CKEditor 5**. Version **dev**. Core `^10.3 || ^11`.
Depends on core `ckeditor5`.

**Common gotcha:** the text format's allowed-HTML must permit `<dl>`/`<dt>`/`<dd>`, or the filter
strips them on render — the usual reason such a plugin "doesn't work".