# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Feeds** module (`feeds`) — this fetcher/parser plugs into Feeds.
- The **Permanent Cache Bin** module (`pcb`) — a dependency of this module.
- An **Instagram Business Account** connected to a **Facebook page** you
  administer, plus a Facebook Developer App providing an **App ID** and **App
  Secret** (see the module's
  [project page](https://www.drupal.org/project/feeds_instagram) and the Instagram
  Graph API Getting Started guide).

This module requires the **`facebook/graph-sdk`** PHP library (`^5.0`). Composer
pulls it in automatically when you install the module.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_instagram -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds, Permanent
Cache Bin and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_instagram -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_instagram -y
```

Drupal enables the Feeds and Permanent Cache Bin dependencies automatically.

## A note on credentials

The module authenticates to the Facebook (Meta) Graph API with a Facebook **App
ID** and **App Secret**, which you enter in the fetcher configuration on the feed
type. Each feed is then authenticated to Facebook through the module's built-in
OAuth 2.0 login flow; the access token the flow returns is obtained and cached by
the module (it is not entered by hand).

## Verify it worked

Create a feed type at **Structure → Feed types** and confirm that the **Instagram**
fetcher and parser appear in the fetcher and parser options. Once your App ID and
App Secret are entered and a feed is authenticated, run a small import to confirm
media comes back.
