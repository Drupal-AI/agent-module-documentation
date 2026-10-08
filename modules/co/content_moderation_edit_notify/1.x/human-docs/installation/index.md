# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Content Moderation** (`content_moderation`) and **Workflows**
  (`workflows`) modules, with a workflow applied to the content you want to protect.
- Core's **Node** (`node`) and **Filter** (`filter`) modules.

Drupal will enable these dependencies automatically. There are no third‑party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_edit_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_edit_notify -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_edit_notify -y
```

## Verify it worked

The simplest test is to simulate a concurrent edit. In one browser, open a moderated
content item for editing and leave the form open. In a second browser (or an
incognito window, as a different user), edit and save a new revision of the same
item. Within about half a minute — the default check interval — a warning should
appear at the top of the form in the first browser, above the save button, telling
you a newer revision now exists.
