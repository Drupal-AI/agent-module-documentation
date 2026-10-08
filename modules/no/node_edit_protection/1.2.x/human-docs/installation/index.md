# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies. The client-side guard uses only core's jQuery and Drupal
  JavaScript, both always present.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/node_edit_protection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_edit_protection -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_edit_protection -y
```

That's the entire setup. There is no configuration page, no permission, and nothing to
switch on — the unsaved-changes guard is active on node add and edit forms
immediately.

## Verify it worked

Open any node add or edit form, change a field, and then try to navigate away without
saving (click a link, or press the browser back button). You should see the browser's
native "Leave site?" confirmation. Clicking a real **Save** button should submit
without any warning.
