# PDF Embed View (1.0.x) — manual setup guide

**PDF Embed View** (`pdf_embed_view`) displays PDF files directly on the page
instead of offering a bare download link. It is a **field formatter**: on a
field's *Manage display* you switch the formatter to "PDF Embed Viewer" and the
PDF renders inline, opens in a modal dialog, or opens in a new browser tab —
whichever display mode you choose. It uses the browser's own PDF rendering, so it
needs no external viewer library.

This page documents the **1.0.x** line. This is the module's first release
(marked "no further development" on this branch — the ongoing work continues on
**1.1.x**, which is documented separately in its own version folder). On 1.0.x the
formatter targets PDF **File** fields and Media reference fields, and it is
mobile‑friendly. If you are choosing a version to install, prefer **1.1.x**, which
adds a dedicated Media formatter and a Views field plugin and refines the display
plugins.

Because everything is configured on a field's display, there is **no central
settings page** for this module — the setup happens entirely in the Field UI, as
described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure core File (and Media, if you use it) are on.

There is **no configuration page** for this module. You set it up per‑field on
*Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

PDF Embed View adds no admin settings page. You use it from **Structure → Content
types → *(your type)* → Manage display** (and the equivalent *Manage display* for
Media types), where the field's formatter dropdown gains a "PDF Embed Viewer"
option.

## How to use it

1. Make sure the field that holds your PDF is a **File** field (or a Media
   reference field pointing at a PDF/document media type).
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. Find the PDF field and set its **Format** to **PDF Embed Viewer**.
4. Open the formatter's settings (the gear icon) and choose a **display mode**:
   - **Inline** — the PDF is embedded on the page.
   - **Modal** — a link opens the PDF in a pop‑up dialog.
   - **New tab** — a link opens the PDF in a new browser tab.
5. Click **Save**. View a piece of content that has a PDF in that field to confirm
   it renders the way you chose.

The same steps apply to a Media reference field. PDF Embed View can also surface
PDFs referenced through Media inside a **View**.
