# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **REST** (`rest`) and **Views** (`views`) modules.
- The contributed **JS Cookie** (`js_cookie`) module, used for client-side cookie
  handling. Composer installs it automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/simpleads -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and here it also pulls in the required **JS Cookie**
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simpleads -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simpleads -y
```

Drupal will enable the REST, Views and JS Cookie dependencies alongside it.

## Verify it worked

Log in as an administrator and confirm you can reach the SimpleAds management screens
to create ads, ad groups and campaigns. Then check **People → Permissions** and grant
the SimpleAds entity permissions (add/edit/delete/view, plus the click and impression
counting permissions) to the roles that should manage or report on advertising.
