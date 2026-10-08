# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Social Link Field** module (`social_link_field`) — a hard dependency, pulled
  in by Composer. This module extends it.
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/fediverse_social_link_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in Social Link Field.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fediverse_social_link_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fediverse_social_link_field -y
```

This enables the module (and Social Link Field if it was not already on).

## Verify it worked

Add or edit a **Social Link Field** on an entity (for example a user profile), then
check the field's platform options — the Fediverse networks (a generic Fediverse
option, Mastodon, Lemmy, and Hubzilla) should now be listed. Add a Fediverse account
link and confirm it displays via the field's formatter on the entity.
