# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Gutenberg](https://www.drupal.org/project/gutenberg) editor module
  (`gutenberg:gutenberg`) — its output is what these filters process.
- Core's **Filter** module (`filter`), which provides the text-format system the
  filters plug into. Drupal enables it as a dependency automatically.

There are no third-party Composer or PHP library requirements.

> **Note:** this module is **not covered by Drupal's security advisory policy**.
> Weigh that against your site's risk tolerance before using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Gutenberg and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gutenberg_extra -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_extra -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors** and edit
the **Gutenberg Blocks** text format. In the **Enabled filters** list you should
now see the Gutenberg Extra filters (group, gallery, image). Tick the ones you
need and save — see the [main guide](../index.md#how-to-use-it) for how each one
behaves.
