# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Language** module (`language`), for the module's translation support. Drupal
  enables it as a dependency.

There are no third-party PHP libraries to install. The optional API submodules build on
core's JSON:API and REST/Serialization, which core provides.

## Install with Composer

From the project root:

```bash
composer require drupal/site_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_config -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_config -y
```

## Submodules — enable only what you need

Site Config ships two optional submodules that expose your config over an API for
decoupled front ends. Enable them only if you need API access, and only for config that
is safe to be public.

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Site Config JSON:API** | `site_config_jsonapi` | JSON:API endpoints — all configs at `/jsonapi/site-config`, a single config at `/jsonapi/site-config/item/{id}`. |
| **Site Config REST** | `site_config_rest` | REST endpoints — all configs at `/api/site-config`, a single config at `/api/site-config/{id}`. |

For example:

```bash
drush en site_config_jsonapi -y
```

Each submodule requires the base Site Config module, which is already present once you
have installed it above.

## Verify it worked

After enabling, the admin form at **`/admin/site-config`** is where SiteConfig plugin
values are edited. If you have not yet defined any SiteConfig plugins (in your own
module's `src/Plugin/SiteConfig` directory), the page will have no fields to show — that
is expected. Define a plugin, clear caches, and its fields will appear on that page.
