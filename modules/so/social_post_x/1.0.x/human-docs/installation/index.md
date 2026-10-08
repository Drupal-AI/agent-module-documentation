# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Social Post** framework, which this module extends (install and configure
  it first — see its
  [guide](../../../social_post/3.0.x/human-docs/index.md)).
- An X developer application with API/OAuth credentials for the account you want
  to post to.

No third-party Composer or PHP library requirements are declared by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/social_post_x -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_post_x -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_post_x -y
```

## Verify it worked

Open the module's settings form (config `social_post_x.settings_form`) and confirm
it loads, then enter your X API credentials as described in
[Configuration](../configuration/index.md). The X integration should also appear
on Social Post's integrations page at **Configuration → Social API → Social
Post**.
