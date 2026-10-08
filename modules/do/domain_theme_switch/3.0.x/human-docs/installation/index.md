# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Domain** module (`domain`) and, importantly, the **Domain Configuration**
  sub-module (`domain_config`) — both are hard dependencies. Domain Configuration is
  where the per-domain theme overrides are actually stored, so the module will not
  work (and, in 3.x, database updates are blocked) without it.

Composer pulls in the Domain project automatically; enable `domain_config` along with
`domain`.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_theme_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_theme_switch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain domain_config domain_theme_switch -y
```

You can also enable them from **Extend** (`/admin/modules`). If **Domain
Configuration** is missing, `drush updatedb` will refuse to run with a message that
the module requires it.

## Install the themes you want to use

The per-domain selects only list **installed** themes, so install any theme you plan
to assign first — for example:

```bash
drush theme:enable olivero_brand_b -y
```

## What happens next

With the modules enabled and your themes installed, head to
[Configuration](../configuration/index.md) to assign a site and admin theme per domain.
If you are coming from the 2.x version, run `drush updatedb` — its update hooks migrate
your old per-domain settings into the new override format and remove an obsolete
permission.
