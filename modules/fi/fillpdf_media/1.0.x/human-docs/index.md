# FillPDF Media — manual setup guide

**FillPDF Media** (`fillpdf_media`) knits the
[FillPDF](https://www.drupal.org/project/fillpdf) module together with Drupal
core's **Media** system. FillPDF lets you upload a fillable PDF template and
generate filled‑in PDFs from your site's entity data; FillPDF Media lets those PDF
templates be stored and managed as **Media entities**, so PDF‑form generation lines
up with the rest of your media library.

In practice it adds a convenient link to **edit the FillPDF form** from an
associated PDF Media entity, and it hides the FillPDF form elements that aren't
relevant once media integration is in play — smoothing the workflow for editors who
manage templates as media.

The one setup step it needs is a **Media type whose machine name is `pdf`**; the
module keys off that machine name. It depends on **FillPDF** and core **Media**, and
works on **Drupal 10.3 and 11**. It is commonly paired with
[FillPDF Comprehensive Mapper](https://www.drupal.org/project/fillpdf_comprehensive_mapper).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and FillPDF, and create the `pdf` media type.

This module has **no settings form of its own** — its only configuration is the
one‑time creation of a `pdf` media type, described below.

## Where it lives in the admin menu

FillPDF Media doesn't add its own admin page. You work with it through the **Media**
system (**Content → Media**, and **Structure → Media types**) and through FillPDF's
own administration under **Configuration → Media → FillPDF**. Once set up, PDF Media
entities gain a link to edit their associated FillPDF form.

## How to use it

1. Make sure **FillPDF** is installed and configured (it needs a PDF‑processing
   backend — see FillPDF's own documentation).
2. Create a **Media type** with the machine name **`pdf`** (see
   [Installation](installation/index.md)).
3. Upload your fillable PDF templates as media of that type. From a PDF Media
   entity you'll be able to jump straight to editing its FillPDF form.
