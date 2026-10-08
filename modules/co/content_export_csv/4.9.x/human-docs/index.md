# Content Export CSV — manual setup guide

**Content Export CSV** (`content_export_csv`) adds a simple admin form that
downloads the nodes of a chosen content type as a CSV file — the kind of
spreadsheet you can open in Excel or Google Sheets. You pick a content type,
choose which fields to include, filter by publication status, and optionally
append each node's URL or strip HTML from the values, then download the result.
It's a quick way to get a content inventory or hand a data dump to someone who
doesn't use Drupal, without building a View or writing export code.

The form reveals the exportable field list for the type you pick, so you can
export just the columns you care about (title and body, say) rather than every
field. Multi-value fields are flattened into a single pipe-delimited cell, and
link and reference fields export their URL / target id. Under the hood the same
work is done by a reusable service, so developers can build CSV rows from custom
code too.

This is a **single-form utility**: there is no settings page and no configuration
entity. The only access control is one permission, **Access content export**,
which you grant to the roles allowed to run exports.

> **Heads-up:** the module's info file points its "Configure" link at a route that
> doesn't actually exist. The working page is the **export form** described below,
> at `/admin/content/content-export`.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the
`content_export_csv.export` service methods — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — grant the export permission and use
   the export form field by field.

## Where it lives in the admin menu

The export form is at **Content → Content export** (`/admin/content/content-export`).
You can also reach it from the **Export Content** action link on the main content
overview (`/admin/content`). It is gated by the **Access content export**
permission. See [Configuration](configuration/index.md) for the walkthrough.
