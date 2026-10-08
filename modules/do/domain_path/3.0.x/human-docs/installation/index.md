# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Path** module (`path`) — enabled automatically as a dependency.
- The **Domain** module (`drupal/domain` ^3.0.0‑beta8), and at least one Domain
  entity configured. Domain Path is meaningless without it, and Composer pulls it
  in for you.
- Optional: **Pathauto** (`drupal/pathauto`) if you want the automatic per‑domain
  alias generation offered by the Domain Path Pathauto submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Domain module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_path -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_path -y
```

Make sure the Domain module is set up first (with your domains created), then visit
[Configuration](../configuration/index.md) to choose which entity types get
per‑domain aliases.

## Submodule — Domain Path Pathauto

The package ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Domain Path Pathauto** | `domain_path_pathauto` | Automatic generation of per‑domain aliases using Pathauto patterns, so you don't have to type each domain's alias by hand. Requires the Pathauto module. |

Enable it only if you use Pathauto:

```bash
drush en domain_path_pathauto -y
```
