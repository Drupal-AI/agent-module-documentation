# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled — this is the module's dependency.
- No third‑party Composer or PHP library requirements.

**Recommended companions** (not required):

- [oEmbed providers](https://www.drupal.org/project/oembed_providers) — for
  managing which providers are available.
- [Key](https://www.drupal.org/project/key) — for a more secure way to handle any
  credentials (for example the Instagram authentication option), so secrets aren't
  stored in plain configuration.

> **Note:** This release is a beta (`1.0.0-beta5`). Review it before relying on it
> in production, and keep it updated.

## Install with Composer

From the project root:

```bash
composer require drupal/oembed_configuration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oembed_configuration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oembed_configuration -y
```

Drupal will enable core Media as a dependency if it isn't already on.

## Verify it worked

Log in as an administrator and go to **Configuration → Media → oEmbed
Configuration**. If the settings form loads, the module is active. Set the options
you want (see [Configuration](../configuration/index.md)), then view a page with an
oEmbed video to confirm your parameters — autoplay, do‑not‑track, and so on — take
effect.
