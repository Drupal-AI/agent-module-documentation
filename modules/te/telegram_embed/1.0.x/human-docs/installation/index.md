# Installation

## Requirements

Telegram Embed is lightweight and has no contrib dependencies. It needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Filter** module (`filter`) — this is a declared dependency and Drupal
  enables it automatically.
- Core's **CKEditor 5** (`ckeditor5`), since the module's insert experience is a
  CKEditor 5 toolbar button.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/telegram_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/telegram_embed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en telegram_embed -y
```

Enabling the module makes the toolbar button and the text filter *available*, but
it does not turn them on for any text format yet. Continue with
[Configuration](../configuration/index.md) to add the button and enable the filter
— without that step nothing changes for editors.

## Verify it worked

After completing the configuration step, edit a piece of content using the text
format you set up. You should see a **Telegram Post** button in the CKEditor 5
toolbar. Click it, paste a `https://t.me/channel/123` URL, save, and view the page
— the embedded Telegram post should render in place of the link.
