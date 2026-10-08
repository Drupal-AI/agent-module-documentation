# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — the only dependency, enabled
  automatically.

There are no third‑party Composer or PHP library requirements for the base module.

## Install with Composer

From the project root — note the Composer package is **`drupal/etm`**:

```bash
composer require drupal/etm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/etm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The machine name is **`enhanced_taxonomy_manager`**, not `etm`:

```bash
drush en enhanced_taxonomy_manager -y
```

## Optional: the AI submodule

To add AI‑driven features (term generation, placement suggestions, semantic
duplicate detection, auto‑description, health analysis, natural‑language search),
enable the bundled submodule:

```bash
drush en etm_ai -y
```

It requires the base module, which is already present once you've installed above.
(The AI submodule will need an AI provider configured — set that up separately.)

## Verify it worked

Go to **Structure → Taxonomy**, open any vocabulary, and you should now land on
ETM's tree view (`/admin/structure/taxonomy/{vocabulary}/tree`) with drag‑and‑drop
reordering, search and the ETM toolbar. The **ETM dashboard** should appear at
`/admin/structure/taxonomy/etm-dashboard`.
