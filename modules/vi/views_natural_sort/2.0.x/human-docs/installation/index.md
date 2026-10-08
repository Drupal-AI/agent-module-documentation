# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), enabled — the only dependency, and Drupal
  enables it automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_natural_sort -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_natural_sort -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_natural_sort -y
```

Core Views is pulled in automatically if it isn't already on. Enabling the module
creates its index table (`views_natural_sort`) and populates it from existing
content, so titles are ready to sort naturally. If you have a large amount of
content, run the **Rebuild Index** afterward (see
[Configuration](../configuration/index.md#rebuild-the-index)) to be sure everything
is indexed.

## Verify it worked

Edit any View that has a string-property sort (e.g. a content View with a **Title**
sort). In the sort's order options you should now see **Sort ascending naturally**
and **Sort descending naturally** alongside the plain options. Choosing one and
viewing the result should show titles ordered with leading articles ignored and
embedded numbers in numeric order. Then visit
**Structure → Views → Settings → Natural Sort**
(`/admin/structure/views/settings/views_natural_sort`) to tune what gets stripped —
see [Configuration](../configuration/index.md).
