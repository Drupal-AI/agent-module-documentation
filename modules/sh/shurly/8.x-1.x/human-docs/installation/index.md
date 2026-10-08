# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module (`views`) — a hard dependency, because every ShURLy listing
  (the admin overview, the `/myurls` page) is built with Views.

There are no third-party PHP library requirements.

> **Heads up:** this 8.x branch is a **beta** (`8.x-1.0-beta4`) and its most recent
> release is from 2024. The maintainers describe the D8+ version as still in
> development, so test it carefully before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/shurly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shurly -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shurly -y
```

## Submodules — enable only what you need

ShURLy ships two optional submodules; enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ShURLy Analytics** | `shurly_analytics` | Click statistics for your short URLs. |
| **ShURLy Service** | `shurly_service` | A web-services API to shorten and expand URLs programmatically. |

For example, to add click statistics:

```bash
drush en shurly_analytics -y
```

## A note on where short URLs live

Because short URLs are created at the root path of the site
(`http://example.com/myURL`), ShURLy is best used as the basis for a site dedicated to
short links rather than bolted onto an existing content-heavy site. The module does
its best to avoid clashing with existing menu paths and aliases, but keep that root-path
behaviour in mind.

## Next step

After enabling, set up permissions and (optionally) rate limiting before you let
people create links — see [Configuration](../configuration/index.md).
