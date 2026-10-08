# Installation

## Requirements

- **Drupal 11.3+ or 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **User** module (`user`) — always present. This is the only dependency.

There are no third‑party Composer packages.

## Install with Composer

From the project root:

```bash
composer require drupal/genpass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/genpass -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en genpass -y
```

Once enabled, Genpass's options appear on the core **Account settings** form
(`/admin/config/people/accounts`). See [Configuration](../configuration/index.md)
for what to set.

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Genpass Batch** | `genpass_batch` | Test/support helper that runs Genpass password generation as a batch on user insert. |

Enable it with:

```bash
drush en genpass_batch -y
```

It requires the base Genpass module, which is already present once you have
installed it above.
