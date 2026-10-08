# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and it is part of core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contextual_range_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contextual_range_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contextual_range_filter -y
```

Make sure core's Views module is enabled (it usually is by default).

## Permissions

- **Administer contextual range filters** (`administer contextual range filters`) —
  required to reach the conversion page where you turn normal contextual filters into
  range filters. Grant it to site builders.
- **Use PHP code for contextual range filter defaults** — a separate, security‑sensitive
  permission that controls who can use the PHP‑code argument default (which runs a PHP
  snippet to compute a default range). Grant it only to fully trusted users, since it
  allows running arbitrary PHP.

Set these under **People → Permissions**.

## Verify it worked

Go to **Configuration → Content authoring → Contextual range filter**
(`/admin/config/content/contextual-range-filter`). If the conversion page loads and
lists your Views' contextual filters, the module is active. See the
[main page](../index.md#how-to-use-it) for how to convert a filter and use the range
URL syntax. There is no separate configuration page.
