# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** (`field`) and **Views** (`views`) modules — both standard on a
  typical Drupal install.
- The contributed **Token** module (`drupal/token`), which Composer pulls in
  automatically with the command below.

There are no PHP library requirements.

> **A note on release maturity:** at the documented version this is a **beta**
> release and is **not** covered by the Drupal security advisory policy. Test it
> before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/listing_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
(including Token) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/listing_page -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en listing_page -y
```

Enabling the module also enables Field, Views, and Token if they aren't already
on.

## Verify it worked

1. Edit any view at **Structure → Views** and confirm you can add a **Listing
   page** display.
2. Create a content type and confirm the **Entity listing information** field type
   appears in the "Add field" list at **Manage fields**.

If both are present, the module is installed correctly and you can follow the
"How to use it" workflow in the [overview](../index.md).
