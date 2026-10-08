# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- **[Migrate Plus](https://www.drupal.org/project/migrate_plus)**
  (`migrate_plus`) — a required dependency, pulled in by Composer.
- A **Google / YouTube Data API key** with access to the YouTube Data API v3.
- Recommended: **[Migrate Tools](https://www.drupal.org/project/migrate_tools)**
  (`migrate_tools`) for running and managing the migrations from Drush.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_youtube -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Migrate Plus. To add the recommended tools
module as well:

```bash
composer require drupal/migrate_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_youtube -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_youtube -y
```

## Store your YouTube API key securely

The module reads your key from the `youtube_api_key` setting. **Never hard-code or
commit the key** — keep it in an environment variable and reference that from
`settings.php`.

With DDEV, save the value into DDEV's dotenv file and restart so it is loaded into
the web container:

```bash
ddev dotenv set .ddev/.env --youtube-api-key=your-own-1234567-API-KEY-here
ddev restart
```

The flag `--youtube-api-key` becomes the environment variable
`YOUTUBE_API_KEY`. Do not commit `.ddev/.env`. You can confirm the variable is
present in the container **without printing its value**:

```bash
ddev exec 'test -n "$YOUTUBE_API_KEY"'   # exit status 0 means it is set
```

Then, in your site's `settings.php` (or `settings.local.php`), read it from the
environment rather than pasting the literal key:

```php
$settings['youtube_api_key'] = getenv('YOUTUBE_API_KEY');
```

(If you are not using DDEV, set `YOUTUBE_API_KEY` in your own environment — for
example in your web server or container configuration — and use the same
`getenv()` line.)

## Verify it worked

With the module enabled and the key in place, write a migration that uses the
`migrate_youtube_api_playlist_items` source plugin (see the
[main guide](../index.md)), then run `drush migrate:status` to confirm it is
registered and `drush migrate:import <migration_id>` to pull videos from your
playlist. If the API key is missing or invalid, the import will fail to fetch
data — check that `youtube_api_key` is set.
