# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Feeds** module (`feeds`) — this fetcher plugs into Feeds.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_fetcher_post -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_fetcher_post -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_fetcher_post -y
```

Drupal enables the Feeds dependency automatically if it isn't already on.

## A note on secrets

If your POST body or headers include an API key or other credential, remember that
what you configure is saved with the feed type's configuration and can be exported
to version control. Prefer a token reference that is resolved at request time over
a literal secret value, and use HTTPS endpoints so credentials aren't sent in
cleartext.

## Verify it worked

Create or edit a feed type at **Structure → Feed types** and confirm that
**Download From URL additional POST parameters** appears in the **Fetcher**
options.
