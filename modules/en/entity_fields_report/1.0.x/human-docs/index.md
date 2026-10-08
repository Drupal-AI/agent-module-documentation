# Entity Fields Report — manual setup guide

**Entity Fields Report** (`entity_fields_report`) adds an admin **report** that
lists the fields across your site — their types and where they're used, including
fields inside Paragraphs — so you can audit and understand your content model at a
glance. It's built for site builders and developers who need to see the shape of a
site's fields without clicking through every content type by hand.

The report supports **filtering** by entity type, bundle, field type, and field
name, so you can narrow it to exactly what you're investigating, and it offers
**CSV export** for taking the data into a spreadsheet for further analysis. It
covers all core field types as well as custom fields.

It works the moment you enable it — there's no configuration to do. The report is
gated by the module's own permission, so only roles you grant it to can view the
report; it has no access-control role beyond that. It depends on core **Node** and
**Paragraphs** and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no settings form** — the module simply provides a report page. See
"How to use it" below.

## Where it lives in the admin menu

The report is under **Reports → Entity Fields Report**
(`/admin/reports/entity-fields-report`).

## How to use it

1. Go to **Reports → Entity Fields Report**
   (`/admin/reports/entity-fields-report`).
2. Use the filters at the top to narrow the report by **entity type**, **bundle**,
   **field type**, or **field name**.
3. Click the export button to download the current report as **CSV** for analysis
   in a spreadsheet.

Make sure the role that needs the report has the module's view permission — grant
it under **People → Permissions** if a user gets an access-denied page.
