# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** system (always present in Drupal).

There are no third-party Composer or PHP library requirements.

> **Note:** the current release is a beta (`1.1.0-beta1`) and is not covered by
> Drupal's security advisory policy. Test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/citeref_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/citeref_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en citeref_field -y
```

## Grant the permission

Administering the module's fields is controlled by the **Administer citeref_field**
permission. Grant it to the roles that build content types (typically site
builders / administrators) at **People → Permissions**.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and start adding
a new field. The Citeref citation/reference field types should now appear in the
field-type list. Add one, save, and confirm its widget shows on the content form.
