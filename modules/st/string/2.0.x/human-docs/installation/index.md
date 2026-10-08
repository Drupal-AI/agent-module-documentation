# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Locale** module (`locale`) — this is the only dependency, and it is
  what provides Drupal's translation system. Drupal will enable it automatically
  as a dependency when you turn on String.

There are no third-party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/string -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/string -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

The Composer package name (`drupal/string`) matches the module's machine name
(`string`).

## Enable the module

```bash
drush en string -y
```

If Locale is not already on, Drupal enables it at the same time.

## Submodules — enable only what you need

String ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **String i18next** | `string_i18next` | Exposes your managed strings to an i18next-based JavaScript front-end, so a decoupled or heavily interactive UI can pull translations from Drupal. |
| **String TMGMT** | `string_tmgmt` | Integrates your strings with the Translation Management Tool (TMGMT) for a managed, workflow-driven translation process. |

For example, to add the i18next integration:

```bash
drush en string_i18next -y
```

Each submodule builds on the base String module, which is already present once
you have installed it above.
