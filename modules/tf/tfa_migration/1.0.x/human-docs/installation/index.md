# Installation

## Requirements

TFA Migration needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **TFA (Two-Factor Authentication)** module (`drupal:tfa`) — the destination
  for the migrated settings and seeds.
- Core's **Migrate** module (`drupal:migrate`) — the migration framework it runs
  on.
- The **Encrypt** module (`drupal:encrypt`) — used to keep the migrated secrets
  encrypted at rest.

There are no third-party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tfa_migration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including TFA and Encrypt if they are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tfa_migration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tfa_migration -y
```

Drupal will enable the required dependencies (TFA, Migrate, Encrypt) at the same
time.

## Next step

Once enabled, go on to [Configuration](../configuration/index.md) to supply your
Drupal 7 private key — the migration needs it to decrypt and carry across the TFA
secrets.
