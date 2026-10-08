# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** module (`link`) — the only dependency, enabled automatically.

## Install with Composer

The Composer package name differs from the module's machine name. Require it by its
**package name**:

```bash
composer require drupal/link_field_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_field_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, which is `link_field_entity_filter`:

```bash
drush en link_field_entity_filter -y
```

## Verify it worked

Open a **Link** field's settings and confirm you can now restrict which content
types the field may link to. Set a restriction, then edit content and confirm the
link field guides you to only the allowed content types.
