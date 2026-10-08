# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **hu‑manity.co / cookie‑compliance.co account** — register your domain there to
  obtain an App ID before the banner can work.

There are no module dependencies and no third‑party PHP or JavaScript library
requirements (the banner script is loaded at runtime from hu‑manity.co's CDN).

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_compliance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_compliance -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_compliance -y
```

Enabling alone does not show the banner — you must enter an App ID and tick the
enable box.

## Verify it worked

After configuring (see [Configuration](../configuration/index.md)), load any page
and view the HTML source. You should see an inline `huOptions` script whose `appID`
matches yours, followed by a `<script src="https://cdn.hu-manity.co/hu-banner.min.js">`
tag in the `<head>`. That confirms the banner is wired in.
