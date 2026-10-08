# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`).
- Core's **Field** (`field`) and **User** (`user`) modules.
- **Dynamic Entity Reference**
  ([`dynamic_entity_reference`](https://www.drupal.org/project/dynamic_entity_reference)).
- **Service** ([`service`](https://www.drupal.org/project/service)), version 3.0 or
  newer.

The two contributed dependencies (Dynamic Entity Reference and Service) are pulled
in automatically by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/field_suggestion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Dynamic Entity Reference and Service.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_suggestion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_suggestion -y
```

This also enables the required Dynamic Entity Reference and Service modules if they
aren't already on.

> **Note:** This release is a beta (`1.0.0-beta3`). Test it on a non‑production
> environment before relying on it for live editing.

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and confirm the
**Administer field suggestion**, **Ignore field suggestion**, and **Pin and unpin
field suggestion** permissions are listed. Grant them as needed, then check that
suggestions appear on a configured field when editing content.
