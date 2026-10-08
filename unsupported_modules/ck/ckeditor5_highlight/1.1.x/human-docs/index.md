# CKEditor5 highlight — manual setup guide

**CKEditor5 highlight** (`ckeditor5_highlight`) adds a **Highlight** (marker/pen)
button to Drupal's CKEditor 5 toolbar. It is a thin wrapper around the upstream
`@ckeditor/ckeditor5-highlight` plugin, giving content authors text-marking tools —
markers (a background colour) and pens (a text colour) — that are handy when
reviewing content or flagging passages for later. Highlighted text is output using
inline `<mark>` elements plus colour classes.

> **Deprecated / obsolete.** This module is marked obsolete and is superseded by
> **CKEditor 5 Plugin Pack** (`ckeditor5_plugin_pack`), which bundles the highlight
> feature along with many others. For new sites, prefer that module. Use
> CKEditor5 highlight only if you are maintaining an existing site that already
> depends on it.

The module depends only on core's CKEditor 5, requires PHP 8.1, and targets Drupal
10.1. It has no settings form — you enable its button per text format, and it
attaches its editor styling automatically for formats that use the Highlight
toolbar item.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page**. You add the Highlight button per text format,
described below.

## How to use it

This is a CKEditor 5 plugin module: you enable its button per text format.

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **Highlight** button into your
   active toolbar.
4. Make sure the format's allowed HTML tags permit the `<mark>` element and its
   colour classes so highlights survive saving.
5. Save the text format.

Editors can then select text and apply a highlight marker or pen. The module loads
the matching styling in the editor automatically for any field whose format enables
the Highlight toolbar item.
