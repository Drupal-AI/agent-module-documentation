# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11`; the
  project also reports Drupal 12 compatibility).
- A **Mastodon account** on an instance where you can register an application (you
  need permission to create apps under **Preferences → Development**).
- Network **egress** from your Drupal site to the Mastodon instance you connect to.

There are no additional Composer or PHP library requirements beyond the module.

## Install with Composer

From the project root:

```bash
composer require drupal/mastodon_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mastodon_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mastodon_api -y
```

## Submodules — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mastodon API Entity** | `mastodon_api_entity` | Attaches the Mastodon "push" form to a content entity type and pre‑fills it with content from the entity, so you can format an item and toot it with one click. The formatting is done via a configurable, overridable plugin. |

Enable it only if you want to toot directly from content:

```bash
drush en mastodon_api_entity -y
```

## Verify it worked

Go to **Configuration → Web services → Mastodon API**
(`/admin/config/services/mastodon`). If the page loads, the module is installed —
continue with [Configuration](../configuration/index.md) to connect an instance and
store your access token securely.
