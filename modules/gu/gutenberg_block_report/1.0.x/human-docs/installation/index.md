# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (enabled on virtually every site).
- Gutenberg‑authored content to report on — the report is only meaningful on a site
  that uses the Gutenberg editor.

There are no other dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_block_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gutenberg_block_report -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_block_report -y
```

## Verify it worked

Go to **Administration → Reports → Gutenberg block report**. If the report page
loads and lists your Gutenberg blocks with their occurrence counts and sample
nodes, the module is working. (You'll need the module's report permission granted to
your role to see it.)
