# CKEditor Description List — manual setup guide

**CKEditor Description List** (`ckeditor_descriptionlist`) adds a Description List
button to CKEditor 5, letting editors author real definition lists — the HTML
`<dl>` element with `<dt>` terms and `<dd>` descriptions — directly in rich text.
This is the correct, semantic markup for glossaries, metadata pairs, and
FAQ‑style term/definition content, but CKEditor 5 does not offer it out of the box.
Without this module, editors end up faking definition lists with bold text and
line breaks, which looks roughly right but loses the meaning that assistive
technology and search engines rely on.

It depends only on core CKEditor 5 and is a content‑authoring enhancement with no
settings page of its own. The one recurring thing to check for any CKEditor plugin
that inserts specific markup is the text format: the format's allowed‑HTML filter
must permit `<dl>`, `<dt>`, and `<dd>`, or the filter strips them on render and the
editor's work vanishes. If the button seems to insert a list that then disappears
when saved, this is almost always the cause.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on per
text format, described under "How to use it" below.

## How to use it

Description List adds a toolbar button that you enable for each text format where
you want it:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **Description list** button
   from the *Available buttons* tray into the *Active toolbar*.
4. In the format's **Allowed HTML tags**, make sure `<dl>`, `<dt>`, and `<dd>` are
   permitted so the list survives filtering.
5. Click **Save configuration**.

When editing content in that format, click the button to insert a description
list, then fill in your terms and their descriptions.
