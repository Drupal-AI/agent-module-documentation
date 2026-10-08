# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- PHP's **JSON extension** (`ext-json`) — part of every standard PHP build.
- Core's **Field** (`field`), **Text** (`text`) and **Serialization**
  (`serialization`) modules — Drupal enables these as dependencies.

Database‑specific notes: the native JSON field types need a JSON‑capable database
(MySQL 5.7.8+, MariaDB 10.2.7+, PostgreSQL 9.2+, or SQLite 3.26+). The plain
**JSON (text)** type works everywhere. The optional collapsible‑tree rendering needs
the **jQuery JSONView** JavaScript library placed at `/libraries/jquery-jsonview/`;
without it the plain‑text formatter still works, just without the interactive tree.

Two Composer packages are *suggested* (not required): `drupal/diff` (to show JSON
differences between revisions) and `swaggest/json-schema` (for JSON‑schema
validation).

## Install with Composer

From the project root:

```bash
composer require drupal/json_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/json_field -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_field -y
```

## Optional: the JSON editor submodule

For a proper JSON editing experience (a real editor instead of a plain textarea),
also enable the bundled **JSON Field Widget** submodule, which adds a `json_editor`
widget you can select on a field's *Manage form display*:

```bash
drush en json_field_widget -y
```

## Verify it worked

Go to **Structure → Content types → [any type] → Manage fields → Add field**. Under
the **JSON data** category you should see *JSON (text)*, *JSON (raw)* and *JSONB /
JSON (raw)*. Add one, then save a piece of content with a valid JSON value to confirm
the field stores and validates it.

If the site is missing the jQuery JSONView library or is on a database version below
the JSON minimum, Drupal's **Status report** (*Reports → Status report*) will show a
warning from this module — that is expected and only affects the interactive tree
rendering / native field types.

For how to add and configure a JSON field, see the "How to use it" section of the
[overview](../index.md).
