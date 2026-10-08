# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** module (`language`) enabled — this is a dependency, and Drupal
  will enable it automatically as needed. The module only makes sense on a
  multilingual site where language negotiation is in play.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_language_t_function_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_language_t_function_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_language_t_function_override -y
```

After enabling, visit the settings form at
**Configuration → Regional and language → Admin Language t() function Override**
(`/admin/config/regional/admin-language-t-function-override`) to review and extend the
list of paths that are forced to English. See the
[overview](../index.md#how-to-use-it) for how the path list works.
