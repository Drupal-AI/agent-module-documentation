# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **[Contact Storage](https://www.drupal.org/project/contact_storage)** module
  (`contact_storage`) — this is a hard dependency, because this module refines the
  "Options email" field type that Contact Storage provides. Composer pulls it in
  automatically.

There are no additional PHP libraries or third‑party Composer requirements. Note
that this project is **not covered by Drupal's security advisory policy**, so
review it yourself before using it on a high‑stakes site.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_storage_options_email_recipient -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Contact Storage
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_storage_options_email_recipient -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_storage_options_email_recipient -y
```

This enables Contact Storage too if it isn't already on.

## Verify it worked

Edit a contact form that has a **required** "Options email" field. You should see
the notice "The recipient of this form is determined by the '[field name]' field."
at the top of the edit page, and the standard single-recipient field should be
gone. Submit a test message per option to confirm routing.
