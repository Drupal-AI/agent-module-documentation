# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.2**.
- The **`spatie/schema-org`** library, which the module pulls in via Composer and
  which is used to build the Schema.org types.

There are no other module dependencies. Because of the library requirement,
install with Composer rather than a zip download.

## Install with Composer

From the project root:

```bash
composer require drupal/structured_data_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`spatie/schema-org` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/structured_data_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en structured_data_generator -y
```

The bundled breadcrumb generator is enabled by default, so structured data starts
appearing immediately on pages that have a breadcrumb trail.

## Verify it worked

Visit a page that has breadcrumbs and view its HTML source — you should see a
`<script type="application/ld+json">` element containing a `BreadcrumbList`. You
can also paste the page URL into Google's Rich Results Test to confirm the markup
is valid. To turn generators on or off, see
[Configuration](../configuration/index.md).
