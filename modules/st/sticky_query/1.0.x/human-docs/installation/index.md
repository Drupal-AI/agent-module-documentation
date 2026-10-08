# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **DOM Processor** module (`domprocessor`), which does the actual link
  rewriting. Composer pulls it in automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/sticky_query -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and install
`domprocessor` and any other shared dependencies alongside Sticky Query.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky_query -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sticky_query -y
```

Enabling Sticky Query will also enable `domprocessor` if it is not already on.

## Verify it worked

Confirm both modules are enabled:

```bash
drush pm:list --status=enabled | grep -E 'sticky_query|domprocessor'
```

From here the work is done in code — use the module's API to declare which query
parameters should persist across links.
