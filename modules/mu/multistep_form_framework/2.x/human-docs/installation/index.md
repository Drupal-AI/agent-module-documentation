# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No contributed‑module dependencies and no third‑party libraries — it builds on
  core's Form API.
- Comfort writing PHP and YAML: this is a developer framework with no admin UI.

## Install with Composer

From the project root:

```bash
composer require drupal/multistep_form_framework -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multistep_form_framework -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multistep_form_framework -y
```

## Examples submodule

To install a complete, working reference wizard you can study and copy, enable
the bundled examples submodule:

```bash
drush en multistep_form_framework_examples -y
```

It requires the base module, which is already present once you have installed it
above. Consider it a learning aid rather than something to leave enabled on a
production site.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`) or with
`drush pml --filter=multistep_form_framework`. Because there is no UI, the real
proof is in code: build (or enable the examples submodule's) wizard, then load its
form route and step through it to confirm the framework advances between steps.
