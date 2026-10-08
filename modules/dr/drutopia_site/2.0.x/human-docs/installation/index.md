# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Block Content**, **CKEditor 5**, **Editor**, **Field**, **Filter**,
  **Menu UI** and **Text**.
- **Admin Toolbar** with its **Tools** (`admin_toolbar_tools`) and **Search**
  (`admin_toolbar_search`) submodules, **Autosave Form** (`autosave_form`),
  **Display Suite** (`ds`), **Entity Reference Revisions**
  (`entity_reference_revisions`), **Menu Admin Per Menu**
  (`menu_admin_per_menu`) and **Role Delegation** (`role_delegation`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_site -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Admin
Toolbar, authoring and Drutopia projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_site -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_site -y
```

This creates the three text formats and their CKEditor 5 editors, the `basic` and
`slide` block content types with their displays, and the contributor/editor/
manager editorial roles, and enables the authoring dependencies. On sites
upgrading from older versions, its update hooks migrate the admin-links-access
filter to the Admin Toolbar equivalent and enable the newer dependencies.

## Verify it worked

Check **People → Roles** (`/admin/people/roles`) for the contributor, editor and
manager roles; **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) for the three text formats; and **Structure →
Block content → Block types** (`/admin/structure/block-content/types`) for the
`basic` and `slide` bundles.
