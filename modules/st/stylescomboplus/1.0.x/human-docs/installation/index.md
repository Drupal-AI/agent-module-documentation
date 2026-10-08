# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **CKEditor** module (`ckeditor`) — this is **CKEditor 4**, the legacy
  rich-text editor, not the CKEditor 5 that ships as default from Drupal 10
  onward. The plugin only affects CKEditor 4 toolbars.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/stylescomboplus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stylescomboplus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stylescomboplus -y
```

The Composer package name (`drupal/stylescomboplus`) and the module machine name
(`stylescomboplus`) match, so the same word is used in both commands.

## Verify it worked

Enabling the module does not change anything visible on its own — you still need to
add the *Styles +* button to a text format. Go to **Configuration → Content
authoring → Text formats and editors**, edit a format that uses CKEditor, and check
that a *Styles +* button is available to drag into the toolbar. Continue with
[Configuration](../configuration/index.md).
