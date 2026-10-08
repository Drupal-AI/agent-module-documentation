# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/favicons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/favicons -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en favicons -y
```

## Clear the cache first

This step matters. The module registers itself to run near the end of the head
hook order, but on Drupal 10 that placement does not take effect until you clear
the cache:

```bash
drush cr
```

## Verify it worked

After clearing the cache, upload your source PNG in the settings form (see
[Configuration](../configuration/index.md)). Then load any page and view its
source — you should see the generated icon `<link>` tags and a reference to
`site.webmanifest` in the `<head>`. Browsers and mobile devices will pick up the
new favicon and touch icons from there.
