# Installation

## Requirements

- **Drupal 10.6+, 11.3+, or 12** (`core_version_requirement: ^10.6 || ^11.3 || ^12`).
- **PHP 8.1 or newer** (`composer.json` declares `"php": ">=8.1"`).
- Core's **Field** module (`field`) and **User** module (`user`) — both are part
  of Drupal core and normally already enabled.

There are no third‑party PHP library requirements.

> **Security coverage note.** At the documented version Field Guard is **not
> covered by Drupal's security advisory policy**. Review the code yourself before
> using it to protect sensitive data in production.

## Install with Composer

From the project root:

```bash
composer require drupal/field_guard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_guard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_guard -y
```

Field Guard ships with an **empty configuration**, so enabling it changes
nothing on its own — no field is guarded until you add it to the
`field_guard.settings` map and import that configuration.

## Configure which fields to guard

There is no admin form. Add your entries to the `field_guard.settings`
configuration (in your site's config sync directory), then import it:

```bash
drush config:import -y
```

See the [main guide](../index.md#how-to-configure-it) for the map format, the
`view`/`edit` operations, the rules about omitted operations and empty
permission strings, and the new `view_exempt_own_subject` option.

## Verify it worked

After guarding a field and importing the config, view or edit the entity as a
user who has **not** been granted the nominated permission — including an
administrator — and confirm the field is not shown or editable. Remember that
guarded fields are also **unfilterable and unsortable** in Views and JSON:API by
design.
