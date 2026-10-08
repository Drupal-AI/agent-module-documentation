# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11`).
- **PHP 8.2+**.
- Core's **System** module (`system`) — always present.
- [`league/commonmark`](https://commonmark.thephpleague.com/) for Markdown rendering,
  installed automatically via Composer.
- **For editing only:** the [MDX Editor](https://www.drupal.org/project/mdxeditor) module,
  required by the optional `md_navigator_editor` submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/md_navigator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `league/commonmark` and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/md_navigator -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en md_navigator -y
```

The base module gives you read‑only browsing of Markdown files. It has no dependency on
MDX Editor.

## Submodule — optional editing

To add create‑and‑edit capability, first install MDX Editor, then enable the editor
submodule:

```bash
composer require drupal/mdxeditor -W
drush en md_navigator_editor -y
```

This lets you create new `.md` files and edit existing ones with a rich Markdown toolbar,
saving changes back to the filesystem. Leave it disabled if you only need to read.

## Verify it worked

Log in as a user with the MD Navigator permission and open the browser from the admin. Once
you configure a starting directory (see "How to use it" in the [overview](../index.md)),
the left panel should list the Markdown files under it, and clicking one should render it on
the right.
