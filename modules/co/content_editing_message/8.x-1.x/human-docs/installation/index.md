# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No required contrib dependencies and no third‑party PHP or JavaScript
  libraries.
- **Optional:** the [Field Group](https://www.drupal.org/project/field_group)
  module. When it is installed, message configuration gains an extra option for
  targeting a specific field group by machine name.

## Install with Composer

From the project root:

```bash
composer require drupal/content_editing_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_editing_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_editing_message -y
```

## Verify it worked

The module ships with no messages, so nothing changes on edit forms until you add
one. Go to **Configuration → Content authoring → Content Editing Messages**
(`/admin/config/content/messages`) and confirm the message collection page loads.
Then follow [Configuration](../configuration/index.md) to create your first
message and see it appear on the matching edit form.
