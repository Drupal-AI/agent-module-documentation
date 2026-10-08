# Migration Tools — manual setup guide

**Migration Tools** (`migration_tools`) is a developer toolkit that layers helper
classes, extra migrate plugins, an HTML data parser, and event subscribers on top of
Migrate and [Migrate Plus](https://www.drupal.org/project/migrate_plus) to make hard
content migrations — especially **scraping legacy HTML** — more reliable. As the
project itself puts it, the module "does nothing by itself": it ships reusable
building blocks you call from your own migration configs and custom code.

What it gives you:

- **Extra migrate process plugins** — `convert_boolean`, `skip_on_substr`,
  `skip_on_not_empty`, `gate_comparator`, and `create_default_paragraph_revision`.
- **A `dom` data parser** (Migrate Plus) that walks messy HTML pages with QueryPath,
  and a **`url_list`** source plugin that reads a newline‑delimited list of URLs.
- **The "Obtainer" framework** — classes like `ObtainTitle`, `ObtainDate`,
  `ObtainBody`, `ObtainImage`, `ObtainLink`, and `ObtainTable` that extract specific
  fields out of inconsistent markup, run in priority order per field.
- **Static helper classes** (`CheckFor`, `StringTools`, `Url`, `Media`, `Redirects`,
  `Operations`, `Message`) for row checks, string cleanup, URL/redirect handling, and
  copying unmanaged files.
- **Automatic redirect creation** — event subscribers hook Migrate Plus's prepare‑row
  and post‑row‑save events to create URL redirects as content is imported (which is
  why the Redirect module is required).

It also bundles a `migration_tools_example` submodule with runnable example migrations
to learn from. The Obtainers need the QueryPath library.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate Plus and Redirect.
2. [Configuration](configuration/index.md) — the admin debug‑logging settings form.

## How to use it

The bulk of this module is a **developer toolkit**, so most of the "how to use it"
lives in code and migration YAML rather than an admin screen. Reference its process
plugins in your migration's `process` pipeline, use the `dom` parser and `url_list`
source in your `source`, and call or subclass the Obtainer and helper classes from
your custom migration code. The fastest way in is to enable the
`migration_tools_example` submodule and copy its example migrations.

The one admin screen the module provides — at **Content → Migrate → Migration Tools**
(`/admin/content/migrate/migration_tools`) — only tunes **debug/log verbosity** during
migration runs; it doesn't change what a migration does. See
[Configuration](configuration/index.md).

For the plugin reference, helper library, and how to write your own Obtainer, see the
sibling agent docs:
[`plugins/migrate.md`](../agent/plugins/migrate.md),
[`api/helpers.md`](../agent/api/helpers.md), and
[`extend/obtainers.md`](../agent/extend/obtainers.md).
