# Installation

## Requirements

Field Group is light on requirements. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it
  is already on for any standard Drupal install, since it is what provides fields
  in the first place.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_group -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group -y
```

Enabling the module does not change anything visible on its own — it simply adds
the **Add group** action to the **Manage form display** and **Manage display**
tabs of your entities. Head to [Configuration](../configuration/index.md) to
create your first group.

## Optional submodule

Field Group ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Field Group Accordion** | `field_group_accordion` | Adds a jQuery‑UI accordion format (an "Accordion" container and "Accordion item" groups). **Deprecated** — prefer the built‑in Details/Tabs formats on new sites. |

Enable it only if you specifically want the accordion format:

```bash
drush en field_group_accordion -y
```
