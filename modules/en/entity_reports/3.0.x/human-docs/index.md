# Entity Reports — manual setup guide

**Entity Reports** (`entity_reports`) documents your site's own content model. For
every fieldable entity type — nodes, taxonomy terms, files, media, paragraphs,
users, menus and more — it lists the bundles, their fields, each field's type and
key settings (machine name, description, required flag, cardinality, translatable
flag, referenced entity type), and presents it all in one place under
**Reports**. It can also export the whole picture as **JSON, XML or CSV** for
processing outside Drupal.

The problem it solves is the tedium of answering "what does this site's data model
actually look like?" Normally that means clicking through Field UI bundle by
bundle or writing a throwaway script. Entity Reports answers it on a single set of
report pages — handy for handing a data model to a new developer, documenting a
client site, auditing which bundles use a given field, comparing environments, or
feeding a migration plan with real field data.

The reports appear automatically once the module is enabled — one page per
fieldable entity type, plus the export links. An optional **settings form** lets
you limit which entity types are reported, and an **entity_reports_csv** submodule
adds CSV as an export format (export formats are extensible via an event, and this
submodule is the reference example). It depends on core's **Field**, **Node** and
**Taxonomy** modules.

One access point worth understanding: the module's **view entity reports**
permission is not flagged as a restricted/administrative permission, yet the
reports enumerate every bundle, field and field setting on the site — exactly the
kind of structural detail an attacker would find useful for reconnaissance. Treat
**view entity reports** as more sensitive than its name suggests and grant it only
to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the CSV export submodule.
2. [Configuration](configuration/index.md) — the settings form for limiting which
   entity types are reported, and the permissions to grant.

## Where it lives in the admin menu

The reports live under **Reports** — each fieldable entity type has its own page at
`/admin/reports/entity/{entity_type}` (for example
`/admin/reports/entity/node`), with export links for JSON, XML and CSV. The
settings form is at **Configuration → Development → Entity reports**
(`/admin/config/development/entity-reports`).
