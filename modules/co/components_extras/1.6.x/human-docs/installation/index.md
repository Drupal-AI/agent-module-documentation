# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Components** module (`components`) — the Composer constraint accepts
  `^1.0|^2.0@beta|^3.0@beta`, so it will pull in Components 1.x, or a 2.x/3.x beta
  if that is what resolves. Pin Components explicitly if you need to stay on a
  particular branch.

There are no other third‑party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/components_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Components
module and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/components_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en components_extras -y
```

This enables the Components module as a dependency if it is not already on.

## Verify it worked

There is nothing user-visible to check — it is a developer API. Confirm it works
by rendering a Components component through the module's render element from a
render array in your own code and seeing it output correctly.
