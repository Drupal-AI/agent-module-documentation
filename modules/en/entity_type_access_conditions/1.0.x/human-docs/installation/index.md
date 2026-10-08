# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The [**Conditions Helper**](https://www.drupal.org/project/conditions_helper)
  module (`conditions_helper` `^1.0`) — a hard dependency that provides the
  condition-building UI and evaluation this module relies on. Composer pulls it in
  automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_type_access_conditions -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in Conditions Helper and any other shared dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_type_access_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_type_access_conditions -y
```

Enabling it also enables **Conditions Helper** if it is not already on. There are
no submodules.

## Grant the permissions

The module defines two permissions, both flagged as security-sensitive ("grant
with care"), at **People → Permissions**
(`/admin/people/permissions`):

- **Administer entity type access conditions** — needed to open the settings page
  and choose which condition plugins are available. Grant to trusted
  administrators.
- **Bypass entity type access conditions** — a user with this permission always
  passes this module's checks (the module returns "neutral" for them, skipping its
  restrictions). Useful for a support or admin role that must never be locked out —
  grant it carefully, since it disables the whole feature for those users.

## Verify it worked

Visit **Configuration → Content authoring → Entity Type Access Conditions**
(`/admin/config/content/entity-type-access-conditions`) to confirm the settings
page loads, then edit a content type and look for the new **Entity Type Access
Conditions** section. See [Configuration](../configuration/index.md) for the setup.
