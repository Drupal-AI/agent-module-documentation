# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Options** module (`options`), enabled automatically as a dependency —
  it provides the option/list fields this widget is designed for.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/many_selects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/many_selects -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en many_selects -y
```

No configuration is required.

## Verify it worked

Go to a content type's **Manage form display** (**Structure → Content types →
*(your type)* → Manage form display**). For a multi-value option field, open the
widget dropdown — you should see **Many select list(s)** as a choice. Select it
and save, then check the field on a content edit form to confirm the new
one-dropdown-per-value experience. See the
[overview](../index.md#how-to-use-it) for the full walkthrough.
