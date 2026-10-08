# CKEditor Blockquote Attribution — manual setup guide

**CKEditor Blockquote Attribution** (`ckeditor_blockquote_attribution`) extends
the standard CKEditor 4 Blockquote button so editors can create properly
attributed quotations. Instead of a bare `<blockquote>`, it wraps the selected
text in semantic HTML5 markup —
`<figure><blockquote>…</blockquote><figcaption>Source</figcaption></figure>` —
which is the standard, accessible way to show that content is quoted from a named
source.

When an editor uses the button, a dialog asks for the **source**, which becomes
the `<figcaption>`. Editing an existing attribution repopulates the Source field
from the markup, so quotations remain editable. The plugin handles multiple
selected paragraphs, works in both editor Enter modes, and prevents nested
blockquotes by unwrapping any blockquote inside the selection. The visual styling
of the figure, blockquote, and caption is left to your theme.

Two things to note. This targets the **legacy CKEditor 4 editor** (core's
`ckeditor` module), not CKEditor 5, so it applies only to sites still using
CKEditor 4 formats. And because the output is markup in your content, make sure
the text format allows `figure`, `figcaption`, and `blockquote[cite]` so the
attribution survives filtering on save. The citation text is inserted through
CKEditor's DOM API and then filtered by the text format on output — there is no
unfiltered raw-HTML path.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You add its toolbar button
per text format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on a format that uses the legacy **CKEditor 4** editor.
3. In the CKEditor settings, drag the **Blockquote Attribution** button (it lives
   in the *blocks* toolbar group) into the toolbar.
4. Make sure the format's filters allow `figure`, `figcaption`, and
   `blockquote[cite]` so the markup survives filtering.
5. **Save configuration**.

Editors can then select some text, click the button, and type the source in the
dialog's **Source** field to produce a semantic, attributed quotation.
