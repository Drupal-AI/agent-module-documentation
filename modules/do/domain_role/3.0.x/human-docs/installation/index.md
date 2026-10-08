# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- The **Domain** module (`domain`).
- The **Domain Configuration** submodule (`domain_config`), which ships with the
  Domain project — this is what gives each domain its own role configuration.

There are no third-party PHP or Composer library requirements.

> **Compatibility caution:** Domain Role overrides both the core User entity class
> and the Cookie authentication provider. If your site uses an alternative
> authentication provider (SSO, JWT, etc.) or another module that overrides the
> user entity, test carefully for conflicts before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/domain_role -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_role -y
```

Make sure `domain` and `domain_config` are enabled too (Composer/Drush will pull
`domain` in; enable `domain_config` if it is not already on):

```bash
drush en domain_config -y
```

## Verify it worked

Go to **People → Domain Role** (`/admin/people/domain_role`). You should reach the
domain role configuration form. See [Configuration](../configuration/index.md) for
defining roles and assigning them. Clear caches after adding domains or roles so
the role mapping is rebuilt.
