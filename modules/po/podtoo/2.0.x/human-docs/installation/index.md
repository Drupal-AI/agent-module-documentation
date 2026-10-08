# Installation

## Requirements

- **Drupal 9.2.9, 10, or 11** (`core_version_requirement: ^9.2.9 || ^10 || ^11`).
- Core's **Media** (`media`) module enabled.
- Because PodToo embeds are fetched from PodToo's oEmbed API, the site must be able
  to reach `https://embed.podtoo.com` over the network.

## Install with Composer

From the project root:

```bash
composer require drupal/podtoo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/podtoo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en podtoo -y
```

## Verify it worked

1. Visit **Configuration → Media → PodToo** (`/admin/config/media/podtoo`) and
   confirm the settings form loads.
2. Create a **PodToo** media type (**Structure → Media types → Add media type**),
   choosing the PodToo source.
3. Add a piece of media by pasting a `https://embed.podtoo.com/*` or
   `https://podcasts.podtoo.com/*` URL, and confirm the PodToo player renders.
