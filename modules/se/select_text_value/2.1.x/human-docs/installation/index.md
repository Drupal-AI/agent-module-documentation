# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

That's all — the module only builds on core's Field and Text modules (always
present), so it has no other Drupal module dependencies and no third-party Composer
or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/select_text_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/select_text_value -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select_text_value -y
```

## Verify it worked

Go to any content type's **Manage form display** page (e.g.
**Structure → Content types → Article → Manage form display**). On a text field's
row, open the **Widget** dropdown — you should now see **Select text value** as an
option. Choosing it and clicking the cog reveals the allowed-values settings
described in the [overview](../index.md#how-to-use-it). There's no separate
configuration page to visit.
