# Microsoft Document Viewer — manual setup guide

**Microsoft Document Viewer** (`md_viewer`) adds a **field formatter** to core's File
field that displays an attached Office document — Word, Excel, PowerPoint, or a PDF —
**embedded inline on the page** instead of as a download link. It does this by handing the
file's public URL to Microsoft's free hosted **Office Web Apps viewer**
(`view.officeapps.live.com`), which renders the document in an embedded frame. For
documents meant to be read rather than saved — a report, a price list, a slide deck — this
keeps the visitor on your site and works even if they have no Office software installed.

There is one thing you must understand before you deploy it, because it is structural
rather than a bug: **the rendering is done by Microsoft's servers, not yours.** That has
two consequences.

First, **the file must be publicly reachable from the internet.** Microsoft's fetcher has
to be able to download it, so a private‑filesystem file, an intranet site, or anything
behind HTTP authentication will not render. If it renders, the file is public — those are
the only two outcomes. This also means it won't work on a typical local development
environment or behind a firewall.

Second, **every document displayed this way is sent to a third party.** The file's URL is
handed to Microsoft, whose infrastructure retrieves and processes the content. For a
published brochure that is unremarkable; for anything with personal data, commercial
confidentiality, or an internal audience it is a disclosure that needs a decision — and in
the EU a lawful basis and a mention in the privacy notice. Do not attach this formatter to
a field that can hold restricted documents.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its File dependency.

There is **no configuration page** for this module — it has no settings form. You switch
it on per field display, and adjust the frame's width and height in that field's settings,
as described under "How to use it" below.

## Where it lives in the admin menu

Microsoft Document Viewer adds no admin page. You use it entirely from **Structure →
Content types → *(your type)* → Manage display**, by choosing its formatter for a File
field.

## How to use it

1. Add a **File** field to a content type (for example Basic Page) on the type's **Manage
   fields** form. The File field type provides a single widget — **File** — so choose that.
2. Make sure the field stores files on the **public** filesystem — Microsoft must be able
   to fetch them (see the note above).
3. On the content type's **Manage display** form, find the File field and set its format to
   **Embedded Microsoft Document Viewer Formatter**.
4. Optionally open the formatter's settings to change the viewer's **width** and
   **height**. By default the frame is 100% wide and 600px tall with no border. The output
   is rendered through the `mdoc-viewer-field.html.twig` template if you need to customise
   the markup.
5. Save, then view a piece of content with a document attached — it should appear embedded
   inline rather than as a download link.
