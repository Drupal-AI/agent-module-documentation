# Installation

## Requirements

Simple Time Field is deliberately lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — this is the only dependency, and it is part
  of a standard Drupal install.

There are no third-party Composer packages or PHP library requirements. The
**Feeds** module is optional and only needed if you want the import mapper.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_time_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_time_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_time_field -y
drush cr
```

## Verify it worked

Go to **Structure → Content types → [any type] → Manage fields**, click **Create a
new field**, and confirm that **Time** now appears in the list of field types. Add
one, and you should see the HTML5 time picker on the entity's edit form.
