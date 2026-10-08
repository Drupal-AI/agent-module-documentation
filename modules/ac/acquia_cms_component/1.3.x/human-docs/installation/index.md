# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Acquia CMS Common** (`acquia_cms_common`) — the shared Acquia CMS layer.

Enabling Component pulls in the common layer and its dependencies, so expect the
broader Acquia CMS set to come along with it.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_component -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`acquia_cms_common` and the other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_component -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_component -y
```

Drush enables the common layer automatically. Once it finishes, the standard
components are available to editors. There is no required configuration.
