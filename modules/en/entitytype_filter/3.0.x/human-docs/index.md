# Entity Fields Search — manual setup guide

**Entity Fields Search** (`entitytype_filter`) is a developer‑focused module that
gives you a single administrative page to **inspect, filter, and export the
fields attached to Drupal entities and bundles**. Instead of clicking through
many separate configuration pages or reading configuration exports to understand
how fields are set up, you get all the fields for a chosen entity and bundle
listed on one screen.

It works across Content Types, Block Types, Paragraph Types, Media Types, and
custom entity types. You can filter the field list by entity type and bundle,
search entities by title, and optionally narrow results by field type. The
results can be **exported to CSV** — including entity type, bundle, field name,
field label, and field type — which makes it handy for audits, migrations,
refactoring, and documentation.

This is a site‑building and developer utility: it surfaces admin‑facing field
configuration and has no content or access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — using the Entity Fields Search page,
   field by field, and exporting to CSV.

## Where it lives in the admin menu

Once enabled, the search page is available at **`/admin/entitytypes-filter`**.
Everything the module does happens on that page.
