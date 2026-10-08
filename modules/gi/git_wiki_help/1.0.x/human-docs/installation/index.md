# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Help** (`help`), **File** (`file`), and **Filter** (`filter`) modules.
- The **league/commonmark** Markdown library — installed automatically when you
  require the module with Composer.
- Access to a **Git wiki repository** that you can clone onto the server.

## Install with Composer

From the project root:

```bash
composer require drupal/git_wiki_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the CommonMark
Markdown library and update any shared dependencies as needed. (Installing with
Composer is important here so the library dependency is resolved.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/git_wiki_help -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en git_wiki_help -y
```

## Clone your wiki

Remember the module does not fetch anything itself. Clone your wiki into the
directory you'll configure (if you leave the setting blank, the default directory
`git_wiki_help` is used). You are responsible for keeping that clone up to date.

## Verify it worked

After enabling the module and cloning your wiki, set the directory and text format
on the [Configuration](../configuration/index.md) page, then open **Help** and
look for the **Git wiki help** section. Your wiki pages should be listed and
render as HTML.
