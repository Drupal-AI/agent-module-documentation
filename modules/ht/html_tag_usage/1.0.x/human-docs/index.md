# HTML Tag Usage — manual setup guide

**HTML Tag Usage** (`html_tag_usage`) scans the content of the formatted‑text fields
across your whole site and produces a report of exactly which HTML **tags and
attributes** are actually in use, broken down by text format — with the ability to
drill down to the specific entities that use any given tag or attribute.

It answers a question that comes up whenever you inherit or audit a site: *"I want to
tighten the 'Limit allowed HTML tags' filter, but I don't dare, because I don't know
what markup real content depends on."* Two common situations it's built for:

- You've taken over a site whose text formats don't restrict HTML (or allow far more
  than they should) and you want to lock them down without accidentally altering
  existing content — so you need to know what tags and attributes are genuinely in
  use first.
- Your data‑protection officer wants all `iframe` embeds from a video portal removed
  for GDPR compliance, and you need to know whether any content uses them, how many,
  and exactly which entities — to decide between a manual cleanup and a migration.

You pick which field types to scan, run a batch analysis, and get a per‑format report
of every tag+attribute combination with a count. Click any count to see the list of
entities that use it (linked to their edit forms, with paragraphs resolved to their
host entity). The report even generates a **candidate allowed‑HTML filter string**
per format covering everything currently used — a helpful starting point, though the
module is explicit that it may be insecure and must be reviewed before you use it.

> **Operational note:** on a large site the results table can grow very big, so this
> is best used on a **development or staging** environment and **uninstalled once the
> audit is done** to drop the table.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its core dependency.
2. [Configuration](configuration/index.md) — choose which field types to scan,
   generate and read the report, and set the permissions.

## Where it lives in the admin menu

Two places: **Configuration → Development → HTML Tag Usage**
(`/admin/config/development/html_tag_usage`) to choose which field types are scanned,
and **Reports → HTML Tag Usage** (`/admin/reports/html_tag_usage`) to generate and
read the report.
