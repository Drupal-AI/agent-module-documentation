# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module or third-party library dependencies — this is a stand-alone,
single-purpose module.

## Install with Composer

From the project root:

```bash
composer require drupal/gnu_terry_pratchett -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gnu_terry_pratchett -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gnu_terry_pratchett -y
```

That is all — there is no configuration step.

## Verify it worked

Load any page and check the response headers for the tribute:

```bash
curl -sI https://your-site.example | grep -i x-clacks-overhead
```

You should see `X-Clacks-Overhead: GNU Terry Pratchett`. (If you have a reverse
proxy or CDN in front of the site that strips unknown headers, check directly
against the origin.)
