# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **User** (`user`) modules — both are part of
  standard Drupal and are enabled automatically as dependencies.
- **Recommended:** the [Token](https://www.drupal.org/project/token) module
  (`drupal/token`). It is not strictly required, but with it installed every site
  setting is exposed as a token — which is how you drop settings into emails and
  other text. Add it the same way:
  `composer require drupal/token -W` then `drush en token -y`.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_settings -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_settings -y
```

On install the module does two things worth knowing about:

- It grants **View published site setting entities** to the anonymous and
  authenticated roles, so settings values can be rendered on the front end out of
  the box.
- It turns **off** the legacy auto-loading of settings into every template and
  selects the recommended **full** loader. This means the old
  `{{ site_settings.group.name }}` variable is *not* present on a fresh install;
  use the Twig functions instead (or re-enable auto-loading — see
  [Configuration](../configuration/index.md)).

## Optional submodule — per-type permissions

**Site Settings Type Permissions** (`site_settings_type_permissions`) ships inside
this project. Enable it if you need to control who can edit or view **each**
settings type separately (rather than all settings at once):

```bash
drush en site_settings_type_permissions -y
```

It adds per-type permissions (for example *edit phone_number site setting*) that
combine with the module's global permissions.

## Next steps

Head to [Configuration](../configuration/index.md) to define your first settings
type and grant editors the right permissions.
