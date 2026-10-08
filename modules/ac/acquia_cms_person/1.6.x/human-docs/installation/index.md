# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Place** (`acquia_cms_place`) — a direct dependency. Place depends
  on `acquia_cms_image` and `acquia_cms_common`, so enabling Person pulls in that
  whole chain (and its dependencies: Address, Geocoder, Telephone, Field Group,
  Media, the common layer).
- **Scheduler** (`scheduler`) — scheduled publishing/unpublishing.

The Acquia CMS modules are designed to be adopted as a set, so expect the broader
family to come along with this one.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_person -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the sibling
Acquia CMS modules and shared dependencies this module needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_person -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_person -y
```

Drush enables the dependency chain automatically. Once it finishes, the
**Person** content type is available under **Content → Add content**. There is no
required configuration.
