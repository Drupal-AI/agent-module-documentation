# Webform Views Integration — manual setup guide

**Webform Views Integration** (`webform_views`) exposes webform submissions — and
each of their individual element values — to the Views module. That lets you build
custom listings, reports, and dashboards of submission data using Views fields,
filters, sorts, and relationships, instead of being limited to Webform's own fixed
results table.

Core Webform stores every submission but only offers one built-in results view.
This module adds Views data for the webform submission entity and, crucially, maps
each webform **element** to a matching Views handler — so a select, checkboxes,
date, numeric, entity-reference, managed-file, composite, computed, hidden, or
term-checkboxes value can each be shown as a column, filtered, and sorted with
type-appropriate logic. It provides field, filter, sort, and relationship plugins,
including reverse entity-reference relationships and edit/duplicate/view operation
links per row.

It can also add your Views-based results as local-task **tabs** directly on a
webform, so editors reach a tailored report from the form itself. The whole thing
is handler-driven, which means custom or contributed webform elements can be given
their own Views handlers when needed. It depends on **Views** and **Webform**
(6.2+), and a bundled example submodule ships a sample form and view to copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick up the example submodule if you want a worked sample.

## Where it lives in the admin menu

There is no settings page. Everything happens in the **Views** UI at **Structure →
Views** (`/admin/structure/views`). When you create a view, the new base table
**Webform submissions** (and its per-element fields, filters, sorts, and
relationships) becomes available to choose from.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Views → Add view** and, for **View settings → Show**,
   choose **Webform submissions** as the base.
3. Add **fields** for the submission properties and webform elements you want as
   columns; add **filters** (for example by a select value, submission date, or
   webform) and **sorts** as needed. Each element uses a handler suited to its data
   type.
4. Add exposed filters if you want editors or visitors to search submissions, and
   add operation fields (edit / view / duplicate) for per-row actions.
5. Choose a display — page, block, or feed — and save. If you want the report to
   appear as a tab on the webform itself, the module can surface it there via local
   tasks.

To scope a view to the current user ("my submissions"), relate submissions to a
referenced entity, or report on file uploads, use the relationship and filter
plugins the module adds.
