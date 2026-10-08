# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`; the
  2.2.x release targets Drupal 10.3+ and 11).
- No third-party Composer libraries, no PHP extensions, and no other module
  dependencies.

Which hideable options appear on the settings form depends on the modules you
already have enabled — for example the *Menu settings*, *URL path settings*,
*Comment settings*, *Book outline*, and *Meta tags* rows only show up when the
Menu, Path, Comment, Book, and Metatag modules (respectively) are on.

## Install with Composer

From the project root:

```bash
composer require drupal/simplify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simplify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplify -y
```

Enabling the module does **not** hide anything on its own — every hideable field
starts unchecked. You choose what to hide on the settings form, described in
[Configuration](../configuration/index.md).

## Grant permissions

Simplify adds two permissions at **People → Permissions**
(`/admin/people/permissions`):

- **Administer Simplify** (`administer simplify`) — access the settings form and
  see the per-bundle "Simplify" section on entity-type edit forms. Grant to
  site administrators.
- **View hidden fields** (`view hidden fields`) — users with this permission are
  exempt from Simplify and see every hidden field normally. Grant it to trusted
  power users who still need the full forms.

## Verify it worked

Go to **Configuration → User interface → Simplify**
(`/admin/config/user-interface/simplify`). You should see the settings form with
checkbox groups for each entity type. Tick a field, save, then open a matching
edit form as a non-admin editor to confirm the field is hidden. Continue with
[Configuration](../configuration/index.md) for the full walkthrough.
