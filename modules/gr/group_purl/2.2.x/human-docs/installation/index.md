# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`).
- The **[PURL](https://www.drupal.org/project/purl)** module (`purl`), which
  provides the Persistent URL framework this module plugs into.

Both Group and PURL are enabled automatically as dependencies when you enable
group_purl. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_purl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group and PURL and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_purl -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_purl -y
```

This enables `group`, `purl`, and `group_purl` together if they aren't already on.

## Verify it worked

After enabling, go to the PURL module's configuration and create a modifier for
groups (a prefix or domain method). Then visit a group under its configured URL
and confirm that browsing, adding content, and any group‑aware Views operate in
that group's context.
