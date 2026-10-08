# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Menu link content** module (`menu_link_content`) — this is the entity
  whose link becomes translatable.
- Core's **Content translation** module (`content_translation`) — this provides the
  translation workflow; without it there are no translations for the override to
  apply to.

Drupal enables both of these automatically as dependencies when you turn on the
module. You'll also need a genuinely multilingual site — more than one language
added under **Configuration → Regional and language → Languages**.

*Optional:* the [Token](https://www.drupal.org/project/token) module enables token
replacement inside the override URLs.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/translatable_menu_link_uri -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/translatable_menu_link_uri -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en translatable_menu_link_uri -y
```

This pulls in **Menu link content** and **Content translation** if they aren't
already on. After enabling, turn on translation for custom menu links and start
translating link destinations — see
[How to use it](../index.md#how-to-use-it).

There are no submodules.
