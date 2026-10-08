# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** (`migrate`) module and the contrib **Migrate Plus**
  (`migrate_plus`) module — both are dependencies. Composer/Drupal install and
  enable them for you.
- **At least one migration defined somewhere** for Migrate Cron to schedule — it
  runs migrations, it does not define them.
- A working **cron** setup — the actual run frequency is bounded by how often
  Drupal cron fires.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_cron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Migrate Plus and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_cron -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_cron -y
```

Then go to **Configuration → System → Migrate Cron**
(`/admin/config/system/migrate-cron`) to choose which migrations run on cron and how
often — see [Configuration](../configuration/index.md).
