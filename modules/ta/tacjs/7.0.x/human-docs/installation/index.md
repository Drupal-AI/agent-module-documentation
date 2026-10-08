# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- No PHP library or module dependencies for the base module — but it **does** need the
  external tarteaucitron.js JavaScript library (see below).

## Install the module with Composer

From the project root:

```bash
composer require drupal/tacjs -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tacjs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the tarteaucitron.js library (required)

The consent library itself is **not** shipped with the module — it must live in
`web/libraries/tarteaucitronjs`. The easiest way is via the npm‑asset package:

```bash
composer require npm-asset/tarteaucitronjs:~1.21.0
```

Alternatively, download a release from the tarteaucitron.js GitHub repository and
place it so that the files end up under `web/libraries/tarteaucitronjs`. The language
files under `libraries/tarteaucitronjs/lang/` are picked up automatically.

Until the library is present, Drupal's **status report** (`/admin/reports/status`)
shows an error and the banner will not work.

## Enable the module

```bash
drush en tacjs -y
```

## Optional submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **TacJS Log** | `tacjs_log` | Records proof of consent (timestamp, IP, accepted services) to a database table and shows a paged overview report at `/admin/config/system/tacjs/overview`. |
| **TacJS Media** | `tacjs_media` | A consent‑aware oEmbed field formatter (`tacjs_oembed`) so remote video embeds stay blocked until the visitor consents. |

Enable them individually, for example:

```bash
drush en tacjs_log -y
```

## Verify it worked

Check **Reports → Status report** (`/admin/reports/status`) — the tarteaucitron
library check should pass. Then load a non‑admin page as an anonymous visitor; the
consent banner should appear once you've enabled at least one service. Continue to
[Configuration](../configuration/index.md).
