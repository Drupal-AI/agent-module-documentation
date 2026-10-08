# FillPDF — manual setup guide

**FillPDF** (`fillpdf`) fills the fields of an uploaded **PDF form** (an AcroForm)
with data from your Drupal site — nodes, users, webform submissions, and so on —
then hands the visitor the finished PDF to download, or saves it to a file, or
redirects them to it. You upload a fillable PDF template, map each of its form
fields to a Drupal **token** (like `[node:title]`) or an image field, and from then
on any matching entity can be turned into a completed document. It's the standard
way to generate contracts, applications, certificates, invoices, or filled-in
government/registration forms from site content.

You create a **FillPDF form** by uploading a `.pdf` template; FillPDF parses its
fillable fields and lets you map each one. Generating a PDF is a matter of visiting
a `/fillpdf` link with the form id and an entity id — you can offer it as a
"Download as PDF" link on a page. Filenames can be built from tokens (e.g.
`Invoice-[node:title].pdf`), output can be flattened (fields baked in) or left
fillable, and PDFs can be saved to **private** storage for later retrieval.

The actual filling is delegated to a **backend** that you choose in settings, and
this is the key setup decision: FillPDF itself does not include a PDF engine.
You pick one of three:

- **FillPDF Service** — a hosted API; the simplest to run because there's no
  server-side software to install, but you need a service **API key** and PDFs are
  sent to the remote endpoint.
- **FillPDF LocalServer** — a small self-hosted service (typically Docker) you run
  yourself, so data stays on your infrastructure.
- **pdftk** — the `pdftk` binary installed directly on your server; fully
  on-server, and it additionally supports PDF encryption and passwords.

Access to generating PDFs is permission-controlled (users can be limited to
content they may already view), and it depends on core File, Options, Serialization
and Views plus the contrib **Token** module.

This guide is written for a **human** setting FillPDF up through the admin UI. If
you want terse, token-cheap references for an AI coding agent (the generate URL
parameters, services, plugin types, and hooks), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install FillPDF (and Token) with
   Composer, enable it, and set up a backend.
2. [Configuration](configuration/index.md) — the global settings (backend choice,
   endpoints, API key, storage schemes), plus creating a FillPDF form and mapping
   its fields.

## Where it lives in the admin menu

- **Global settings:** **Configuration → Media → FillPDF**
  (`/admin/config/media/fillpdf`).
- **PDF templates / forms:** **Structure → FillPDF forms**
  (`/admin/structure/fillpdf`).

Both are gated by the **administer pdfs** permission.

## How to use it

1. Install FillPDF and set up a backend (see [Installation](installation/index.md)
   and [Configuration](configuration/index.md)).
2. Upload a fillable PDF template at **Structure → FillPDF forms** to create a
   FillPDF form.
3. Map each PDF field to a token or image field.
4. Generate a PDF by visiting `/fillpdf?fid=<form id>&entity_id=<type>:<id>` — for
   example link it as "Download as PDF" from a content page.

See [Configuration](configuration/index.md) for the full walk-through.
