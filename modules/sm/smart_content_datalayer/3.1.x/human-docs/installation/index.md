# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).
- **Smart Content** (`smart_content`) — the base module this submodule extends.

You'll also want a tag manager (such as Google Tag Manager) actually populating
`window.dataLayer` on your pages, otherwise the conditions have nothing to read.
There are no third-party Composer packages or PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_content_datalayer -W
```

The Composer package name (`drupal/smart_content_datalayer`) matches the module's
machine name (`smart_content_datalayer`). The `-W` (`--with-all-dependencies`)
flag lets Composer install Smart Content and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_content_datalayer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_content_datalayer -y
```

Drupal enables Smart Content at the same time, since it is a dependency. There is
no separate configuration step — the dataLayer conditions appear inside Smart
Content's segment authoring right away.
