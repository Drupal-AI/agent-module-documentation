# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`). The `1.2.x`
  branch targets modern Drupal; earlier branches exist for Drupal 8.8 (`1.0.0`) and
  Drupal 9 (`1.1.x`).
- Core's **User** module (`user`) — the only dependency, always present in a standard
  Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

Because Factory Lollipop is a testing tool with no production role, install it as a
**dev** dependency so it never ships to production:

```bash
composer require --dev drupal/factory_lollipop
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/factory_lollipop`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en factory_lollipop -y
```

## Submodule — optional

One submodule ships with the project:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Factory Lollipop - Paragraphs** | `factory_lollipop_paragraphs` | Adds `paragraph` and `paragraph type` factory types for building Paragraphs entities/bundles in tests. Requires the contrib **Paragraphs** module. |

Enable it only if you need paragraph factories:

```bash
drush en factory_lollipop_paragraphs -y
```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep
factory_lollipop`. From there, Factory Lollipop is exercised from your test and
setup code rather than the admin UI — write a factory blueprint and instantiate it in
a test to confirm it produces a valid object.
