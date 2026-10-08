# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or later**.
- The **`dragonmantank/cron-expression`** library, which parses the crontab
  expressions used to schedule jobs. Composer installs it automatically with the
  command below.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_cron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including `dragonmantank/cron-expression` — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_cron -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_cron -y
```

## Enable the examples (optional)

The project ships a **Simple Cron Examples** submodule with sample plugins that
show how to declare jobs. Enable it while you are learning, then disable it on
production:

```bash
drush en simple_cron_examples -y
```

## After enabling

1. Under **People → Permissions**, assign the module's permissions to the right
   roles: **Administer simple cron**, **View simple cron jobs**, and **Run simple
   cron jobs**. Keep "run" limited to trusted operators.
2. Declare your own cron jobs as `@SimpleCron` plugins (see the main guide), or
   study the examples submodule first.

## Verify it worked

With the examples submodule enabled, the sample jobs should appear in the module's
job management UI and be listable via Drush (`drush` cron commands provided by the
module). You can then enable, schedule, and run a job to confirm the framework is
working.
