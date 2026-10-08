# CKEditor5 Fullscreen — manual setup guide

**CKEditor5 Fullscreen** (`ckeditor5_fullscreen`) adds a single **Fullscreen** (maximize)
button to the CKEditor 5 toolbar. Clicking it expands the editor to fill the whole browser
viewport — hiding the admin toolbar and other page chrome — for a distraction‑free writing
experience, and clicking it again restores the normal in‑page layout. It's especially handy
for editing long‑form articles, reviewing raw HTML with the Source Editing plugin, or
working with a small editor squeezed into a narrow admin column.

The module is deliberately tiny. It registers one CKEditor 5 plugin that provides the
toolbar button and the CSS/JavaScript that positions the editor as a full‑viewport overlay.
It adds **no field type, no settings form, no permissions, no Drush commands, and no
configuration of its own** — its entire footprint is the `Fullscreen` button appearing in a
text format's toolbar. Because it is purely an editing‑UI enhancement, it has **no effect on
stored content, filters, or output**; it only changes how the editor behaves in the browser.
The module targets **Drupal 10 or 11** and depends on core's **CKEditor 5** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including how the `data-fullscreen` overlay is
styled — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. You turn the button on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), in each format's CKEditor 5 toolbar configuration.

## How to use it

You enable the button on a per‑text‑format basis by adding it to that format's toolbar:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses CKEditor 5
   (for example *Full HTML* or *Basic HTML*).
2. In the CKEditor 5 toolbar builder, drag the **Fullscreen** button from the *Available
   buttons* tray into the *Active toolbar* tray, in whatever position you want.
3. Click **Save configuration**.

Now, when an editor uses that format, the toolbar shows a Fullscreen button; clicking it
maximizes the editor to the full viewport, and clicking it again (it now shows a "return to
normal" icon) restores the page. Enable it only on the formats where it's useful, and remove
it by dragging **Fullscreen** back out of the active toolbar. The button only does anything on
formats whose editor is CKEditor 5.
