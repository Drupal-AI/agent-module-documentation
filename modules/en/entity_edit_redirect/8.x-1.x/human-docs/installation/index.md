# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other module dependencies, and no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_edit_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_edit_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_edit_redirect -y
```

## Verify it worked

Nothing redirects yet — that is expected until you configure it. Go to
**Configuration → Content authoring → Entity Edit Redirect**
(`/admin/config/content/entity_edit_redirect`) and confirm the settings form
loads. If you get an access-denied page, make sure your role has the module's
*"admininister entity edit redirect configuration"* permission (yes, spelled with
the extra "in" — that is the module's own string). Then head to
[Configuration](../configuration/index.md) to set up the rules.
