# Installation

## Requirements

Flags 2.1.x needs:

- **Drupal 11.3 or newer, or Drupal 12** (`core_version_requirement: ^11.3 || ^12`).
  On Drupal 9 or 10, use the 2.0.x branch instead.
- Nothing else for the base module — it has no other module dependencies and no
  third‑party libraries.

Some optional pieces have their own needs:

- The flag‑decorated **select** widgets in the field submodules require the
  **Select Icons** module.
- **Flags: Country** (`flags_country`) requires the contrib **Country** module.
- **Flags: Language Field** (`flags_languagefield`) integrates with the contrib
  **Language Field** module.

## Install with Composer

From the project root:

```bash
composer require drupal/flags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flags -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flags -y
```

The base module gives you the flag rendering (the `flags` theme hook), the mapping
API, and the mapping config entities — but no UI or field integration on its own.

## Submodules — enable only what you need

Flags ships four optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Flags: Country** | `flags_country` | A formatter and select/autocomplete widgets for country fields, previewing flags (requires the Country module). |
| **Flags: Language** | `flags_language` | A formatter and widget for the core language field, plus flags on the language‑switcher block and its links. |
| **Flags: Language Field** | `flags_languagefield` | A formatter and widget for the contrib Language Field module. |
| **Flags: UI** | `flags_ui` | Admin screens to create and edit code‑to‑flag mapping overrides, behind the *Administer flag mapping* permission. |

For example, to add country‑field flags and the mapping admin UI:

```bash
drush en flags_country flags_ui -y
```

Each submodule requires the base Flags module, which is already present once you
have installed it above. To manage mapping overrides, see
[Configuration](../configuration/index.md).
