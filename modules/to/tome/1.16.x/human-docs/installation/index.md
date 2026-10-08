# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the codebase also
  carries `^9` compatibility markers).
- Drush, since Tome's main interface is the `tome:*` command family.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/tome -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tome -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enabling the umbrella `tome` module pulls in the two workhorse submodules,
**Tome Static** and **Tome Sync**:

```bash
drush en tome -y
```

## Submodules — enable only what you need

Tome ships several submodules. The umbrella depends on the first two; the rest are
optional add-ons you enable individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Tome Base** | `tome_base` | Shared services and the `CommandBase` that every `tome:*` Drush command extends. Enabled as a dependency. |
| **Tome Static** | `tome_static` | Static HTML generation (`drush tome:static`) and the admin page at `/admin/config/tome/static`. |
| **Tome Sync** | `tome_sync` | The JSON content/config/files store (`drush tome:export` / `tome:import`) and the admin page at `/admin/config/tome/sync`. |
| **Tome Static Cron** | `tome_static_cron` | Runs static builds unattended on cron via a queue worker. Has its own config object (`tome_static_cron.settings`). |
| **Tome Static Super Cache** | `tome_static_super_cache` | Keeps Tome Static's caches warm across ordinary cache clears; adds a Views cache plugin. |
| **Tome Sync Autoclean** | `tome_sync_autoclean` | *(Experimental)* automatically runs the file-cleanup step on every export. |

Each submodule has its own documentation tree under
`modules/<name>/1.16.x/` with the deeper detail.
