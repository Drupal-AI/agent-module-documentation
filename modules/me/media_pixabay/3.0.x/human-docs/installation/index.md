# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).
- Core's **Media** module.
- The **Entity Browser** (`entity_browser`) module — the widget this module
  provides plugs into an entity browser.
- A **Pixabay API key** (free — register a Pixabay account to get one).
- Outbound HTTPS connectivity from your Drupal environment to `pixabay.com`.
- Optionally the **Token** module, if you want to use tokens (such as
  `[PIXABAY_SEARCH_TERM]`) in the upload‑location path.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_pixabay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including Entity Browser — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_pixabay -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_pixabay -y
```

Drupal will enable the Entity Browser dependency at the same time.

## Verify it worked

Log in as an administrator and visit **Configuration → Media → Pixabay**
(`/admin/config/media/pixabay`). If the settings page loads, the module is
installed. You must enter your Pixabay API key there and add the widget to an
Entity Browser before editors can search — see
[Configuration](../configuration/index.md).
