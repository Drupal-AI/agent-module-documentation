# Schema.org PublicationIssue — manual setup guide

**Schema.org PublicationIssue** (`schema_publication_issue`) adds the Schema.org
[`PublicationIssue`](https://schema.org/PublicationIssue) type to the JSON‑LD
structured data your site outputs. It is an add‑on for the **Schema.org Metatag**
framework, aimed at publishing sites: magazines, journals, and other periodicals
that want to describe an individual issue (its number, dates, and related
details) as structured data search engines can read.

Structured data is invisible markup that spells out what a page represents — here,
"this page is a specific issue of a publication." Once Schema.org Metatag is in
place, this module contributes the `PublicationIssue` vocabulary; you then map
your fields onto it through Metatag's settings screens, and the module writes the
matching JSON‑LD into the page head at render time.

The module has no settings form of its own and no content or access role. It
becomes useful as soon as you enable it alongside Schema.org Metatag; the field
mapping is done on the Metatag settings page. It depends only on `schema_metatag`
and supports Drupal 8 through 11. This release is covered by the Drupal security
advisory policy.

This guide is for a **human** working through the admin UI. An AI coding agent
should read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Schema.org Metatag dependency.
2. [Configuration](configuration/index.md) — where the PublicationIssue fields
   appear and how to map your content onto them.

## How to use it

Once enabled, the `PublicationIssue` type is available inside Schema.org Metatag.
You configure it under **Configuration → Search and metadata → Metatag → Settings**
(`/admin/config/search/metatag/settings`) by selecting the content type and
enabling the **Schema.org: PublicationIssue** option, then filling in the mapping.
See [Configuration](configuration/index.md) for the steps.
