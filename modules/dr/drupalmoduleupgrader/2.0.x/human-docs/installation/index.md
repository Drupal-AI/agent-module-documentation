# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush**, since the module is driven entirely from the command line.
- Your site's `composer.json` must have its **`minimum-stability` set to
  `dev`**. This release is an alpha (`2.0.0-alpha2`), and Composer will refuse to
  install it under the default `stable` minimum-stability.

There are no other module dependencies to install by hand. The dependency block
in the module's `info.yml` is deliberately commented out — those entries are for
the module's own test suite and refer to the *Drupal 7* versions of other
modules, which underlines what this tool is: something that reads Drupal 7 code
while running on a modern Drupal site.

## Install with Composer

First, if you have not already, relax minimum-stability in your project's
`composer.json`:

```json
{
    "minimum-stability": "dev",
    "prefer-stable": true
}
```

Then require the module from the project root:

```bash
composer require drupal/drupalmoduleupgrader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalmoduleupgrader -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalmoduleupgrader -y
```

## Verify it worked

Place a Drupal 7 module you want to port into your site's `modules/` directory,
then run `drush dmu-analyze MODULE_NAME` from the Drupal root. If DMU prints an
analysis report of the module's code, the tool is installed and working. See the
[main guide](../index.md) for the full command workflow.
