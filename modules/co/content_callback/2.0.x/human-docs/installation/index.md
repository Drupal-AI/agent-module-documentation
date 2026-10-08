# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Field** (`field`) and **Options** (`options`) modules — both part of core,
  enabled automatically as dependencies.

There are no additional PHP libraries or third‑party Composer requirements. This
project is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/content_callback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_callback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_callback -y
```

## Submodules

Content callback ships several optional submodules — enable only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Block** | `content_callback_block` | Lets you place content callbacks as blocks. |
| **Views** | `content_callback_views` | Adds a custom Views display that becomes selectable through the Content callback field (making the view searchable). |
| **Examples** | `content_callback_examples` | Example plugins (Basic, Options, Alter, Filter) for developers to copy. |

For example:

```bash
drush en content_callback_views -y
```

## Verify it worked

Add a **Content callback** field to a content type (Manage fields), then create a
node of that type and confirm the field's widget shows a select list of available
callback plugins. If the list is empty, no callback plugins are defined yet — enable
`content_callback_examples` or have a developer add `@ContentCallback` plugins.
