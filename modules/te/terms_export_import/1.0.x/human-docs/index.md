# Taxonomy Export / Import — manual setup guide

**Taxonomy Export / Import** (`terms_export_import`) is a simple admin tool for
moving taxonomy terms around as CSV files. It lets an administrator export all the
terms from any vocabulary to a CSV, edit that file, and import terms back into
Drupal from a CSV — with validation on import to help keep the data accurate.

It is useful whenever you need to work with terms in bulk rather than one at a
time: bulk‑creating or updating terms, migrating a taxonomy from one site to
another, or keeping a backup of an important term set. The typical loop is to
export a vocabulary, open the CSV in a spreadsheet to add new terms, update
descriptions, or adjust parent relationships, and then re‑import the edited file.

There is no configuration to set up — the module provides two admin pages, one for
export and one for import, and you simply run them. It depends on core **Taxonomy**
(`taxonomy`), supports **Drupal 10 and 11**, and ships no submodules.

A word of caution: **imported terms are content**, and the tool creates or updates
real taxonomy terms from whatever is in the CSV. Keep the export and import pages
restricted to trusted administrators, and treat any CSV from an outside source
with care — review it before importing, since you are trusting its contents to
become terms on your site. (This project is not yet covered by Drupal's security
advisory policy.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The tool provides two pages:

- **Export:** `/admin/config/terms-export` — select a vocabulary and download its
  terms as a CSV.
- **Import:** `/admin/config/terms-import` — upload a CSV to create or update
  terms.

## How to use it

1. Go to the **export** page (`/admin/config/terms-export`), choose the vocabulary
   you want, and download the generated CSV.
2. Edit the CSV in a spreadsheet — add new rows for new terms, update descriptions,
   or change parent relationships as needed.
3. Go to the **import** page (`/admin/config/terms-import`) and upload the edited
   file. The module validates the data as it imports, so problems in the file are
   surfaced rather than silently applied.
