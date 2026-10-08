# Webform Submission Import — manual setup guide

**Webform Submission Import** (`webform_submission_import`) adds an **Import Submissions**
tab to every webform, so an administrator can upload a CSV file and bulk-create webform
submissions from its rows. It's the practical way to load historical data into a webform:
migrating results from a legacy form or system, seeding a form with test data from a
spreadsheet, importing survey responses collected offline, or moving submissions between
environments (export a CSV on one site, import it on another).

Each imported row runs through the webform's **normal validation pipeline**, exactly as if
someone had filled the form in by hand — so required-field rules and element constraints
still apply. Rows that fail validation are skipped and logged rather than aborting the whole
import, and any spreadsheet columns that don't match a form field are simply ignored. Imports
only run while the webform is **open**.

The module is deliberately simple: it depends on the **Webform** module (6.x) and adds one
admin form. It has **no settings page, no permissions of its own, and no Drush commands** —
access to the import tab is governed by the standard *Administer webform* permission.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

There is no central settings page. The module adds an **Import Submissions** tab to each
individual webform at **Structure → Webforms → [your webform] → Import Submissions**
(`/admin/structure/webform/manage/{webform}/submission_import`). You need the *Administer
webform* permission to see it.

## How to use it

### 1. Prepare your CSV

The CSV's **first row is the header row**, and each header must exactly match a **webform
element key** (the machine name of a field). The import form conveniently lists the target
webform's fields, split into **Required Fields** and **Additional Fields**, so you can see
which columns your CSV needs. (Multi-page/wizard pseudo-elements are excluded from that list.)

- Each row after the header becomes one submission.
- Columns whose header doesn't match a field are ignored, so extra spreadsheet columns are
  harmless.

### 2. Run the import

1. Go to the webform, then its **Import Submissions** tab.
2. Upload your `.csv` file.
3. Submit. The module reads the file, maps each row to the matching fields, validates it, and
   creates a submission. When it finishes it reports how many submissions were imported
   successfully.

### 3. Good things to know

- **Invalid rows are skipped, not fatal.** Any row that fails the webform's validation is
  logged (to the `webform_submission_import` log channel) and the import moves on to the next
  row.
- **The webform must be open.** Submissions are only created while the webform is accepting
  input.
- **No de-duplication.** Importing the same CSV twice creates duplicate submissions, so import
  each file only once.
- **Large files run in one request.** The import raises PHP's memory and time limits while it
  runs to survive big files, but it processes synchronously (no background batch), so a very
  large import will block until it finishes. For huge datasets, consider splitting the CSV.
