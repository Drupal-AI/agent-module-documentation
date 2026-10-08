# Content Import — manual setup guide

**Content Import** (`contentimport`) bulk‑creates — or updates — nodes from an
uploaded CSV file. You pick a content type, choose whether you are creating new
content or updating existing content, upload a `.csv`, and the module creates one
node per row, mapping each column to a field on that content type. It is a
friendly, form‑driven alternative to the core Migrate system for the common job of
"load this spreadsheet of content into Drupal."

The first row of your CSV holds the **field machine names** that each column maps
to. Every import needs a `title` and a `langcode` column, and updates additionally
need a `nodeid` column so the module knows which node to change. Beyond that, the
importer is field‑type aware: it knows how to turn a cell into an image reference, a
taxonomy term (auto‑creating vocabularies and terms if needed), a user reference (by
email, auto‑creating accounts), a node reference (by title), a date, a boolean, a
geolocation, and more.

To make getting the columns right easier, the form can generate a **sample CSV** —
a header‑only file with exactly the columns the chosen content type expects. Each
run also writes a readable log so you can see which fields matched.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the import form step by step, the CSV
   rules, and how each field type expects its data.

## Where it lives in the admin menu

The import form sits at **Configuration → Content authoring → Content Import**
(`/admin/config/content/contentimport`) and is reachable by anyone with the core
**Administer site configuration** permission.

## How to use it

1. Prepare a CSV whose first row is the field machine names of your target content
   type (download a sample from the form to get these exactly right).
2. Go to **Configuration → Content authoring → Content Import**, choose the content
   type and import type, and upload the file.
3. Submit — a batch runs and creates or updates one node per row, then drops you at
   the content listing. Check the log if anything did not map as expected.

See [Configuration](configuration/index.md) for the full details of the form and the
CSV format.
