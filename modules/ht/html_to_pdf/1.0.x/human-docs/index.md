# HTML to PDF — manual setup guide

**HTML to PDF** (`html_to_pdf`) is a small utility module that takes an HTML file
you upload and converts it into a PDF using the [Dompdf](https://github.com/dompdf/dompdf)
PHP library. It was written with a specific job in mind — turning HTML email
templates ("emailers") into downloadable PDFs — but it works for any well-formed
HTML you feed it.

The workflow is deliberately simple. You go to the upload page, choose an HTML
file, and submit it. The module renders it through Dompdf and the resulting PDF
downloads to your browser automatically. There is no library of saved documents
and no stored settings — it is a one-shot "upload, convert, download" tool.

A couple of things are worth knowing before you rely on it. First, your HTML must
be **well-formed**; if the file contains invalid characters or broken markup,
Dompdf throws an error and no PDF is produced. Second, because the module renders
whatever HTML is uploaded, treat uploaded files as untrusted and **only let people
you trust use the upload form**. Keep Dompdf's remote-resources feature disabled
(this is the default), which prevents an uploaded file from making the server fetch
external URLs through tags like `<img src>` or `@import`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its required
   Dompdf library with Composer, then enable it.

There is **no settings page** for this module — nothing to configure. Everything
happens on the upload form described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **`/admin/config/upload`** in your browser.
3. Choose a well-formed HTML file and submit the form.
4. The module converts it with Dompdf and the PDF downloads automatically.

If the conversion fails, check that the HTML is valid and free of stray/invalid
characters, then try again.
