# Installation

## Requirements

Anonymous Login is lightweight and has no third-party libraries. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Path alias** module (`path_alias`) — this is enabled by default on
  most sites, and Drupal turns it on automatically as a dependency if it is not.

There are no Composer or PHP library requirements beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/anonymous_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/anonymous_login -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en anonymous_login -y
```

Enabling the module changes nothing on its own — no paths are protected until
you configure them. Head to [Configuration](../configuration/index.md) to add
the paths you want to lock behind login.

> **Careful with a site-wide include.** If you add `*` (protect everything),
> make sure you can still reach the login form — the login page, `.php`
> requests, and password-reset links are always excluded, so you will not lock
> yourself out, but test with an incognito window before you rely on it.
