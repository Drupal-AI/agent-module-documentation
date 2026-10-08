# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Image** (`acquia_cms_image`) — a direct dependency, which itself
  depends on `acquia_cms_common`, so enabling Place pulls in that chain.
- **Address** (`address`) — the postal address field.
- **Geocoder** (`geocoder_address`, `geocoder_geofield`) — turns addresses into
  coordinates.
- Core **Path** (`path`) and **Telephone** (`telephone`).
- **Scheduler** (`scheduler`) — scheduled publishing/unpublishing.
- **Field Group** (`field_group`) — groups fields on the place form.

The Acquia CMS modules are designed to be adopted as a set, so expect the broader
family to come along with this one.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_place -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the sibling
Acquia CMS modules and shared dependencies (Address, Geocoder, and the rest).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_place -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_place -y
```

Drush enables the dependency chain automatically. Once it finishes, the **Place**
content type is available under **Content → Add content**. There is no required
configuration.
