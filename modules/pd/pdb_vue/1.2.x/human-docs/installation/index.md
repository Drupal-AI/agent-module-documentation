# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Progressively Decoupled Blocks** base module, `pdb` (version `>= 1.0`).
  Composer installs it automatically as a dependency.

There are no third‑party PHP library requirements. Building your own Vue
components will, of course, involve a JavaScript toolchain (the examples
demonstrate both Vite and webpack), but that is developer tooling outside Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/pdb_vue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it will bring in the `pdb` base module for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdb_vue -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdb_vue -y
```

This also enables the `pdb` base module if it is not already on.

## Submodules — the example components

PDB Vue ships **eleven example submodules**. They are the module's real
documentation: enable one, look at its code, then place its block. Turn on only
what you want to study — none of them are required for the base module to work.

| Submodule | Shows |
|-----------|-------|
| `vue3_example_1`, `vue3_example_2` | **Vue 3** basics (start here) |
| `vue_example_1`, `vue_example_2` | Vue 2 basics (for maintaining existing work) |
| `vue3_vite` | building a Vue 3 block with the **Vite** toolchain |
| `vue_example_webpack` | building a block with the **webpack** toolchain |
| `vue3_pinia_a` + `vue3_pinia_b` | **shared state** across two separately placed blocks |
| `vue3_spa_component`, `vue_spa_component` | a single‑page app running inside a block |
| `vue_todo` | a small interactive Vue example |

For example, to study the Vue 3 basics:

```bash
drush en vue3_example_1 -y
```

> **Vue 2 is end‑of‑life** (since the end of 2023). Prefer the `vue3_*` examples
> for anything new.

## Verify it worked

After enabling `pdb_vue` and an example submodule, go to **Structure → Block
layout** (`/admin/structure/block`), place the example's block into a region, and
save. Visit a page that shows that region — the Vue component should render live
while Drupal renders the surrounding page. You can also open
**Configuration → Web services → Decoupled Blocks (Vue)** to confirm the Vue
settings form is present and to switch between Vue 2 and Vue 3.
