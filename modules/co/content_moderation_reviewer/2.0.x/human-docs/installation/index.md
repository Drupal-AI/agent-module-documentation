# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Workflows** (`workflows`) and **Content Moderation**
  (`content_moderation`) modules enabled. Drupal will pull these in automatically
  as dependencies when you enable Content Moderation Reviewer.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_reviewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_reviewer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_reviewer -y
```

## Verify it worked

You need a Content Moderation workflow applied to at least one content type. Edit
a piece of content of that type and look just below the **Moderation state**
dropdown — you should see a new **Moderation reviewer** autocomplete field. If it
appears, the module is working. See the main guide's
[How to use it](../index.md#how-to-use-it) section for assigning reviewers.
