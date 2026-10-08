# Installation

## Requirements

Block List Override is self-contained. It needs:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Block** module (`block`), which is part of standard Drupal and is
  enabled automatically as a dependency. (Layout Builder filtering additionally
  requires core's Layout Builder module, if you use that.)
- No third-party Composer packages, PHP extensions, or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/block_list_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_list_override -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_list_override -y
```

Enabling it changes nothing until you add rules on the settings form — with the
pattern fields empty, no blocks are filtered.

## Migrating from Block Blacklist

If your site previously used the legacy **Block Blacklist** module, Block List
Override automatically copies its settings across on install, so your existing
rules carry over.

## Verify it worked

Go to **Configuration → System → Block List Override Settings**
(`/admin/config/block_list_override/settings`) and confirm the form loads. Then see
[Configuration](../configuration/index.md) to add your rules — and use the preview
pages to check the result before relying on it.
