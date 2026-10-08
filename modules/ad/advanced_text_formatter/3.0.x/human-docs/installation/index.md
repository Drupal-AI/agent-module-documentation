# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Text** (`text`) and **Filter** (`filter`) modules enabled — these are
  the only dependencies, and Drupal enables them automatically.
- No third-party Composer libraries or PHP extensions.

> The 3.0.x branch is a **release candidate** (`3.0.0-rc2`) at the time of
> writing. It is generally stable but not a final release, so test before relying
> on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_text_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_text_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_text_formatter -y
```

Enabling the module adds the **Advanced Text** option to the format drop-down on
text fields. It changes nothing until you select it for a field — there is no
configuration form and no permission to grant.

## Verify it worked

Go to a content type's **Manage display** page, for example
`/admin/structure/types/manage/article/display`. In the **Format** column for the
Body (or any text/string) field, open the drop-down; **Advanced Text** should be
listed. Selecting it and clicking the gear reveals its settings — see
[Configuration](../configuration/index.md).
