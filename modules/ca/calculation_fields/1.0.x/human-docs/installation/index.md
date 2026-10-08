# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third-party Composer libraries and no required module dependencies.
- To use the Webform integration submodules, you will also need the
  [Webform](https://www.drupal.org/project/webform) module installed.

## Install with Composer

From the project root:

```bash
composer require drupal/calculation_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calculation_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calculation_fields -y
```

## Submodules — enable only what you need

Calculation Fields ships several optional submodules. Enable them individually
with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Example** | `calculation_fields_example` | A worked example of the calculation element so you can see it in action. |
| **Webform Calculation Fields** | `webform_calculation_fields` | Integration that lets you add a calculated element to a Webform. Requires the Webform module. |
| **Webform examples** | `webform_calculation_fields_examples` | Example webforms demonstrating the Webform integration. |

For example, to add the Webform integration:

```bash
drush en webform_calculation_fields -y
```

## Grant the permission

The module provides a restricted `administer calculation_fields configuration`
permission. Grant it only to trusted roles under **People → Permissions**
(`/admin/people/permissions`) — it controls stored expressions, which are
effectively stored logic.
