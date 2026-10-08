# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** (`field`) module, which Drupal enables automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fieldcompose -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fieldcompose -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fieldcompose -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**. The
**Field Compose** field type should appear in the list. Add it, define a couple of
sub-fields in YAML in the field settings, and confirm the composed inputs appear on
the entity's edit form.
