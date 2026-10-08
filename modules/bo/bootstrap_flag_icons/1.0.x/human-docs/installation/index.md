# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **multilingual setup** for the switcher to be useful — core's Language module
  (and the translation modules you need) with more than one language configured.
- A **Bootstrap 5 theme** so the dropdown switcher renders in the expected style.
- **CKEditor 5** (Drupal core's default editor) for the flag-icon insert tool.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_flag_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_flag_icons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_flag_icons -y
```

After enabling, place the language-switcher block and add the CKEditor button to
a text format — see [How to use it](../index.md#how-to-use-it) in the overview.
There is no settings form to fill in.
