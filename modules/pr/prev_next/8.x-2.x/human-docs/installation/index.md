# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules and no third‑party PHP or JavaScript libraries are required.

Note that this project's `8.x-2.x` branch is a **beta** release and is *not*
covered by Drupal's security advisory policy. Review it before relying on it for a
production site.

## Install with Composer

From the project root:

```bash
composer require drupal/prev_next -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prev_next -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prev_next -y
```

## Verify it worked

After enabling, run cron a few times (`drush cron`) and let the module build its
index in the background. To index content that already existed before install, go
to the content list, select those nodes, and run the **Save content** bulk action.

Then, in your theme or a custom module, call `prev_next_nid($nid, 'prev')` /
`prev_next_nid($nid, 'next')` for a node you know has neighbours and confirm you
get the expected node IDs back. See [How to use it](../index.md#how-to-use-it) for
the settings page and code examples.
