# Dropcap Ckeditor — manual setup guide

**Dropcap Ckeditor** (`dropcap_ckeditor`) adds a **drop‑cap** button to the
CKEditor toolbar. A drop cap is that decorative oversized initial letter (or
short lead‑in phrase) at the start of a paragraph, spanning two or more lines of
text — the kind of typographic flourish you see at the opening of a magazine
article. With this module, authors can insert one from the WYSIWYG editor without
writing any HTML by hand.

Clicking the toolbar button opens a small dialog where the author types the text
to style and chooses a **font size** (in pixels) and a **font colour**; the module
then inserts the styled markup for them. It's a CKEditor plugin — this 8.4.x
branch targets CKEditor 4 — and it has no dependencies of its own.

There's a practical catch worth knowing up front: the drop‑cap markup needs HTML
tags that Drupal's **Basic HTML** text format strips out. So you'll want to use it
with a **Full HTML**–style format (or a custom format that allows the needed
tags). If someone selects it while editing in Basic HTML, the dialog shows a
notice explaining that full HTML is required. Access is tied to the text format:
only users allowed to use a given format can open the dialog for it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** for this module — you enable the drop‑
cap button per text format from Drupal's text‑formats screen, described in "How to
use it" below.

## Where it lives in the admin menu

Dropcap Ckeditor adds no admin settings page. You switch it on by adding its
button to a text format's editor toolbar at **Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`). The button then
appears in the editor for any content using that format.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a **Full HTML**–style format (or any
   format whose CKEditor 4 toolbar you can configure and that allows the drop‑cap
   markup).
3. In the toolbar configuration, **drag the Dropcap button** from the available
   buttons into the active toolbar, then save the format.
4. Edit a piece of content using that format. Click the **Dropcap** button, enter
   the text, choose a font size and colour in the dialog, and insert it.

> **Tip:** If the drop cap doesn't render as expected, check that the text format
> allows the markup — Basic HTML strips the tags it needs, which is why a Full
> HTML–style format is recommended. To turn the feature off for a format, remove
> the Dropcap button from that format's toolbar.
