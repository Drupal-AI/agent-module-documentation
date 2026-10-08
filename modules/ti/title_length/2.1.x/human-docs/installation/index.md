# Installation

## Requirements

Title length needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

It has **no module dependencies** and needs no third‑party Composer libraries or
special PHP extensions.

## Install with Composer

From the project root:

```bash
composer require drupal/title_length -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/title_length -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module and its submodules

> **Important:** enabling the parent `title_length` module **alone changes
> nothing**. It only provides the machinery. You must also enable a submodule for
> the entity type whose titles you want to lengthen.

Title length ships two submodules:

| Submodule | Machine name | What it lengthens |
|-----------|--------------|-------------------|
| **Node title length** | `node_title_length` | Node titles |
| **Taxonomy term title length** | `taxonomy_term_title_length` | Taxonomy term names |

Enable only the ones you need. For example, to lengthen node titles:

```bash
drush en node_title_length -y
```

Enabling a submodule pulls in the parent automatically and, on install, widens the
relevant title column (and its revision column) to the default **500 characters**.

If you want a length other than 500, set it in `settings.php` **before** you enable
the submodule so the correct length is applied on the first install — see
[Configuration](../configuration/index.md).

## Verify it worked

Edit a piece of content (or a taxonomy term, if you enabled that submodule) and
enter a title longer than 255 characters. It should save without a length error.
