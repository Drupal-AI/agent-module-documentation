# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements — it works with Drupal core only.

## Install with Composer

From the project root:

```bash
composer require drupal/lazy_iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lazy_iframe -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lazy_iframe -y
```

That is all it takes — there is no configuration step.

## Verify it worked

Visit a page that contains an embedded iframe (a video or a map, for example) and
view the page source or inspect the iframe element. It should now carry
`loading="lazy"`. Any iframe that already had a `loading` attribute keeps its
original value.
