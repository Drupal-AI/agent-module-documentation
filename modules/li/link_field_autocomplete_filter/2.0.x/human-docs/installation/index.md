# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Link** module (`link`) enabled — the only dependency, and Drupal enables it
  automatically. You also need at least one Link field on a content type (or other
  entity) for the filter to apply to.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/link_field_autocomplete_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_field_autocomplete_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_field_autocomplete_filter -y
```

There is no configuration page and no permission to grant. Once enabled, the
**"Autocomplete Filter"** section simply appears on every Link field's settings form.

## Verify it worked

Edit any **Link** field instance — for example **Structure → Content types → (type) →
Manage fields → (your link field) → Edit**. You should see a new **Autocomplete
Filter** fieldset on that form. See the [Configuration](../configuration/index.md)
guide for setting it up.
