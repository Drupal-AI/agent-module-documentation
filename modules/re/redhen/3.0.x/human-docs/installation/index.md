# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- This is release **3.0.0-alpha1**, an **alpha**. It is suitable for building and
  evaluating, but weigh that status before using it for production data.

There are no third‑party Composer or PHP library requirements for the base
module.

## Install with Composer

From the project root:

```bash
composer require drupal/redhen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one package contains the base module and all of the
submodules; you choose which submodules to enable below.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redhen -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en redhen -y
```

On its own, the base module provides shared APIs but little you can see. Enable
the submodules that match what you are building.

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Contact** | `redhen_contact` | Creates **contact** entities and lets you connect them to Drupal user accounts, so a logged-in contact can update their own details and have that flow back into the CRM. This is the usual starting point. |
| **Organization** | `redhen_org` | Creates **organisation** entities — the companies, associations, or bodies your contacts belong to. |
| **Connection** | `redhen_connection` | Creates fieldable **connections** between two CRM objects and supports Connection Roles that can grant access to other entities based on those relationships. |
| **Dedupe** | `redhen_dedupe` | Provides a find-and-merge interface for locating duplicate contacts (by a selectable subset of fields) and merging them with fine-grained control. |

For example, to start with contacts and organisations:

```bash
drush en redhen_contact redhen_org -y
```

Each submodule requires the base RedHen module, which is already present once you
have installed the package above.

## Verify it worked

Log in as an administrator and confirm the RedHen settings form at `redhen.config`
loads. If you enabled `redhen_contact`, check that you can create a contact type
and add a contact. From there, move on to [Configuration](../configuration/index.md)
to set up your types, fields, and — importantly — access.
