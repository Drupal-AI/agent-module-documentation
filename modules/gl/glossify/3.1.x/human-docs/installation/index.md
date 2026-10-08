# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`), which Drupal enables automatically as a
  dependency (text-format filters are the whole point of this module).
- For the **Glossify Commerce** submodule only: **Drupal Commerce**
  (`drupal/commerce`).

There are no third-party Composer or PHP library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/glossify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/glossify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the base module and a submodule

The base module is an API layer — on its own it does nothing visible. Enable it
**together with** the submodule that matches where your glossary terms come from:

| Submodule | Machine name | Term source |
|-----------|--------------|-------------|
| **Glossify Node** | `glossify_node` | Node titles |
| **Glossify Taxonomy** | `glossify_taxonomy` | Taxonomy terms |
| **Glossify Commerce** | `glossify_commerce` | Commerce products (needs Drupal Commerce) |

For example, to auto-link taxonomy terms:

```bash
drush en glossify glossify_taxonomy -y
```

Each submodule requires the base Glossify module, which is installed above.

## Next step

Enabling the module doesn't change any output yet — you need to add the submodule's
filter to a text format. See [How to use it](../index.md#how-to-use-it).
