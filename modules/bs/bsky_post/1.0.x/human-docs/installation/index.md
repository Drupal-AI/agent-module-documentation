# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **BlueSky Integration** module (`bsky`) — Bluesky Post depends on it for
  the API client and credential storage. Set `bsky` up first, including storing
  your Bluesky app password securely (see its
  [installation guide](../../../bsky/1.0.x/human-docs/installation/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/bsky_post -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the `bsky` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bsky_post -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bsky_post -y
```

Drupal enables `bsky` automatically as a dependency.

## Set permissions

At **People → Permissions** grant:

- **administer bsky_post configuration** — to trusted admins who set up the
  posting behavior and target account.
- **post to bluesky** — to the roles allowed to publish content to Bluesky.
