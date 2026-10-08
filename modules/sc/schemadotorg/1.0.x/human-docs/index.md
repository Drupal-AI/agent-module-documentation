# Schema.org Blueprints — manual setup guide

**Schema.org Blueprints** (`schemadotorg`) uses [Schema.org](https://schema.org/)
types and properties as the **blueprint for your Drupal content architecture**.
Instead of hand-building content types and fields, you map a Drupal entity type and
bundle to a Schema.org type — say, map a node to `Person` — and the module creates
the bundle and generates its fields from that type's Schema.org properties, picking
sensible field types, widgets, and formatters and converting Schema.org's
CamelCase names into Drupal-safe machine names.

This is the **base module** of a large suite. On its own it ships the full
Schema.org vocabulary (as CSV data), the two config entities that record your
mappings, a set of services that answer questions about the vocabulary, global
settings, Drush commands, and a rich set of alter hooks. It is aimed at building a
consistent, standards-based content model — and it becomes the foundation that
dozens of submodules build structured output and integrations on top of (JSON-LD,
JSON:API, metatags, and integrations with many content and UX contrib modules).

Two things are worth knowing up front. First, the **base module has no UI for
adding mappings** — you create them with Drush (`drush schemadotorg:create-type`)
or through the mapping-manager service. The point-and-click "add mapping" form lives
in the separate **Schema.org Blueprints UI** (`schemadotorg_ui`) submodule. Second,
the suite ships around **50 submodules**; none are covered here beyond noting they
exist — enable only the integrations you actually need.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and note the submodules (including the UI submodule for adding mappings).
2. [Configuration](configuration/index.md) — the admin area, the mapping config
   entities, the global settings, and creating a mapping (Drush and UI).

## Where it lives in the admin menu

The admin landing page is at **Configuration → Schema.org**
(`/admin/config/schemadotorg`), with sub-pages for mappings, mapping types, and the
settings tabs. Everything is gated by the single **Administer Schema.org**
(`administer schemadotorg`) permission.

## How to use it (in brief)

1. Enable the base module (and `schemadotorg_ui` if you want a UI to add mappings).
2. Decide which Drupal entity type + bundle should represent which Schema.org type.
3. Create the mapping — with the UI submodule, or with Drush:
   ```bash
   drush schemadotorg:create-type node:Person node:Organization node:Event
   ```
   The module creates each bundle (if needed) and its fields from the type's
   properties.
4. Review the generated content type and fields, then tune the global settings
   (default types, ignored properties, naming rules) as needed.

See [Configuration](configuration/index.md) for detail.
