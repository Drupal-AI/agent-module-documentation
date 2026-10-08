# CKEditor Citation — manual setup guide

**CKEditor Citation** (`ckeditor_citation`) adds a toolbar button to CKEditor 5
that wraps text in HTML `<cite>` tags — the semantic element for citing creative
works such as books, music, artworks, and films. Instead of switching to the
Source view and typing the tags by hand, an editor clicks a button and the
citation markup is applied for them.

The button is flexible about how you apply it. You can click it to open a `<cite>`
tag and keep typing inside it, then click again at the end to close it. Or you
can write your text first, highlight the part you want to cite, and click the
button to wrap that selection. Clicking the button again on text that already has
citation tags removes them, so the same button toggles the markup on and off.

It depends on CKEditor 5 and has no settings page of its own. As with any plugin
that inserts specific markup, make sure the text format's allowed HTML permits the
`<cite>` tag, and enable this plugin only on text formats you trust, since it adds
markup to content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on per
text format, described under "How to use it" below.

## How to use it

Citation adds a toolbar button that you enable for each text format where you want
it:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **Citation** button from the
   *Available buttons* tray into the *Active toolbar*.
4. Make sure the format's **Allowed HTML tags** include `<cite>` so the citation
   markup survives filtering.
5. Click **Save configuration**.

When editing content in that format, select the text you want to cite and click
the Citation button to wrap it in a `<cite>` tag.
