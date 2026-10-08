# Installation

## Requirements

AI Migrate depends on the AI framework and the Migrate Plus toolkit:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — enabled and configured with a working AI provider,
  since that is what performs each transformation.
- The **Migrate Plus** module (`migrate_plus`) — which in turn builds on core's
  Migrate module.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the AI module and Migrate Plus.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_migrate -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_migrate -y
```

Drupal enables `ai` and `migrate_plus` (and core Migrate) as dependencies if they
are not already on.

## After enabling

1. Confirm the **AI** module has a provider configured with a working API key
   (stored as a secret via the Key module, per this project's conventions).
2. There is no settings page for AI Migrate — you use it by referencing its
   process plugin from your migration definitions. Remember that each row that
   hits the plugin sends source data to the AI provider, so validate that the
   egress is acceptable before running a large migration.
