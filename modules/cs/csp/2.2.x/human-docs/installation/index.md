# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement:
  ^10.2 || ^11`).

There are no other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/csp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csp -y
```

Both policies ship with sensible defaults, so a policy is emitted straight away.
Review and tune it on the settings form — see
[Configuration](../configuration/index.md).

## Submodule — CSP Extras

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **CSP Extras** | `csp_extras` | Optional additional CSP functionality that builds on the base module. Enable it only if you need what it provides. |

```bash
drush en csp_extras -y
```
