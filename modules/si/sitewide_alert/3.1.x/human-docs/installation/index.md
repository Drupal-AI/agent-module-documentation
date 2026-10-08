# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Three core modules, which Drupal enables automatically as dependencies:
  **Datetime Range** (`datetime_range`, for scheduling), **Options**
  (`options`, for the style list), and **Text** (`text`, for the message body).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sitewide_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sitewide_alert -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitewide_alert -y
```

## Submodules — enable only what you need

Sitewide Alert ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Sitewide Alert Block** | `sitewide_alert_block` | Renders alerts inside a placeable block (via **Structure → Block layout**) instead of forcibly at the top of the page — useful when your theme has a dedicated region for notices. |
| **Sitewide Alert Domain** | `sitewide_alert_domain` | *Experimental.* Scopes alerts to specific domains using the Domain Access Entity module — only relevant on a multi-domain install. |

```bash
drush en sitewide_alert_block -y
```

## Verify it worked

Grant the **view published sitewide alert entities** permission to the roles that
should see banners, then create an active alert at **Content → Sitewide alerts →
Add**. Reload the front page and the banner should appear at the top. If it
doesn't, confirm the alert is marked **Active** and that the viewing role has the
permission above (it also gates the `/sitewide_alert/load` endpoint the banner
reads from).
