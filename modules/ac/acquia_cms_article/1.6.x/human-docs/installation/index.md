# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Person** (`acquia_cms_person`) — a direct dependency. Person in
  turn depends on `acquia_cms_place`, which depends on `acquia_cms_image` and
  `acquia_cms_common`, so enabling Article pulls in that whole chain plus their
  own dependencies (Address, Scheduler, Geocoder, Field Group, and the common
  layer's modules). This is expected: the Acquia CMS modules are designed to be
  adopted as a set, not cherry-picked.

There are no extra PHP or third-party library requirements beyond what the
dependency chain brings.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_article -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the sibling
Acquia CMS modules and shared dependencies this module needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_article -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_article -y
```

Drush enables the dependency chain automatically. Once it finishes, the
**Article** content type is available under **Content → Add content**. There is
no required configuration.
