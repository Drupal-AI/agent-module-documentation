# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No contrib dependencies and no third-party libraries.
- A **Siteimprove Analytics account** with an application code — you'll need it to
  actually turn tracking on (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/siteimprove_analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/siteimprove_analytics -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en siteimprove_analytics -y
```

## Grant the permission

To let a role change tracking settings, give it the **"administer
siteimprove_analytics"** permission at **People → Permissions**
(`/admin/people/permissions`). Administrators have it by default.

## Verify it worked

Go to **Configuration → System → Siteimprove Analytics**
(`/admin/config/system/siteimprove-analytics`). You should see the settings form.
Nothing is tracked until you enter an application code — see
[Configuration](../configuration/index.md).
