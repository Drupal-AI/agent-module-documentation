# Installation

> **Development only.** Developer console executes arbitrary PHP and database
> queries. Enable it on development environments for trusted developers, and never
> on production.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies, and no third-party PHP libraries. (Kint, used for
  output, ships with the module's integration.)

This project is **not** covered by Drupal's security advisory policy, and it is
minimally maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/developer_console -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/developer_console -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en developer_console -y
```

## Grant the permission

Under **People → Permissions**, grant the module's permission to trusted developer
roles only. Because the console can run arbitrary code, treat this permission as
equivalent to full site access.

## Verify it worked

Log in as a permitted developer and open the console. Enter a simple expression and
run it — you should see the result rendered via Kint, along with execution-time
information.
