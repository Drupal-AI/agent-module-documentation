# Installation

## Requirements

- **Drupal 8.8+, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`).
- The contrib **Token** (`token`) and **Token Filter** (`token_filter`) modules — Block Token
  supplies the block tokens, and Token Filter does the actual in‑text replacement. Composer pulls
  them in automatically.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token and Token Filter
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_token -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en block_token -y
```

Enabling `block_token` will also enable Token and Token Filter as dependencies if they aren't on
yet.

> **Note the route access.** Enabling this module sets a custom access check on the block edit
> form and the block layout listing — see [Configuration](../configuration/index.md#permissions)
> for who can reach them before granting the module's permission.

## Next step

Head to [Configuration](../configuration/index.md) to enable the filter, flag a block, and embed
it in content.
