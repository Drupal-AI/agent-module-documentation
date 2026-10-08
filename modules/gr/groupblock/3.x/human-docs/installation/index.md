# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`). Use this
  **3.x** release with Group 3.2.
- Core's **Block** (`block`) and **Custom Block** (`block_content`) modules, which
  provide the custom blocks being related.
- Core's **Views** module is needed for the shipped Blocks overview link to appear.

The dependencies are enabled automatically when you enable Group Block.

## Install with Composer

From the project root:

```bash
composer require drupal/groupblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/groupblock -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en groupblock -y
```

## Verify it worked

On one of your group types, open the **Set available content** operation and
confirm you can install a **Group block (<block type>)** plugin. Install it, grant
a group role the block permissions, then visit a group and confirm the **Blocks**
operation link appears and that you can add a block at `group/{group}/block/add`.
