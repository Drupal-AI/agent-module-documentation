# Installation

## Requirements

No Referrer is self-contained. It needs:

- **Drupal 11.1+ or 12** (`core_version_requirement: ^11.1 || ^12`).
- No other modules, third-party Composer packages, PHP extensions, or JavaScript
  libraries. (The text-format filter that protects user content builds on core's
  Filter system, which is part of standard Drupal.)

## Install with Composer

From the project root:

```bash
composer require drupal/noreferrer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/noreferrer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en noreferrer -y
```

As soon as it's enabled, the attributes are added to links Drupal generates
(menus, link fields, and the like) using the default settings — all three
attributes on. Protecting user-generated content requires one more step: enabling
the text-format filter, described in [Configuration](../configuration/index.md).

## Verify it worked

View a page with an external link that opens in a new tab and inspect it — it
should now carry `rel="noopener"` (and `rel="noreferrer"` for external hosts not on
your allow-list). Then visit the settings form at **Configuration → Content
authoring → No Referrer** (`/admin/config/content/noreferrer`) to fine-tune the
behavior.
