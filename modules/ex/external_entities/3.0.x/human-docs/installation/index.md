# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A reachable **data source** you want to expose (a REST API, a SQL database, etc.)
  and any credentials it requires.

The base module has no additional Composer or PHP library requirements. Individual
storage-client submodules (for example a SQL source) may have their own needs.

> **Version note:** this is a release candidate (`3.0.0-rc2`). Test before relying
> on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/external_entities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_entities -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_entities -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Views support** | `xntt_views` | Native Views integration, so external entities can be listed and filtered in Views. |
| **SQL storage** | `xnttsql` | A storage client that reads from a SQL database source. |
| **File field support** | `xntt_file_field` | File and Image field support for external entities. |
| **Pathauto** | `external_entities_pathauto` | Automatic path aliases for external entities. |
| **Drupal.org example** | `external_entities_drupalorg` | A ready-made example type backed by the Drupal.org API. |
| **D7 import example** | `xntt_example_d7import` | A worked example of importing Drupal 7 content as external entities. |

For example, to add Views support:

```bash
drush en xntt_views -y
```

## Storing source credentials safely

If your data source requires an API key, token, or password, **do not hard-code it
or commit it**. Store it as an environment variable and reference it through the
**Key** module, or via DDEV's dotenv support. This keeps the secret out of exported
configuration.

## Verify it worked

Go to **Structure → External entity types** and confirm the listing loads and you
can start adding a type. For a quick end-to-end check without wiring up your own
API, enable the `external_entities_drupalorg` submodule and browse the example type
it provides.

Next, see [Configuration](../configuration/index.md) to define your own external
entity type and map its fields.
