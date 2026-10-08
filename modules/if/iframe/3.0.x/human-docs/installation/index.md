# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** (`field`) and **Link** (`link`) modules — these are the only
  dependencies, and Drupal enables them automatically as dependencies. Both are part
  of the standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Optional: Token

The **Token** module (`drupal/token`) is suggested but not required. Install it if
you want to allow token replacement in an iframe field's title and/or URL:

```bash
composer require drupal/token -W
drush en token -y
```

## Install with Composer

From the project root:

```bash
composer require drupal/iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iframe -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iframe -y
```

## No separate permissions

Iframe defines no permissions of its own. Who can add fields and manage displays is
governed by the usual core permissions (such as *Administer content types* and
*Administer node fields*), and who can fill in an iframe field's value is governed
by the normal content edit permissions.

## Verify it worked

Go to a content type's field management page (for example **Structure → Content
types → Article → Manage fields → Add field**) and confirm **Iframe** appears in the
list of field types. From there, see [Configuration](../configuration/index.md) to
set it up.
