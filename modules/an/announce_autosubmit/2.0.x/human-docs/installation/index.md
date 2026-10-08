# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/announce_autosubmit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/announce_autosubmit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en announce_autosubmit -y
```

That's all it takes. The accessible announcement and focus handling apply to
auto-submitting forms immediately — there is no configuration. See
[How to use it](../index.md#how-to-use-it) in the overview for where it helps most.
