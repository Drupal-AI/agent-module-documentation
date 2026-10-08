# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Serialization** module (`serialization`) — enabled as a dependency.
- To describe **JSON:API** representations (`_describes=api_json`), core's **JSON:API**
  module must also be enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/schemata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemata -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module (and its provider submodule)

The base module only builds abstract schema objects — it needs a **provider submodule**
to serialize them into a concrete format. The bundled provider is **Schemata JSON
Schema** (`schemata_json_schema`), which produces JSON Schema v4. Enable both:

```bash
drush en schemata schemata_json_schema -y
```

Enabling `schemata_json_schema` pulls in the base `schemata` module automatically, so
`drush en schemata_json_schema -y` alone also works.

## Grant the permission

Reading schemas is gated by a single permission, **Access schemata data models**. At
**People → Permissions**, grant it to any role that needs to read your entity schemas.

## Next steps

There is no configuration screen. Request a schema at
`/schemata/{entity_type}/{bundle?}` (with the `_format` and `_describes` query args) or
build one in code — see **How to use it** on the [overview page](../index.md) and the
[`agent/`](../agent/start.md) docs for the full API.
