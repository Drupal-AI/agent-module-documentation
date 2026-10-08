# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The bundled **`cri_php_word`** submodule, which is a required dependency — it is
  part of the editics project and provides the PhpWord template engine.
- Access to a **CRI "flux" conversion server** (its URL and Basic‑auth
  credentials) — the module sends content there to produce documents.
- No separate third‑party PHP library requirement is declared beyond what the
  project ships.

Note that this project's security advisory coverage is *not* covered by the Drupal
Security Team — weigh that, and the security note in the
[overview](../index.md#contents), for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/editics -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/editics -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editics -y
```

Enabling `editics` also pulls in its required **`cri_php_word`** submodule.

## Submodules

editics bundles a few submodules:

| Submodule | Role |
|-----------|------|
| `cri_php_word` | The PhpWord‑based template engine. **Required** — enabled as a dependency of `editics`. |
| `cri_core_mapping` | Reads YAML mapping documents that describe how Drupal fields map to template placeholders (text, date, image, table, numeric, percent, etc.). Enable it to define field‑to‑placeholder mappings. |
| `cri_demo` | A demo that previews mapping output — handy while setting up, optional in production. |

Enable the optional ones as needed, for example:

```bash
drush en cri_core_mapping -y
```

## Verify it worked

Confirm the base module and its engine are on:

```bash
drush pm:list --status=enabled | grep -E 'editics|cri_'
```

The module is installed but can't generate anything until you configure the CRI
conversion server URL and credentials. Continue to
[Configuration](../configuration/index.md).
