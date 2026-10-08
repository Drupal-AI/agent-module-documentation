# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Drupal core only — there are no module dependencies and no PHP library
  requirements. (It builds on core's Node module, which supplies the node forms it
  alters.)

## Install with Composer

From the project root:

```bash
composer require drupal/disable_author -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_author -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_author -y
```

The module does nothing until you choose which roles should have the author
fieldset hidden — see [Configuration](../configuration/index.md).

## Verify it worked

After selecting one or more roles on the settings page, log in as a user who has one
of those roles and open a node add or edit form (for example
`/node/add/article`). The **Authoring information** fieldset should be gone. Log in
as a user without any of the selected roles and confirm the fieldset still appears
for them.
