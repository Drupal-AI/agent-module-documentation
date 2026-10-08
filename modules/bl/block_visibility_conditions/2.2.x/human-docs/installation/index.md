# Installation

## Requirements

Block Visibility Conditions is lightweight and has no third-party libraries. It
needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **Block** module (enabled on standard installs).

The three optional submodules each add one dependency when enabled:

- **Node** submodule needs core's **Node** module.
- **Taxonomy** submodule needs core's **Taxonomy** module.
- **Commerce** submodule needs **Commerce** (`commerce_product`).

## Install with Composer

From the project root:

```bash
composer require drupal/block_visibility_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_visibility_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with whichever submodule(s) provide the
conditions you want. The base module on its own only supplies the shared base
class — you need at least one submodule to get a usable condition:

```bash
drush en block_visibility_conditions block_visibility_conditions_node -y
```

## Submodules — enable only what you need

| Submodule | Machine name | Condition it adds | Requires |
|-----------|--------------|-------------------|----------|
| **Node** | `block_visibility_conditions_node` | *Not Node Type* (`not_node_type`) | Node |
| **Taxonomy** | `block_visibility_conditions_taxonomy` | *Not Taxonomy Vocabulary* (`not_taxonomy_vocabulary`) | Taxonomy |
| **Commerce** | `block_visibility_conditions_commerce` | *Not Product Type* (`not_product_type`) | Commerce |

Enable any combination:

```bash
drush en block_visibility_conditions_taxonomy block_visibility_conditions_commerce -y
```

> If you are upgrading from an older release, update hook `9001` automatically
> enables the Node and Taxonomy submodules to preserve the old behavior.

## Verify it worked

Go to **Structure → Block layout**, configure any block, and open its
**Visibility** section. You should see the new condition (for example **Not Node
Type**) with a checkbox list of your bundles. See the module's
[overview](../index.md#how-to-use-it) for how to configure a block.
