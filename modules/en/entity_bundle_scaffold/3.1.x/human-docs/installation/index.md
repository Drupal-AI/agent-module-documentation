# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10.0 || ^11.0`).
- **PHP 7.4** or newer.
- **Drush** — this is a Drush-driven tool.
- Some commands need companion modules to be present: `paragraphs:type:create`
  needs [Paragraphs](https://www.drupal.org/project/paragraphs); the `eck:*`
  commands need [ECK](https://www.drupal.org/project/eck); `wmcontroller:generate`
  needs the `wmcontroller` module.
- The `nikic/php-parser` library powers code generation and is pulled in
  automatically by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_bundle_scaffold -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including `nikic/php-parser`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_bundle_scaffold -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_bundle_scaffold -y
```

## The Drush commands

Run any command with `-h` (or `--help`) to see its full arguments, options, and
aliases.

**Structure creation**

| Command | Alias | What it does |
|---------|-------|--------------|
| `nodetype:create` | `ntc` | Create a node type. |
| `vocabulary:create` | `vc` | Create a taxonomy vocabulary. |
| `paragraphs:type:create` | `ptc` | Create a Paragraphs type (needs Paragraphs). |
| `eck:type:create` | `etc` | Create an ECK entity type (needs ECK). |
| `eck:bundle:create` | `ebc` | Create an ECK bundle (needs ECK). |
| `eck:bundle:delete` | `ebd` | Delete an ECK bundle (needs ECK). |

**Code generation**

| Command | Alias | What it does |
|---------|-------|--------------|
| `entity:bundle-class-generate` | `ebcg` | Generate an entity bundle class with typed field getters. |
| `wmcontroller:generate` | `wmcg` | Generate a `wmcontroller` controller with a `show` method (needs wmcontroller). |

## Configure generation behavior

Before generating code, tune the `entity_bundle_scaffold.settings` configuration to
suit your project — the output module, namespace pattern, base classes, and the
`auto_create` / `auto_update` toggles. See the "How it is configured" section of the
[overview](../index.md) for the full list of keys.

## Verify it worked

Run `drush list --filter=entity` (or any of the commands above with `-h`) and
confirm the scaffold commands, such as `entity:bundle-class-generate`, appear and
show their help text.
