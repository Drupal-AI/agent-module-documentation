# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and it powers the rich-text editor the plugin extends.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_indentblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_indentblock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_indentblock -y
```

Enabling the module doesn't change any editor by itself — paragraph indentation
is turned on per text format. See [Configuration](../configuration/index.md) for
the three things you need to set on a format.

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**). In the format's settings you should now see an **Indent block**
vertical tab with an **Enable indentation on paragraphs** checkbox. If it's
there, the module is active — continue with
[Configuration](../configuration/index.md).
