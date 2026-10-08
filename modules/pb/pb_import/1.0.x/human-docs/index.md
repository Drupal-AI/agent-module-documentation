# PB Import — manual setup guide

**PB Import** (Paragraphs Bundles Import, `pb_import`) is a bulk-content import tool
built around the **Paragraphs** module. It streamlines large content operations by
importing **nodes** and complex **paragraph** structures from well-structured **CSV
files**, with built-in validation, error reporting, and row-level skip logging.
It is designed for content migrations, bulk operations, and automated workflows —
especially the structured, paragraph-based landing pages that page-builder setups
produce.

Beyond raw CSV import it also helps with the surrounding plumbing: it can register
files uploaded out-of-band via SFTP/FTP (creating the Drupal file entities for
them), create and assign taxonomy terms (multiple terms separated with a pipe `|`),
and handle image fields including alt text and titles. It is aimed squarely at
trusted operators doing content-ops work, not at anonymous users.

Because it creates content from an external file, treat the import source as
untrusted input: validate your CSV, and apply a **safe text format** to any HTML
you import rather than trusting it into a permissive format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Paragraphs, then enable the module and its submodules.

There is **no global settings form** — PB Import works through a set of action
screens under the Content menu, described below.

## Where it lives in the admin menu

After installation, PB Import adds a group of screens under **Content → PB Import**:

| Screen | Path | What it does |
|--------|------|--------------|
| **Paragraphs List** | `/admin/content/paragraphs/paragraphs-list` | View, filter, edit, and delete all paragraphs in the system. |
| **Register Uploaded Files** | `/admin/content/paragraphs/register-uploaded-files` | Register files uploaded via SFTP/FTP so Drupal knows about them (creates file entities). |
| **Import Nodes** | `/admin/content/paragraphs/pb-import-node` | Bulk import content nodes from a CSV file. |
| **Import Paragraphs** | `/admin/content/paragraphs/pb-import-para` | Import hierarchical paragraph structures from a CSV file. |

## How to use it

1. Prepare a **well-structured CSV** matching the import you intend to run
   (nodes or paragraphs). PB Import validates the file and reports errors,
   skipping bad rows rather than failing the whole run.
2. If your media was uploaded over SFTP/FTP rather than through Drupal's UI, first
   visit **Register Uploaded Files** so those files become managed file entities
   the import can reference.
3. Run **Import Nodes** or **Import Paragraphs** and review the results — PB Import
   logs detailed, row-level messages so you can see exactly what was created or
   skipped.
4. Use **Paragraphs List** to review, filter, or clean up the paragraphs you have
   imported.

> **Handle imported markup safely.** Because you are importing content from an
> external file, apply a restrictive text format to any HTML you bring in — do not
> trust imported markup into a permissive format — and run imports only as a trusted
> operator.
