# DOCX to HTML Converter — manual setup guide

**DOCX to HTML Converter** (`docx_to_html`) gives content authors a self-service
admin page that turns a Word `.docx` file into clean HTML they can paste straight
into a rich-text field. It exists because, since CKEditor 5, the free "Paste from
Word (Office)" feature is limited — so pasting a Word document directly into an
editor often loses formatting. This module fills that gap using the bundled
[Mammoth.js](https://github.com/mwilliamson/mammoth.js) library, which produces
tidy, semantic HTML rather than Word's bloated markup.

The important thing to understand is that **all conversion happens in your
browser**. When you pick a `.docx` file, the JavaScript reads it locally, converts
it, and shows a preview on the page — nothing is uploaded to, parsed by, or stored
on the server. A "Copy the HTML" button then copies the generated markup to your
clipboard so you can paste it into any long-text field. Because the whole process
is local to the person using the tool and there is no persistence, your source
documents never leave your machine.

Mammoth handles a wide range of Word styling: headings, lists (with customisable
mapping), tables, footnotes and endnotes, images, bold/italic/underline/
strikethrough/superscript/subscript, links, line breaks, text boxes and comments.
Two practical caveats: CKEditor 5 enforces its own allowed-tags rules, so some
tags or attributes (for example `H1` or `IMG`) may be filtered out when you paste
— check your text format if something disappears. And when you paste HTML into a
Drupal field, make sure the target text format can sanitise dangerous markup
(such as `<script>` tags).

The module works the moment you enable it; there is nothing to configure. Access
to the converter page is controlled by a dedicated permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the access permission.

There is **no configuration form** for this module. The converter page itself is
the whole interface, described in "How to use it" below.

## Where it lives in the admin menu

Once enabled, the tool sits at **Configuration → Content authoring → DOCX to HTML
Converter**, reachable directly at `/docx-to-html`. It also appears as an admin
shortcut for quick access. Seeing the page requires the **Access DOCX to HTML
Converter** permission.

## How to use it

1. Go to `/docx-to-html` (or **Configuration → Content authoring → DOCX to HTML
   Converter**).
2. Choose a `.docx` file from your computer. Only Word documents are accepted —
   the tool checks the file type before converting.
3. The converted HTML preview appears automatically below the file input,
   rendered with your site's front-end theme.
4. Click **Copy the HTML** to copy the whole converted result to your clipboard.
5. Paste it into the long-text field you are editing. Afterwards, rely on that
   field's text format to clean up anything the editor should not keep.
