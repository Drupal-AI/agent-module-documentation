# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No additional contrib modules or PHP libraries.

> **Note:** this project is not covered by Drupal's security advisory policy at
> this version. Review it before relying on it for a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/gradient -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gradient -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gradient -y
```

## Verify it worked

There is no settings page to check. Confirm the module is enabled (for example
with `drush pm:list --status=enabled | grep gradient`), then use the gradient form
element in a form or theming context and confirm it produces a valid
`linear-gradient(...)` CSS value.
