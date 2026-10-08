# Taxonomy search admin form — manual setup guide

**Taxonomy search admin form** (`taxonomy_search_admin_form`) adds an admin-facing
search form for taxonomy terms across **all** vocabularies. Instead of browsing
vocabulary by vocabulary to check whether a term already exists, an administrator can
type a name and find matching terms directly.

The problem it solves is small but real on large projects: when a site has thousands of
taxonomy terms spread across many vocabularies, finding an existing term — or checking
one before creating it, to avoid duplicates — becomes tedious. This module gives you a
single search form for that lookup. The term search respects Drupal's normal taxonomy
access, and the module carries no access-control role of its own beyond the permission
it provides.

There is no configuration form — the module simply provides the search form and its
permission once enabled. Note this project is **not covered by Drupal's security
advisory policy**, which is worth knowing before using it on a production site.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, grant the module's permission (on **People → Permissions**,
`/admin/people/permissions`) to the roles that should be able to search terms, then
open the search form and type a term name to find matching terms from any vocabulary.
It is most useful as a quick "does this term already exist?" check before adding new
terms, to keep vocabularies free of duplicates.
