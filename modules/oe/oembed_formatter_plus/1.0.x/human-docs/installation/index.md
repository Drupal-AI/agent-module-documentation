# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** module (`media`) enabled — this is the only dependency, and you
  need at least one Media type with a **"Remote video"** source to use the
  formatter.
- No modules outside Drupal core are required.

> **Note:** This release is a release candidate (`1.0.0-rc1`) and, at the time of
> writing, is **not covered by Drupal's security advisory policy**. Review it before
> relying on it in production, and keep it updated.

## Install with Composer

From the project root:

```bash
composer require drupal/oembed_formatter_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oembed_formatter_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oembed_formatter_plus -y
```

Drupal will enable core Media as a dependency if it isn't already on.

## Verify it worked

Go to a **Remote video** media type's **Manage display** tab and change the *Video
URL* field's format to **"oEmbed formatter plus content."** If that format appears
in the list and its settings (the gear icon in Claro) offer the Trusted Providers
and iframe‑title options, the module is working. View a remote video to confirm it
renders as expected. Full field‑by‑field setup is in the
[overview](../index.md#how-to-use-it).
