# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Config Pages** (`config_pages`) — provides the fielded settings-page entities
  this module makes domain-aware.
- **Domain** (`domain`) — the Domain Access module that provides the domain records
  the context plugin keys on.
- No separate PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_config_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Config Pages and Domain if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_config_pages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_config_pages -y
```

## Turn on the domain context

Enabling the module does not, by itself, change any config page. You must enable
the domain context per config page type:

1. Go to **Structure → Config pages types**
   (`/admin/structure/config_pages/types/manage`).
2. Edit the config page type you want to make domain-aware and enable its domain
   context.
3. Optionally set a default domain context as the fallback for domains without
   their own value.

## Verify it worked

Edit a config page whose type has the domain context enabled. You should be able
to enter and save different values per domain, and each domain should see its own
values where that config page is rendered. Load two different domains to confirm
they show their own values rather than sharing one.
