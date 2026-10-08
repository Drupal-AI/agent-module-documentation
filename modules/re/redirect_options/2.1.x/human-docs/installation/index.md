# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The contrib **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — Redirect Options extends its add/edit forms, so it must be
  present and enabled. Composer pulls it in with the `-W` flag below.
- Core's **Taxonomy** module (part of core), since the redirect types are stored
  as taxonomy terms.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_options -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure the Redirect module is enabled first, then:

```bash
drush en redirect_options -y
```

Enabling the module runs its install step, which **creates the *Type of Redirect*
vocabulary** (with the *Template* and *Server* terms) and defines the
`redirect_options` companion table.

## Verify it worked

- Under **Structure → Taxonomy**, confirm a **Type of Redirect** vocabulary now
  exists with **Template** and **Server** terms.
- Add or edit a redirect at `/admin/config/search/redirect` and confirm the
  **Select redirect type** dropdown appears on the form. Save with a type chosen,
  and check that it shows in the redirect listing.
