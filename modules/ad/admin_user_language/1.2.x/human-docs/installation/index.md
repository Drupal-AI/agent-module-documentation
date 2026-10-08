# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present in a Drupal site.
- **Two or more active languages.** The module has nothing to do on a
  single‑language site — the *administration pages language* field itself is
  only meaningful once there is more than one language to choose from. Add a
  language under **Configuration → Regional and language → Languages**, or with
  `drush language:add <langcode>`.
- For the forced language to actually change how the admin UI renders, pair this
  module with a negotiation module such as **Admin Language Negotiation**
  (`admin_language_negotiation`). This module only sets the stored preference; it
  does not switch the interface at request time on its own.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_user_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/admin_user_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_user_language -y
```

Enabling the module does not change anything until you configure it — the shipped
default is "- No preference -", which means no language is forced. Head to
[Configuration](../configuration/index.md) to choose a language and enforcement
level.
