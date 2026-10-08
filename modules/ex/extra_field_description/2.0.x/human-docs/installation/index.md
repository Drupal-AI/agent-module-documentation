# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`; Composer requires
  `drupal/core: ^9.2 || ^10 || ^11`).
- No other contrib modules and no third-party PHP libraries. It works with core's Field UI.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_field_description -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/extra_field_description -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_field_description -y
```

## Grant the permission

Authoring extra descriptions is gated by a dedicated permission. Go to **People → Permissions**
and grant **Administer extra description** (`administer field prefix`) to the roles that should
be able to add these notes. (Editing the widget settings where the note lives also requires
core's restricted "administer … form display" permission, so this is a second, narrower gate.)

Once enabled and permitted, add extra descriptions per field on **Manage form display** — see
**How to use it** in the [overview](../index.md).
