# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it automatically as a
  dependency.
- No third‑party Composer or PHP library requirements.

### Recommended companions (optional)

Block Visibility Groups uses Drupal's condition plugins, so the more condition
plugins you have installed, the richer your groups can be. None of these are
required, but they are commonly paired with it:

| Module | What it adds |
|--------|--------------|
| [CTools](https://www.drupal.org/project/ctools) | Extra condition plugins, including entity‑bundle conditions. Widely recommended. |
| [Menu Condition](https://www.drupal.org/project/menu_condition) | A condition based on menu position. |
| [Term Condition](https://www.drupal.org/project/term_condition) | A condition checking whether the current node has a specific taxonomy term. |
| [Token Conditions](https://www.drupal.org/project/token_conditions) | A simple token‑matching condition. |

## Install with Composer

From the project root:

```bash
composer require drupal/block_visibility_groups -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Add any of the optional condition modules the same way,
for example `composer require drupal/ctools -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_visibility_groups -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_visibility_groups -y
```

The module ships **no submodules**. Managing groups requires core's **Administer
blocks** permission:

```bash
drush role:perm:add site_manager 'administer blocks'
```

## Next steps

Head to **Structure → Block Layout → Block Visibility Groups** to create your first
group — see the [overview](../index.md#how-to-use-it) for the full walkthrough.
