# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The contributed **SMTP** module (`smtp`) — this module replaces SMTP's mail
  backend, so SMTP must be installed and enabled. Composer pulls it in as a
  dependency.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/smtp_multiple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required SMTP module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smtp_multiple -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smtp_multiple -y
```

Enabling `smtp_multiple` also enables `smtp` if it isn't already on.

## Next step

There is no admin form. Add your per‑key SMTP configurations in
`settings.php` / `settings.local.php` (or via `hook_smtp_multiple_config_alter()`)
as described on the [main guide](../index.md). Keep the credentials in an
uncommitted `settings.local.php` or in environment variables.
