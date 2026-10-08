# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contributed **Geolocation** module (`geolocation:geolocation`) — used for
  geographic authority terms.
- The contributed **Token** module (`token:token`).

Both dependencies are installed automatically when you require the module with
`-W`. There are no third‑party PHP library requirements of the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/controlled_access_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Geolocation, Token,
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/controlled_access_terms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en controlled_access_terms -y
```

## Submodules

- **Controlled Access Terms Defaults** (`controlled_access_terms_defaults`) — ships
  default configuration (vocabularies and starter setup) so you have a working
  authority structure out of the box. Enable it if you want that head start:

  ```bash
  drush en controlled_access_terms_defaults -y
  ```

## Verify it worked

Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`). If you enabled the
defaults submodule, you should see the authority vocabularies (Persons, Families,
Corporate Bodies, and subject/geographic terms). In the Field UI, the **EDTF
Dates**, **Authority Links**, and **Typed Relations** field types should be
available when adding a field. That confirms the module is active.
