# Installation

## Requirements

geoPHP is deliberately minimal. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other Drupal modules — it has no module dependencies.

The geoPHP PHP library itself ships **inside** the module (in its `geoPHP/` folder),
so there is no separate library download to manage. The **GEOS** PHP extension is
optional: it is not required, but if your server has it installed the module will use
it to speed up advanced spatial operations.

## Install with Composer

From the project root:

```bash
composer require drupal/geophp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/geophp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

In practice you rarely install geoPHP directly: when you `composer require` a module
that needs it (such as Geofield), Composer pulls geoPHP in automatically.

## Enable the module

```bash
drush en geophp -y
```

If another module declares geoPHP as a dependency, Drupal enables it for you when you
enable that module.

## Verify it worked

Visit **Reports → Status report** (`/admin/reports/status`). You should see an entry
reporting the installed geoPHP library version, and a note about whether the optional
GEOS extension is available. From there, custom code can use the `geophp.geophp`
service straight away — see [the overview](../index.md#how-to-use-it) for a quick
example.
