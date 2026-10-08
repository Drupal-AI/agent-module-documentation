# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Drush** — required, since anonymization is run through a Drush command.
- No additional modules or third‑party PHP libraries are required; all functionality
  relies on Drupal core APIs.

This is the 1.0.1 release, covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/configurable_anonymizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/configurable_anonymizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en configurable_anonymizer -y
```

## Verify it worked

Go to **Configuration → Development → Anonymizer**
(`/admin/config/development/anonymizer`) and confirm the configuration form loads.
Then follow [Configuration](../configuration/index.md) to map your PII fields to
anonymizer plugins.

> **Important:** Do not run the anonymization command on production — it overwrites
> real data. Only run it on a copied database, and run it before anyone uses that
> copy. See [Configuration](../configuration/index.md) for the safe workflow.
