# External Link Update — manual setup guide

**External Link Update** (`elink_update`) is a bulk‑editing tool. It scans the
**body field** of your nodes for external links and adds a chosen `target`
attribute (`_blank`, `_self`, `_parent`, or `_top`) and, optionally, one or more
`rel` attributes (`nofollow`, `noreferrer`, `noopener`) to them — across many
nodes at once, using Drupal's Batch API. It writes the attributes directly into
the body's stored HTML rather than doing it with JavaScript at display time.

This solves a common, tedious problem: many sites want external links to open in
a new tab and carry `rel="noopener noreferrer"` for security, or `rel="nofollow"`
for SEO — and doing that by hand across a large content set is impractical. It is
especially handy after migrating or importing content, or for keeping a
decoupled/headless front end supplied with links that already have the right
attributes.

You can run the update in **two ways**: through an admin form where you pick the
content types and the attributes to apply, or headless via a **Drush command**
that runs the same batch from the command line (useful when the team has no
command‑line access to trigger it through the UI, or when scripting it into a
deployment). It only rewrites link *attributes* in existing body markup — it never
changes where a link points. One caveat: if a text format is set to "limit allowed
HTML tags and correct faulty HTML", anchor links in that content will not be
updated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — run the update from the admin form
   or via Drush.

## Where it lives in the admin menu

The update form is at **Configuration → External Link Update**
(`/admin/config/elink-update`). It requires the **Access administration pages**
permission.
