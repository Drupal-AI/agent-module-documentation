# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1** or newer.
- Core's **Block** module (`block`), which Drupal enables as a dependency.
- A theme whose `block.html.twig` honours the `title_element` variable, so the
  chosen element is rendered (it defaults to `strong` otherwise).

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_title_html_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_title_html_element -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_title_html_element -y
```

After enabling, grant the **Administer block title element** permission to the
appropriate roles, then choose a title element on any block — see
[How to use it](../index.md#how-to-use-it).
