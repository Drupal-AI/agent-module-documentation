# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** module (`link`) — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/linked_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linked_entity_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linked_entity_reference -y
```

Drupal enables core **Link** automatically as a dependency.

## Submodules

- **Linked Entity Reference Slick** (`linked_entity_reference_slick`) — adds
  display support for showing the references in a Slick carousel. Enable it only
  if you use the Slick module:

  ```bash
  drush en linked_entity_reference_slick -y
  ```

## Verify it worked

Go to **Structure → *(a content type)* → Manage fields → Add field**. The field
type list should now include **Linked entity reference**. Add one to a test
bundle, reference an entity, optionally enter a URL, and confirm it saves and
displays as expected.
