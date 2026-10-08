# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`michelf/php-markdown`** PHP library, which converts your Markdown
  changelog into HTML for display. The module declares this dependency, so
  Composer installs it for you automatically.
- No JavaScript library requirements.

> **Heads‑up:** This project is *not covered* by Drupal's security advisory
> policy, and the view‑changelog permission grants reading of files from disk.
> Factor both into your decision before using it on a public or sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/changelog_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the
`michelf/php-markdown` library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/changelog_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en changelog_preview -y
```

## Verify it worked

As an administrator, visit `/admin/changelog_manage`. You should reach the
Changelog Preview settings form, where you can register a changelog file. See
[Configuration](../configuration/index.md) for the next steps.
