# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Abraham TwitterOAuth** PHP library (`abraham/twitteroauth`) — the module
  uses it to authenticate against and call the X (Twitter) API.
- A valid **X (Twitter) developer app** with an access tier that permits reading
  posts, giving you four credentials: consumer key, consumer secret, access
  token, and access token secret.

## Install with Composer

From the project root, require the module (the `-W` flag lets Composer update
shared dependencies as needed):

```bash
composer require drupal/last_tweets -W
```

If the TwitterOAuth library is not pulled in automatically, add it explicitly:

```bash
composer require abraham/twitteroauth
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/last_tweets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en last_tweets -y
```

## Verify it worked

After enabling, open the module's settings form from the **Configuration** area
and confirm it loads. You will not see any posts until you have entered valid X
API credentials and an account, and placed the **Last Tweets** block — all
covered in [Configuration](../configuration/index.md).
