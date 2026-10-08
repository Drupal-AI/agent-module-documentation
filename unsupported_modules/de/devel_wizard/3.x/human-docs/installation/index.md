# Installation

> **Development only.** Devel Wizard can execute shell processes (`composer`/`drush`)
> by design and its whole surface is developer-facing. Enable it on development
> environments for trusted roles, and never on production.

## Requirements

- **Drupal 11** (`core_version_requirement: ^11.0`).
- Core's **Config** module (`config`), which Drupal enables automatically as a
  dependency.
- **Composer** and **Drush** available on the environment (some spells invoke them).

There are no third-party PHP library requirements. This project is **not** covered
by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/devel_wizard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/devel_wizard -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en devel_wizard -y
```

## Grant the permissions

Both permissions are restricted — grant them only to trusted developer roles, under
**People → Permissions**:

- **`devel_wizard.spell`** — use the spell overview, spell forms and autocomplete
  endpoints.
- **`devel_wizard.settings.admin`** — access the module's settings page.

## Verify it worked

Log in as a user with the `devel_wizard.spell` permission and open
`/admin/devel-wizard-spell`. You should see the list of available spells. See the
[main guide](../index.md) for how to run one.
