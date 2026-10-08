# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.0 or newer.**
- Access to the **SPIP source database** (or a copy) — the migration sources query
  it directly.

Migrate SPIP was developed and tested against several SPIP 4.x projects and
should be compatible with older SPIP versions back to at least SPIP 3.0. The base
module has no hard module dependencies; note that the **Migrate SPIP Plus**
submodule builds on the [Migrate Plus](https://www.drupal.org/project/migrate_plus)
module.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_spip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_spip -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_spip -y
```

## Submodules — enable only what you need

Migrate SPIP ships three optional submodules to help with your migration. Enable
them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Migrate SPIP UI** | `migrate_spip_ui` | An admin interface for managing Migrate SPIP settings and easily testing rich-text conversions. |
| **Migrate SPIP Examples** | `migrate_spip_examples` | Plugin examples that show how to extend the base module. |
| **Migrate SPIP Plus** | `migrate_spip_plus` | Built on Migrate Plus; provides optional ready-made configurations for common SPIP models (*articles*, *rubriques*, *noisettes*, …). |

For example, to add the settings-and-test interface:

```bash
drush en migrate_spip_ui -y
```

## Verify it worked

With the module enabled, the SPIP rich-text converter and migration sources are
available to your migration definitions. If you enabled **Migrate SPIP UI**, open
its interface and run a test conversion of some SPIP markup to confirm you get
clean HTML back. Then run your migrations with `drush migrate:import`.
