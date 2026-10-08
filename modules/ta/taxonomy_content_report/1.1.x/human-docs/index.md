# Taxonomy Content Report — manual setup guide

**Taxonomy Content Report** (`taxonomy_content_report`) builds a content‑insight
report you can browse by clicking through a taxonomy tree. Pick a term in a
hierarchical sidebar and the report shows you the content tagged with that term
— and, because it rolls up descendants, selecting a parent term includes
everything tagged with its children too. It is aimed at editors and site owners
who want to see, at a glance, how content is distributed across a vocabulary.

Each content‑type section of the report is powered by an embedded **View**, so
you can fully customise the tables — columns, sorting, pager — through the
standard Views UI without writing code. On top of the tables it gives you a
summary dashboard with published/unpublished counts and a percentage bar per
content type, an optional Chart.js bar or pie chart, a date‑range filter by
created date, breadcrumb navigation showing the selected term's ancestor path,
and a one‑click "Edit View" shortcut. If a content type has no View assigned, a
built‑in fallback table is shown instead.

The module depends on core **Taxonomy**, **Node** and **Views** (and Views UI),
and provides its own view and administer permissions. It does need
configuration before it is useful — you tell it which vocabulary drives the
sidebar and which entity‑reference field on each content type points at that
vocabulary. Bear in mind the report surfaces content in aggregate, including
(optionally) unpublished nodes, so gate the report permission to the roles that
should see that overview. Note that this module is not covered by Drupal's
security advisory policy.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick a vocabulary, map content
   types to their taxonomy fields, and (optionally) assign Views.

## Where it lives in the admin menu

The settings form is at **Administration → Configuration → Content → Taxonomy
Content Report Settings** (`/admin/config/content/taxonomy-content-report`).
The report itself is then browsed with the taxonomy‑tree sidebar; select a term
to filter, and the summary, chart and per‑content‑type tables update to match.
