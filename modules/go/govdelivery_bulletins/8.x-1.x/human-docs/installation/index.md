# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- A **GovDelivery (Granicus) account** with API access — you will need your
  account code, an API endpoint, and a username and password for the API.
- No additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/govdelivery_bulletins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govdelivery_bulletins -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en govdelivery_bulletins -y
```

## Verify it worked

After enabling, go to the module's admin form and confirm you can see the
GovDelivery connection settings and the "Basic operations" section. **Leave the
two send switches off** until you have entered valid credentials and are ready to
test — see [Configuration](../configuration/index.md). A safe first test is to
queue a bulletin with the `test` flag and an explicit test recipient address (as
shown in the guide's index), rather than sending to a live subscriber list.
