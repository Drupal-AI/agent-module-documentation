# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The module relies on a third-party library, so **installing via Composer is
  strongly recommended** (rather than downloading the module by hand) — Composer
  pulls in what it needs.

There are no other contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/linked_data_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed and ensures the third-party library is installed
correctly.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linked_data_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linked_data_field -y
```

## Verify it worked

Go to **Structure → Linked Data Lookup Endpoint** — the collection page for
endpoint definitions should be available, with an **Add** action. You should also
see **Linked Data** listed as a field type when you add a field to a content type.
Next, define an endpoint and attach a field as described in
[Configuration](../configuration/index.md).
