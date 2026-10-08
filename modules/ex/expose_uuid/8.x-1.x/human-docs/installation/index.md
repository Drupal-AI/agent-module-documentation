# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies and no third‑party Composer or PHP library
requirements.

> **Note on security coverage:** this project is **not covered by Drupal's security
> advisory policy**. Weigh that against your site's risk tolerance, and restrict the
> `edit uuid` permission tightly.

## Install with Composer

From the project root:

```bash
composer require drupal/expose_uuid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expose_uuid -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expose_uuid -y
```

## Verify it worked

Go to **People → Permissions**, grant **`edit uuid`** to an administrator role,
then open the edit form of an entity such as a custom block. A **UUID** field
should now be visible on the form.

Next, see the "How to use it" section of the [overview](../index.md) — and read the
warning there before you change any UUID.
