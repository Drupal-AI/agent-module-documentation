# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Node** (`node`) and **User** (`user`) modules — both part of a standard
  Drupal install and enabled automatically as dependencies.
- A content type with a **body** field (Partial Access works by truncating the
  body).
- No external libraries, APIs, or Composer dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/partial_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/partial_access -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en partial_access -y
```

## Verify it worked

Configure the module first (see [Configuration](../configuration/index.md)) — pick
the roles that get full content and set a CTA message. Then view a node as a user
*without* one of those roles (for example, log out and view it anonymously): you
should see only a portion of the body followed by your CTA message. Viewing the
same node as a privileged role should show the full body.

Remember the caveat from the overview: this truncation is visible only on the
rendered HTML page. Do not treat it as protection against JSON:API, REST, feeds, or
search access.
