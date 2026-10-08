# Installation

## Requirements

Reassign Deleted User Content / Media needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** and **User** modules enabled — these are the only hard
  dependencies.

There are no third‑party Composer or PHP library requirements. Handling for
**Media**, **Group**, **Comment**, and **Content Moderation** activates
automatically only if those modules are enabled — none of them is required.

## Install with Composer

From the project root:

```bash
composer require drupal/reassign_user_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reassign_user_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reassign_user_content -y
```

There's no configuration step. Once enabled, the new cancellation method appears
on the account‑cancel forms and the "Reassign selected content to user" action
appears on the content overview — see
[How to use it](../index.md#how-to-use-it).
