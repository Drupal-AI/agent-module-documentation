# Entity Export CSV — manual setup guide

**Entity Export CSV** (`entity_export_csv`) exports any content entity — nodes,
users, taxonomy terms, media, and so on — to a CSV file. What sets it apart from a
quick Views export is the control it gives you: a site builder chooses which entity
types and bundles may be exported, and then, field by field, exactly how each value
is written into columns. It is a self-service way to let non-technical editors pull
content into a spreadsheet or an external system without building a View.

It works in two stages. First, on a **settings** page, you whitelist which content
entity types (and optionally which bundles) are allowed to be exported. Second, on
an **export** form, a user picks an enabled type/bundle and, per field, whether to
include it and how to render it. You can also save reusable export definitions as
configuration entities — with a chosen delimiter and a full field-to-column map — so
the same export can be repeated and deployed across environments.

The clever part is how fields become columns. Each field is handled by a
*field-type export plugin*, and the module ships plugins for plain fields plus
address, entity reference, file, link, datetime, date range, timestamp, list, and
geolocation fields. These control how multi-value and multi-property fields are
flattened — everything into one delimiter-separated column, or split into one column
per property. Developers can add a plugin to support a custom field type. Large
exports run through Drupal's Batch API and the finished file is streamed (preferring
the private filesystem for access-controlled downloads).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — whitelist entity types, run and save
   exports, the field options, and permissions.

## Where it lives in the admin menu

The settings page is at **Configuration → Content authoring → Entity Export CSV →
Settings** (`/admin/config/content/entity-export-csv/settings`), saved export
configurations at `/admin/config/content/entity-export-csv/configurations`, and the
interactive export form under **Content** at `/admin/content/entity-export-csv`.
