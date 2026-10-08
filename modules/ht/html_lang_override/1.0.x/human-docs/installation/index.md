# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other Drupal modules and no third‑party Composer or PHP libraries are
  required — it works with Drupal core only.

## Install with Composer

From the project root:

```bash
composer require drupal/html_lang_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_lang_override -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_lang_override -y
```

On enable, the module initialises the global default language code from your site's
current default language, so nothing changes until you set an override.

## Verify it worked

Log in as an administrator and visit
**Configuration → Regional and language → HTML Lang Override**
(`/admin/config/regional/html-lang-override`) — you should see the settings form.
Editing a node, you should also find a **Custom HTML Lang Attribute** field in the
*Advanced* section (if your account holds the override permission). See
[Configuration](../configuration/index.md) to put it to work.
