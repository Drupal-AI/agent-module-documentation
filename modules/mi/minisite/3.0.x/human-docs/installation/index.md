# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`) — Drupal enables it automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/minisite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/minisite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en minisite -y
```

## Verify it worked

1. Grant the `manage minisites` permission under **People → Permissions** to a
   trusted role.
2. Go to **Structure → Content types → *(a content type)* → Manage fields** and
   confirm that **Minisite** appears as an available field type when you add a
   field.
3. Create a node with a Minisite field, upload a small test archive (a single root
   directory containing `index.html`), and confirm the extracted page serves
   correctly.

For how to add and use the field, see the "How to use it" section of the
[overview](../index.md) — and read its security note before granting anyone the
`manage minisites` permission.
