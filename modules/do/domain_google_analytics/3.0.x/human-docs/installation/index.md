# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Domain** (`domain`) — the Domain Access module. It provides the domain records
  each analytics configuration attaches to. Note that it is **not pulled in
  automatically** by this module's metadata, so make sure it is installed and
  enabled.
- A **Google Analytics account** with a measurement/tracking ID for each domain
  you want to track.
- No separate PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_google_analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If the Domain module is not already present, install it as
well:

```bash
composer require drupal/domain -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_google_analytics -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

**Watch the machine name.** The Composer/project name is
`domain_google_analytics`, but the module it ships is
**`multidomain_google_analytics`** — so `drush en domain_google_analytics` fails.
Enable it with the correct name:

```bash
drush en multidomain_google_analytics -y
```

Enabling it without the Domain module present will also fail on the missing
dependency, so enable `domain` first if needed:

```bash
drush en domain -y
drush en multidomain_google_analytics -y
```

## Set up your domains first

If you have not already, create your domain records on the Domain module's
configuration page at **Configuration → Domain** (`/admin/config/domain`). You
need those records before you can assign tracking codes to them.

## Verify it worked

Go to **Configuration → System → Multidomain Google Analytics**
(`/admin/config/system/multidomain-google-analytics`) and confirm the form lists
your domains with a field for each tracking code. After entering codes (see
[Configuration](../configuration/index.md)), load a page on one of the domains and
view its source — the correct Google Analytics code for that domain should be
present.
