# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No hand‑managed contributed dependencies — all of the module's external
  dependencies are installed and managed automatically via **Composer**, so
  always install it with Composer rather than by unzipping.
- **API access** for each streaming service you plan to use (Spotify, Last.fm,
  MusicBrainz) — typically a private/public key pair obtained from the service.

> This is a development release (`1.1.x-dev`) and is marked *not covered* by the
> security advisory policy. Review it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/musica -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — important here, because Musica pulls in its own external
libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/musica -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en musica -y
```

## After enabling

- **Grant the module's permission(s)** at **People → Permissions**
  (`/admin/people/permissions`) to the roles that should use the integration.
- **Supply each provider's API credentials** securely — backed by environment
  variables (and a Key entity where supported), never committed to version
  control. See "How to use it" in the [overview](../index.md) for the recommended
  DDEV + Key pattern.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`) or with
`drush pml --filter=musica`. Once you have entered valid credentials for at least
one provider, use the bundled Views (or the client layer) to run a track search
and confirm results come back from that service.
