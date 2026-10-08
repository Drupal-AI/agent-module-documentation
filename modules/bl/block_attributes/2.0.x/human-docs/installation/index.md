# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Block
  Attributes.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_attributes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_attributes -y
```

There are no submodules. Out of the box the module defines one attribute,
`class`, so an **Attributes** section with a *class* field appears on every
block's configuration form immediately. To add more attributes, or offer
editors preset value dropdowns, head to
[Configuration](../configuration/index.md).

> **Tip:** the global attribute list is edited as raw YAML. Installing the
> optional [YAML Editor](https://www.drupal.org/project/yaml_editor) module gives
> that textarea syntax highlighting, which makes editing the list more
> comfortable — but it is not required.
