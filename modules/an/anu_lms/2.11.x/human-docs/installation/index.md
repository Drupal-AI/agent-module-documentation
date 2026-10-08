# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Two REST‑serialisation dependencies that let a lesson tree be returned in one
  response:
  - **`rest_entity_recursive`**
  - **`rest_paragraphs_recursive`**

> **Read this before installing.** On **Drupal 11.4**, `rest_entity_recursive`
> fatals when its class loads — a verified PHP return‑type incompatibility (the
> contrib normalizer widens a return type that core narrowed, which PHP forbids, so
> the class cannot load). The fatal appeared in a live response and took Drush down
> with it, needing a direct `core.extension` edit to recover. **Anu LMS itself is
> not at fault — the dependency is.** Confirm `rest_entity_recursive` has a release
> matching your exact core version *before* you install.

## Install with Composer

From the project root:

```bash
composer require drupal/anu_lms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the recursive‑REST dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/anu_lms -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anu_lms -y
```

If enabling triggers the `rest_entity_recursive` fatal described above, that
dependency is incompatible with your core version. Recovery may require removing the
affected modules from `core.extension` directly. Verify compatibility first to avoid
this.
