# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules are required.
- The character counter uses the **jquery.limit** JavaScript library, which is
  currently loaded externally by the module — no manual download step is needed.

## Install with Composer

From the project root:

```bash
composer require drupal/textarea_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/textarea_limit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en textarea_limit -y
```

## Verify it worked

1. Go to **Configuration → Content authoring → Textarea Limit**
   (`/admin/config/content/textarea-limit`) and confirm the settings form opens.
2. On a content type with a textarea field, open **Manage form display**, and set
   that field to use a text limit (see [Configuration](../configuration/index.md)).
3. Open the create/edit form for that content type and start typing in the field
   — it should show how many characters remain and stop you at the limit.
