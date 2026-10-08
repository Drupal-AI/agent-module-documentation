# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`).
- **PHP 8.1** or newer.
- Single Directory Components to preview (from your themes and/or modules).
- No dependent contrib modules and no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/sdc_showcase -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdc_showcase -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdc_showcase -y
```

Once enabled, every discovered component immediately has a preview page — there are
no stories to write.

## Grant access

Give your QA and reviewer roles the **`access sdc showcase`** permission (under
**People → Permissions**), and keep **`administer sdc showcase`** for administrators
who manage the settings. See [Configuration](../configuration/index.md) for the
access modes.

## Verify it worked

Visit `/sdc-showcase`. You should see a browsable list of the site's Single
Directory Components, each with a detail page of rendered variations. To list every
showcase URL from the command line (handy for CI), use the module's Drush command:

```bash
drush ssc:urls --include-variations
```
