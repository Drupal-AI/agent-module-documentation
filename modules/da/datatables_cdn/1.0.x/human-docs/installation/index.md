# Installation

## Requirements

- **Drupal 8.9 up to (but not including) Drupal 11** — the module declares
  `core_version_requirement: >=8.9 <11.0.0-stable`, so check compatibility before
  using it on Drupal 11.
- Core's **jQuery** library, which the DataTables libraries depend on.
- The module also declares a dependency on the **CKEditor** module (`ckeditor`),
  which is unusual for a table library — confirm whether your build needs it.
- The **DataTables** plugin itself is **not** downloaded; it is loaded at runtime
  from the external `cdn.datatables.net` CDN. See the security and CSP notes in the
  [overview](../index.md#important-third-party-cdn-egress-and-security).

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datatables_cdn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datatables_cdn -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datatables_cdn -y
```

## Verify it worked

There is no admin settings page. To confirm the module is doing its job, attach
`datatables_cdn/datatables` to a page that renders a `<table>` (see
["How to use it"](../index.md#how-to-use-it)) and load that page. The table should
become sortable, searchable, and paginated, and your browser's network panel
should show the DataTables assets being fetched from `cdn.datatables.net`. If they
are blocked, check your site's Content Security Policy allows that host.
