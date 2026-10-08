# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Node** module (`node`) — the only dependency, and part of any standard
  Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/none_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/none_title -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en none_title -y
```

That's all — there is no configuration step.

## Verify it worked

Edit any node, set its **Title** to `<none>`, and save. On the node's display the
title should no longer appear. (Remember the stored label is still the literal
`<none>` — check the admin content listing and the page's `<title>` if either
matters for that node.)
