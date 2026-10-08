# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Field Group** module (`field_group`) — this formatter plugs into Field
  Group's grouping system.
- **Bootstrap 5 assets** available on the front end — either the Bootstrap 5.x
  theme, or Bootstrap 5's CSS/JS added to your site libraries.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_modal_bootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Field Group dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_group_modal_bootstrap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_modal_bootstrap -y
```

This also enables Field Group if it isn't already on.

## Make sure Bootstrap 5 is present

The modal relies on Bootstrap 5's styling and markup. If your active theme is a
Bootstrap 5.x theme, you're already covered. Otherwise, add Bootstrap 5's assets
to your site — for example via a theme library or a custom library definition —
so the modal renders and opens correctly.

## Verify it worked

On any entity's **Manage display**, add a field group and open its format
dropdown — you should see **Modal Bootstrap** listed. Assign it, move a field
into the group, save, and view the entity: the grouped field content should
appear inside a Bootstrap 5 modal dialog.
