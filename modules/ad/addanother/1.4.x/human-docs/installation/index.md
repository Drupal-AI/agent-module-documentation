# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — Add Another only works with node content and
  Drupal enables Node as a dependency automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/addanother -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addanother -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addanother -y
```

## Turn it on for your editors

Two things make the shortcuts appear:

1. **Grant the permission.** At **People → Permissions**, give your editorial roles
   the **Use add another** permission — without it the button, message and tab are
   hidden.
2. **Pick which content types get it.** Set site-wide defaults at
   **Configuration → Content authoring → Add another**, and override per type on each
   content type's edit form. See [How to use it](../index.md#how-to-use-it) for the
   details of each option.

The **Administer add another** permission controls who can reach the settings form.
