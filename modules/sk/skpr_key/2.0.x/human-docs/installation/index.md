# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Key** module (`key`) enabled — Skpr Key is a provider *for* Key, so it is
  a hard dependency.
- A site hosted on the **Skpr** platform, with the `skpr/php-config` configuration
  available. Outside that platform there is no secret store for the provider to
  read from.

There are no additional PHP or third-party library requirements beyond what the
module pulls in.

## Install with Composer

From the project root:

```bash
composer require drupal/skpr_key -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/skpr_key -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en skpr_key -y
```

Drupal enables the Key module automatically as a dependency if it is not already
on.

## Verify it worked

Go to **Configuration → System → Keys** and add a key. When you reach the **Key
provider** setting, confirm that **Skpr** appears as an option. Configure it with
a Skpr config key and check that the key resolves to the expected secret value.
