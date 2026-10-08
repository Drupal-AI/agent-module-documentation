# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).

Voting API itself has no other module dependencies and no third-party Composer
libraries. The optional `votingapi_tokens` submodule additionally needs the
**Token** module (`drupal/token`).

## Install with Composer

From the project root:

```bash
composer require drupal/votingapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/votingapi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en votingapi -y
```

Enabling the module installs the default **Normal vote** vote type and the Views
data for votes and results.

## Submodule — optional

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Voting API Tokens** | `votingapi_tokens` | Exposes vote aggregates (count, average, and so on) as tokens you can use in labels, messages, or any token-aware field. Requires the **Token** module. |

Enable it only if you need those tokens:

```bash
composer require drupal/token -W   # if not already installed
drush en votingapi_tokens -y
```

Next, head to [Configuration](../configuration/index.md) to choose how results are
tallied and to set up any extra vote types.
