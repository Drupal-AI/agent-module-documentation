# Migrate Plus — manual setup guide

**Migrate Plus** (`migrate_plus`) extends Drupal's core **Migrate API** with the
pieces most real‑world migrations need but core leaves out: migrations defined
as **configuration** (YAML you can export and deploy), **migration groups** for
sharing settings across related migrations, a pluggable **`url` source** for
pulling data from remote JSON/XML/SOAP/CSV endpoints, and a large library of
extra **process plugins**. It is a near‑universal dependency of custom
migration projects.

Where core Migrate only supports migrations derived from plugin classes,
Migrate Plus adds `migration` and `migration_group` **config entities**, so a
migration can live as YAML configuration rather than PHP — created, exported,
and moved between environments like any other config. Groups let many
migrations share common source/destination settings and run together as a set.
Its headline feature is the `url` source plugin, built from three pluggable
layers you mix and match: **data fetchers** (`http`, `file`), **data parsers**
(`json`, `xml`, `simple_xml`, `soap`), and **authentication** plugins (`basic`,
`digest`, `ntlm`, `oauth2`). On top of that it ships dozens of extra process
plugins — DOM manipulation, `entity_lookup`, `entity_generate`, string and
array helpers, `skip_on_value`, and more — plus a `table` source and
destination for arbitrary database tables.

Migrate Plus has **no admin UI and no Drush commands of its own** — it is a
toolkit you use by writing migration configuration and, where needed, custom
code. It depends only on core's **Migrate** module. To actually run and manage
migrations from the command line, most sites also install the companion
**Migrate Tools** module (`drupal/migrate_tools`), which provides the
`drush migrate:*` commands.

Two optional PHP extras unlock specific features: the
`sainsburys/guzzle-oauth2-plugin` library (3.0) is required for the **OAuth2**
authentication plugin, and PHP's **SOAP** extension (`ext-soap`) is required for
the SOAP data parser.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — the source plugins, process
plugins, and events — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional OAuth2/SOAP requirements and example
   submodules.

## How to use it

There is **no settings page** (`configure` is `null`); you work with Migrate
Plus by writing migration configuration and running it:

1. **Define your migrations.** Create `migration` and (optionally)
   `migration_group` config entities as YAML — either as `config/install` files
   in a custom module or imported directly into a site's configuration. A group
   holds shared settings (source constants, tags, shared plugin config) that its
   member migrations inherit.
2. **Pull remote data with the `url` source.** Point the `url` source at your
   endpoint and choose a data fetcher (`http` or `file`), a data parser (`json`,
   `xml`, `simple_xml`, `soap`), and, for protected APIs, an authentication
   plugin (`basic`, `digest`, `ntlm`, `oauth2`).
3. **Transform values with process plugins.** Use the extra process plugins
   (`dom`, `entity_lookup`, `entity_generate`, `skip_on_value`, `str_replace`,
   the array helpers, and so on) in each field's process pipeline.
4. **Run the migrations.** Install **Migrate Tools** and use its Drush commands
   (`drush migrate:status`, `drush migrate:import`, `drush migrate:rollback`) to
   execute and manage them.

To learn the API by example, enable the shipped example submodules (see
[Installation](installation/index.md)) and read their migration YAML.
