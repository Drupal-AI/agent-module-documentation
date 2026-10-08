# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity API** module (`entity`).
- The **Inline Entity Form** module (`inline_entity_form`) — used to assemble
  components.

## Install with Composer

The maintainers recommend installing the dependencies explicitly at the versions
they test against, then the module itself. From the project root:

```bash
composer require 'drupal/inline_entity_form:^1.0@RC'
composer require 'drupal/entity:^1.3'
composer require drupal/component_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Component Builder together with its toolbar submodule:

```bash
drush en component_builder component_builder_toolbar -y
```

## Submodules

- **Component Builder Toolbar** (`component_builder_toolbar`) — adds the toolbar
  integration for the builder. Most installations enable it alongside the base
  module, as shown above.

## Verify it worked

After enabling, activate one or more component types from the module's
administration, add a Component Builder field to a content type, then create a
node of that type — you should be taken to the drag-and-drop Builder page where
you can add and arrange components.
