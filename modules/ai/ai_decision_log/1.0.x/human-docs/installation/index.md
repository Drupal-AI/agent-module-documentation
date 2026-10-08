# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.3 or newer** (`php_requirement: ^8.3`).
- Core's **System** (`system`) and **User** (`user`) modules — always present on a
  Drupal site.

That's all. Unlike most modules in the AI family, AI Decision Log needs **no AI
provider, no API key, and no paid service** — it is a standalone decision store.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_decision_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_decision_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_decision_log -y
```

After enabling, grant the module's permissions at **People → Permissions** — see
[Configuration](../configuration/index.md) for what each one controls — and confirm
you have PHP 8.3+ on the environment before deploying.
