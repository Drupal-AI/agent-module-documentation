# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Place** (`acquia_cms_place`) — a direct dependency, used for the
  event's venue. Place itself depends on `acquia_cms_image` and
  `acquia_cms_common` (and Address, Scheduler, Geocoder, Telephone, Field Group),
  so enabling Event pulls in that whole chain.
- Core **Datetime** (`datetime`) — for the event date fields.
- **Schema.org Metatag: Event** (`schema_event`) — Schema.org Event markup.

The Acquia CMS modules are designed to be adopted as a set, so expect the broader
family to come along with this one.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_event -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the sibling
Acquia CMS modules and shared dependencies this module needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_event -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_event -y
```

Drush enables the dependency chain automatically. Once it finishes, the **Event**
content type is available under **Content → Add content**. There is no required
configuration.
