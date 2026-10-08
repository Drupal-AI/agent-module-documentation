# Logger DB — manual setup guide

**Logger DB** (`logger_db`) stores structured logs in your Drupal SQL database and
gives you a rich, Views‑based UI to read them right inside the admin panel. It
captures each entry as a single JSON column — including raw placeholder values and
any nested metadata — and records timestamps with **microsecond precision**, so
you can measure how long operations took within a request.

On its own, Logger DB works with core's Drupal logger. But it really shines
alongside an extended logger such as **Logger** or **Monolog**: it is already
integrated with both and automatically extends them, so all their custom fields
and metadata land in the database and become browsable, filterable, and sortable
— including filtering on nested values via **JSONPath** (for example
`$.metadata.ai.token_usage.total`).

The admin reporting is flexible. You can build multiple log‑report pages that each
show only the columns you care about, format scalar values as plain text or
numbers and complex values as JSON or YAML, and filter by date/time range or by
any custom field. It also handles the housekeeping: export and import logs to and
from a file (with merge and deduplication), and clean up old entries by age or by
capping the total number kept.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings page and the log‑report
   pages, including retention and JSONPath filtering.

## Where it lives in the admin menu

Logger DB's settings live at its configuration route (`logger_db.settings`),
reached from the admin **Configuration** area. From there you manage retention and
the log‑report pages that display your stored entries.

## A word on sensitive data

A database log store grows over time and can contain sensitive detail. Set a
retention policy (by age or entry count), avoid logging secrets or personal data
in the first place, and restrict access to the log UI to trusted administrators —
logs can reveal internal workings of the site.
