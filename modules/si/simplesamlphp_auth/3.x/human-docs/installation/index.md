# Installation

## Requirements

- **Drupal 10 or 11.3+** (`core_version_requirement: ^10 || ^11.3`).
- Core's **User** module (`user`).
- The contributed **External Authentication** module (`externalauth`), which Composer
  installs as a dependency.
- **A working simpleSAMLphp service provider (SP).** This is the essential
  prerequisite: you must have simpleSAMLphp (version 1.6 or newer) installed and
  configured to operate as a service provider *before* the Drupal side is useful.
- Your simpleSAMLphp SP must use a session store **other than** the default
  `phpsession` — use `memcache` or `sql`. The simplest fix is to edit simpleSAMLphp's
  `config/config.php` to set `store.type => 'sql'` with a suitable `store.sql.dsn`
  (for example a SQLite database).

> **Version compatibility matters here.** This 3.x (`8.x-3.x`) branch requires
> simpleSAMLphp 1.x and is tied to older Symfony versions — it is *not* Drupal 10
> compatible in the way the newer 4.x branch is. For Drupal 10/11 with simpleSAMLphp
> 2.x, use the 4.x branch of this module instead. Check the module's release notes for
> the exact combination that fits your core and simpleSAMLphp versions.

## Install with Composer

From the project root:

```bash
composer require drupal/simplesamlphp_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this module's dependency chain is specific, so let Composer
resolve it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplesamlphp_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplesamlphp_auth -y
```

## Order of operations

The recommended sequence is: install and configure simpleSAMLphp as a service
provider first, then install and enable this module, configure it (see
[Configuration](../configuration/index.md)), and only then turn on its **activate**
switch. Nothing takes effect on the Drupal side until activate is enabled.
