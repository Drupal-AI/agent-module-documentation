# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other contrib modules are required. To protect Webforms with the bundled
  handler you will of course need the Webform module installed.
- Your server must be able to reach `www.stopforumspam.com` over the network —
  that is the external service every check queries.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/spambot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/spambot -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spambot -y
```

There are no submodules. As soon as it is enabled, Spambot begins checking new
registrations by email and IP using its default thresholds — you do not have to
configure anything to get basic protection. To tune it, add whitelists, turn on
cron scanning, or enable reporting, head to
[Configuration](../configuration/index.md).

## About the API key

If you want Spambot to *report* spammers back to Stop Forum Spam (from the per-user
Spam tab), you need a free API key from
[stopforumspam.com](https://www.stopforumspam.com). Merely *checking* visitors
does not require a key. The key is stored in Drupal configuration; treat it as a
credential and avoid committing it to a public repository.
