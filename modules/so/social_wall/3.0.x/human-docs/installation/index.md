# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Two PHP libraries, installed automatically by Composer as dependencies:
  - `abraham/twitteroauth ^2` — for Twitter/X.
  - `pgrimaud/instagram-user-feed ^6 || ^7` — for Instagram.
- **Workable API access for each network you want** — this is the real
  prerequisite. See the caution in the [main guide](../index.md): Twitter/X's API
  is now paid, and Instagram's Basic Display API has been retired in favour of a
  business/creator-only Graph API. Confirm you can obtain access before investing
  in setup.

## Install with Composer

Because Social Wall pulls in the two libraries above, install it with Composer so
they are resolved for you:

```bash
composer require drupal/social_wall -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pull in `abraham/twitteroauth` and
`pgrimaud/instagram-user-feed`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_wall -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_wall -y
```

## Verify it worked

Go to **Configuration → Web services → Social Wall**
(`/admin/config/services/social-wall`) and confirm the network-management page
opens. Nothing will display on the wall until you add a network and give it valid,
currently available API credentials — see [Configuration](../configuration/index.md).
