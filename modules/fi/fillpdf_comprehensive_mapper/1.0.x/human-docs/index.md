# FillPDF Comprehensive Mapper — manual setup guide

**FillPDF Comprehensive Mapper** (`fillpdf_comprehensive_mapper`) is a small
extension for the [FillPDF](https://www.drupal.org/project/fillpdf) module. FillPDF
lets you fill in editable PDFs with data from your Drupal site, and each FillPDF form
maps the PDF's editable fields to entity‑based tokens. If you maintain many similar
PDFs, keeping all those mappings in sync by hand is tedious. This module solves that
by letting you designate **one FillPDF form as the master** — the "comprehensive
mapper" — whose field mapping is then copied onto **all** your other FillPDF forms
automatically.

The idea is to maintain every possible field in a single, deliberately exhaustive
"master" PDF form. Whenever you save the module's settings, or edit and save the
designated master form itself, its mappings are propagated across every other
FillPDF form on the site: each PDF field whose key matches the master inherits the
master's mapping. It is an alternative to having multiple PDF files share one form,
which FillPDF does not natively support.

> **Important — read before enabling.** Configuring this module **overwrites the
> existing field mappings on all your other FillPDF forms** with the master's. That
> is the whole point, but it is destructive: if you only want to bulk‑update a
> subset of forms, this module is not the right fit yet. Set the master form
> deliberately, and back up your configuration first.

FillPDF Comprehensive Mapper depends on **FillPDF** and works on **Drupal 10.3,
11, and 12**. It operates on FillPDF's *form configuration* only — it does not
upload, read, or move PDF files itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and FillPDF.
2. [Configuration](configuration/index.md) — choose the master form and understand
   what saving does.

## Where it lives in the admin menu

Once enabled, the settings form sits at
**`/admin/config/media/fillpdf/comprehensive-mapper`** (reachable from the module's
**Configure** link), alongside FillPDF's own pages under **Configuration → Media →
FillPDF**. It is gated by FillPDF's **Administer PDFs** permission.

## How to use it

1. Create the FillPDF form you want to use as the source — the "master" that
   contains every field mapping you want propagated.
2. Go to the settings page and **select that form** as the comprehensive mapper.
3. Save. Its mapping is immediately copied onto all your other FillPDF forms. From
   then on, editing and saving the master re‑applies its mappings everywhere.
