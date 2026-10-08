# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Content Moderation** enabled, with a workflow applied to your content
  types. The module assumes a **`draft`** workflow state exists.

There are no contrib module dependencies and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_state_form_knockout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_state_form_knockout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_state_form_knockout -y
```

There is nothing to configure — the module acts on node add/edit forms
immediately once enabled.

## Verify it worked

Open any node's edit form for a content type under Content Moderation. The
**moderation state** widget should be visible but disabled (greyed out), showing
the current state without letting you change it inline. Remember this is a
UI-only measure — actual transition control still comes from Content Moderation's
permissions, as explained in the [main guide](../index.md).
