<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- Drupal core's **Datetime** module (`datetime`), used for token expiry. It is part
  of core and enabled automatically as a dependency.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/api_token_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_token_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_token_entity -y
```

Enabling `api_token_entity` also enables core's Datetime module if it is not
already on.

## Next steps

Grant the **`administer api_token_entity entities`** permission (**People →
Permissions**) to trusted administrator roles only — this permission controls who
can create and revoke API credentials. Then create your token types and tokens as
described in the [main guide](../index.md), remembering to set expiry dates and to
treat every token value as a secret.
